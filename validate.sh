#!/usr/bin/env bash
# CozyCreate server smoke test
# Usage: ./validate.sh
# First run installs NeoForge server automatically; subsequent runs just sync mods and test.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVER_DIR="$SCRIPT_DIR/server"
NEOFORGE_VERSION="21.1.228"
INSTALLER_URL="https://maven.neoforged.net/releases/net/neoforged/neoforge/${NEOFORGE_VERSION}/neoforge-${NEOFORGE_VERSION}-installer.jar"
BOOTSTRAP_URL="https://github.com/packwiz/packwiz-installer-bootstrap/releases/latest/download/packwiz-installer-bootstrap.jar"
SERVER_PORT=25575   # dedicated test port — avoids conflict with any real server on 25565
SERVER_TIMEOUT=300

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()  { echo -e "${BLUE}[validate]${NC} $*"; }
ok()   { echo -e "${GREEN}✔ PASS${NC}  $*"; }
fail() { echo -e "${RED}✖ FAIL${NC}  $*"; }
warn() { echo -e "${YELLOW}⚠ WARN${NC}  $*"; }
hr()   { echo "────────────────────────────────────────────"; }

SERVER_PID=""

cleanup() {
  if [[ -n "$SERVER_PID" ]] && kill -0 "$SERVER_PID" 2>/dev/null; then
    log "Stopping server..."
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

kill_port() {
  local port=$1
  local pid
  pid=$(lsof -ti :"$port" 2>/dev/null || true)
  if [[ -n "$pid" ]]; then
    warn "Port $port in use by PID $pid — killing stale process..."
    kill "$pid" 2>/dev/null || true
    sleep 1
  fi
}

# ── First-run server setup ────────────────────────────────────────────────────

setup_server() {
  log "Checking server setup..."
  mkdir -p "$SERVER_DIR"

  if [[ ! -f "$SERVER_DIR/neoforge-installer.jar" ]]; then
    log "Downloading NeoForge $NEOFORGE_VERSION installer..."
    curl -fL --progress-bar -o "$SERVER_DIR/neoforge-installer.jar" "$INSTALLER_URL"
  fi

  if [[ ! -f "$SERVER_DIR/run.sh" ]]; then
    log "Installing NeoForge server (takes ~1 min on first run)..."
    (cd "$SERVER_DIR" && java -jar neoforge-installer.jar --installServer 2>&1) \
      | grep -E "^(Considering|Extracting|Successfully)" || true
    [[ -f "$SERVER_DIR/run.sh" ]] || { fail "NeoForge install failed — run.sh not created"; exit 1; }
    chmod +x "$SERVER_DIR/run.sh"
  fi

  # Always re-write eula — safe to repeat
  echo "eula=true" > "$SERVER_DIR/eula.txt"

  # Always write server.properties so port stays correct even if file existed before
  cat > "$SERVER_DIR/server.properties" <<EOF
online-mode=false
max-players=4
view-distance=8
simulation-distance=6
motd=CozyCreate validate
spawn-protection=0
server-port=${SERVER_PORT}
EOF

  if [[ ! -f "$SERVER_DIR/packwiz-installer-bootstrap.jar" ]]; then
    log "Downloading packwiz-installer-bootstrap..."
    curl -fL --progress-bar -o "$SERVER_DIR/packwiz-installer-bootstrap.jar" "$BOOTSTRAP_URL"
  fi

  ok "Server setup ready"
}

# ── Mod sync ──────────────────────────────────────────────────────────────────

sync_mods() {
  log "Syncing mods to server..."

  # file:// avoids needing packwiz serve — simpler and no timing issues
  (cd "$SERVER_DIR" && java -jar packwiz-installer-bootstrap.jar \
    --side server "file://${SCRIPT_DIR}/pack.toml" 2>&1) \
    | grep -vE "^(Considering|Checking|Loading)" || true

  local mod_count
  mod_count=$(find "$SERVER_DIR/mods" -name "*.jar" 2>/dev/null | wc -l | tr -d ' ')
  if (( mod_count == 0 )); then
    fail "No mods found in server/mods/ after sync — check packwiz-installer output above"
    exit 1
  fi
  ok "Mods synced ($mod_count jars in server/mods/)"
}

# ── Server startup & monitoring ───────────────────────────────────────────────

run_server() {
  kill_port "$SERVER_PORT"
  log "Starting server..."
  local log_file="$SERVER_DIR/logs/latest.log"

  rm -f "$log_file"
  mkdir -p "$SERVER_DIR/logs"

  (cd "$SERVER_DIR" && ./run.sh --nogui > /dev/null 2>&1) &
  SERVER_PID=$!

  log "Waiting for ready signal (timeout: ${SERVER_TIMEOUT}s)..."

  local elapsed=0 ready=0 crashed=0
  while (( elapsed < SERVER_TIMEOUT )); do
    if [[ -f "$log_file" ]]; then
      if grep -q "Done (" "$log_file" 2>/dev/null; then
        ready=1; break
      fi
      if grep -qE "\[.+/FATAL\]" "$log_file" 2>/dev/null; then
        crashed=1; break
      fi
    fi
    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
      crashed=1; break
    fi
    sleep 2
    (( elapsed += 2 ))
  done

  if (( ready )); then
    local startup_time
    startup_time=$(grep "Done (" "$log_file" | tail -1 | grep -oE '[0-9]+\.[0-9]+s' || echo "?")
    ok "Server ready in $startup_time"
    return 0
  else
    fail "Server did not reach ready state (elapsed: ${elapsed}s)"
    return 1
  fi
}

# ── Log analysis ──────────────────────────────────────────────────────────────

# Patterns that are expected/acceptable and should not trigger failure.
# Add to this list as you discover false positives during testing.
KNOWN_OK_PATTERNS=(
  "Failed to load config"              # configs created on first load, normal
  "DistExecutor.*safely"               # forge internals
  "Unable to find biome.*datapack"     # expected on fresh world
  "Skipping.*optional dep"
  "RuntimeDistCleaner/DISTXFORM"       # client-only classes scanned on server — NeoForge filters these, not a real error
  "Native backend failed to load"      # Power Grid native acceleration unavailable on macOS, falls back to software solver
  "loot_table.*railways:blocks/track_" # Steam 'n' Rails compat loot tables for BYG/Nature's Spirit — benign until those biome mods are added
  "Unknown registry key.*railways:track_" # same as above
  "Reference map.*could not be read" # mixin refmaps missing in prod builds — harmless dev-env warning
  "Parsing error loading recipe createdeco:placard" # Create Deco 2.1.3 bug — placard recipe uses new ingredient format incompatible with the recipe type; server boots fine, item just uncraftable
  "entities/(ravaging|salvaging)/" # Create: Enchantment Industry 2.3.1 — malformed JSON in bundled loot tables; those loot entries skip but mod otherwise works
  "garnished:april_foods/smooth_blocks" # Create: Garnished — smooth_wyvern_stone block ref missing; benign tag gap, server boots fine
  "Parsing error loading recipe createfood:" # Create: Food 2.4.0 — recipe JSONs use new ingredient format incompatible with recipe types; server boots fine, affected recipes uncraftable
  "create_integrated_farming:(duck|goose)_roost" # Create: Integrated Farming — compat loot tables for duck/goose mob variants from uninstalled poultry mods; benign
  "farmersdelight:kelp_roll" # Create: Integrated Farming bundles Farmer's Delight compat; FD not installed, single recipe skipped
  "create:wrench_pickup.*missing" # A Create addon adds wrench_pickup tag refs for items not yet registered; benign tag gap
  "modid:example.*data map.*dimension" # Blueprint 8.1.0 ships a literal example placeholder in modded_biome_slice_sizes.json; benign
  "Error loading class:.*ClassNotFoundException" # mixin compat shims for optional mods not installed — expected
  "Error loading class:.*invalid dist DEDICATED_SERVER" # client-only classes scanned by mixin processor on server — expected
  "Method overwrite conflict" # mixin method conflict between two mods, Skipping — benign
  "Discarding @Unique" # mixin dedup when the same method is declared twice — benign
  "JarJar.*passed in as source" # dependency jar already provided externally (e.g. architectury) — benign
  "idas:chests/" # IDAS compat loot tables for uninstalled mods (Ice and Fire, Ars Nouveau) — benign skipped entries
  "idas:has_structure/" # IDAS structure tags for BYG/BOP biomes not in our pack — benign missing tag refs
  "valhelsia_structures:chests/spawner_dungeon_dispenser" # Valhelsia uses removed set_nbt loot function; chest spawns without potions, server fine
  "bei_ExtraDragonFight" # YUNG's Better End Island checks for a world key absent on fresh worlds — benign
  "garnished:dye_blowing/quark/" # Garnished × Quark compat recipes use incompatible ingredient format; affected recipes uncraftable, server fine
  "Couldn't load advancements:.*wander_add_map" # vanilla trader advancements fail when structure mods alter trader/cartographer data — advancement just won't trigger
  "Integrated API Error: Couldn't parse spawner mob list idas:" # IDAS spawner lists reference Ice and Fire / Ars Nouveau mobs not installed; structures spawn without those mobs
  "LootrServiceRegistry.*not found" # Quark's Lootr compat mixin — Lootr not installed, mixin target missing, benign
  "Fabric API detected.*Moonlight"  # Moonlight Lib logs ERROR when it detects Forgified Fabric API (pulled in by Decorative Lamps via Sinytra Connector); cosmetic only
  "Couldn't parse element.*beautify:blocks/" # Beautify 2.0.2 loot tables use old MapLike format; blocks install fine, affected drops uncraftable
  "Parsing error loading recipe create:crafting/kinetics/" # Create 6.0.10 gearbox/vertical_gearbox recipes use new ingredient format; server boots fine
  "Parsing error loading recipe dndesires:crafting/" # Dreams & Desires omni_gearbox recipe format mismatch; server boots fine
  "is a Fabric mod and cannot be loaded" # Decorative Lamps is a Fabric mod; Sinytra Connector handles client load, server skips it safely
  "Failed to load plugin.*KubeJSPlugin.*create_aquatic_ambitions" # Create: Aquatic Ambitions optional KubeJS plugin class missing in this build — integration unavailable, mod loads fine
  "Tried to load invalid item.*alexsmobs:" # Alex's Mobs not installed; food mods with compat recipes skip affected items gracefully
)

analyze_logs() {
  local log_file="$SERVER_DIR/logs/latest.log"
  [[ -f "$log_file" ]] || { warn "No log file found"; return 1; }

  local ignore_regex
  ignore_regex=$(printf '%s|' "${KNOWN_OK_PATTERNS[@]}"); ignore_regex="${ignore_regex%|}"

  local errors warnings
  errors=$(grep -E "\[.+/(ERROR|FATAL)\]" "$log_file" \
    | grep -vE "$ignore_regex" || true)
  warnings=$(grep -E "\[.+/WARN\]" "$log_file" \
    | grep -vE "$ignore_regex" \
    | head -15 || true)

  local error_count=0 warn_count=0
  [[ -n "$errors"   ]] && error_count=$(echo "$errors"   | wc -l | tr -d ' ')
  [[ -n "$warnings" ]] && warn_count=$(echo  "$warnings" | wc -l | tr -d ' ')

  if (( error_count > 0 )); then
    fail "$error_count error(s) / fatal(s):"
    echo "$errors" | sed 's/^/    /'
  else
    ok "No errors or fatals in log"
  fi

  if (( warn_count > 0 )); then
    warn "$warn_count warning(s) — first 15 shown (review manually):"
    echo "$warnings" | sed 's/^/    /'
  else
    ok "No warnings in log"
  fi

  return $(( error_count > 0 ? 1 : 0 ))
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
  hr
  log "CozyCreate — Server Smoke Test"
  log "Pack:   $(grep '^name' "$SCRIPT_DIR/pack.toml" | cut -d'"' -f2)"
  log "MC:     $(grep 'minecraft' "$SCRIPT_DIR/pack.toml" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
  log "Loader: NeoForge $NEOFORGE_VERSION"
  hr

  setup_server
  sync_mods
  hr

  local server_ok=0 log_ok=0

  if run_server; then
    server_ok=1
    hr
    analyze_logs && log_ok=1

    log "Sending stop command..."
    kill "$SERVER_PID" 2>/dev/null || true
    wait "$SERVER_PID" 2>/dev/null || true
    SERVER_PID=""
  else
    hr
    warn "Crash context (last 40 lines of log):"
    tail -40 "$SERVER_DIR/logs/latest.log" 2>/dev/null | sed 's/^/  /' || true
    if [[ -n "$SERVER_PID" ]] && kill -0 "$SERVER_PID" 2>/dev/null; then
      log "Stopping server..."
      kill "$SERVER_PID" 2>/dev/null || true
      wait "$SERVER_PID" 2>/dev/null || true
    fi
    SERVER_PID=""
  fi

  hr
  if (( server_ok && log_ok )); then
    ok "RESULT: PASSED — server is stable"
    echo ""
    echo "  Full log: $SERVER_DIR/logs/latest.log"
    echo ""
    exit 0
  else
    fail "RESULT: FAILED — see output above"
    echo ""
    echo "  Full log: $SERVER_DIR/logs/latest.log"
    echo ""
    exit 1
  fi
}

main
