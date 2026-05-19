#!/usr/bin/env bash
# CozyCreate server smoke test (Docker-based)
# Usage: ./validate.sh
# Syncs mods to server/content/mods/ via packwiz, then starts the stack via docker compose
# and watches logs until healthy. Requires docker daemon access.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACK_ROOT="$(cd "$SCRIPT_DIR" && pwd)"
SERVER_DIR="$PACK_ROOT"
DATA_DIR="$SERVER_DIR/data"
SERVER_TIMEOUT=600   # mod loading is slow on first run

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()  { echo -e "${BLUE}[validate]${NC} $*"; }
ok()   { echo -e "${GREEN}✔ PASS${NC}  $*"; }
fail() { echo -e "${RED}✖ FAIL${NC}  $*"; }
warn() { echo -e "${YELLOW}⚠ WARN${NC}  $*"; }
hr()   { echo "────────────────────────────────────────────"; }

STACK_UP=0

cleanup() {
  if (( STACK_UP )); then
    log "Stopping stack..."
    (cd "$SERVER_DIR" && docker compose down --timeout 30 >/dev/null 2>&1) || true
  fi
}
trap cleanup EXIT

# ── Preflight ─────────────────────────────────────────────────────────────────

preflight() {
  if ! docker version >/dev/null 2>&1; then
    fail "Cannot reach docker daemon — add your user to the 'docker' group and re-login,"
    fail "or run validate.sh with sudo."
    exit 1
  fi

  PACKWIZ_BIN=$(command -v packwiz 2>/dev/null || echo "${HOME}/go/bin/packwiz")
  if [[ ! -x "$PACKWIZ_BIN" ]]; then
    fail "packwiz not found — install with: go install github.com/packwiz/packwiz@latest"
    exit 1
  fi

  if [[ ! -f "$SERVER_DIR/rcon-password.txt" ]]; then
    log "Creating server/rcon-password.txt..."
    (umask 077 && openssl rand -base64 24 > "$SERVER_DIR/rcon-password.txt")
  fi

  ok "Preflight checks passed"
}

# ── Stack startup ─────────────────────────────────────────────────────────────

start_stack() {
  log "Starting stack..."
  (cd "$SERVER_DIR" && docker compose up -d minecraft) || { fail "docker compose up failed"; exit 1; }
  STACK_UP=1

  log "Waiting for healthcheck (timeout: ${SERVER_TIMEOUT}s)..."
  local elapsed=0 status=""
  while (( elapsed < SERVER_TIMEOUT )); do
    status=$(docker inspect --format '{{.State.Health.Status}}' cozycreate 2>/dev/null || echo "missing")
    case "$status" in
      healthy)  ok "Server healthy after ${elapsed}s"; return 0 ;;
      unhealthy) fail "Container reported unhealthy after ${elapsed}s"; return 1 ;;
      missing)  fail "Container 'cozycreate' not found"; return 1 ;;
    esac
    sleep 5
    (( elapsed += 5 ))
  done

  fail "Healthcheck timed out (${SERVER_TIMEOUT}s); status=$status"
  return 1
}

# ── Log analysis ──────────────────────────────────────────────────────────────

# Patterns that are expected/acceptable and should not trigger failure.
KNOWN_OK_PATTERNS=(
  "Failed to load config"
  "DistExecutor.*safely"
  "Unable to find biome.*datapack"
  "Skipping.*optional dep"
  "RuntimeDistCleaner/DISTXFORM"
  "Native backend failed to load"
  "loot_table.*railways:blocks/track_"
  "Unknown registry key.*railways:track_"
  "Reference map.*could not be read"
  "Parsing error loading recipe createdeco:placard"
  "entities/(ravaging|salvaging)/"
  "garnished:april_foods/smooth_blocks"
  "Parsing error loading recipe createfood:"
  "create_integrated_farming:(duck|goose)_roost"
  "farmersdelight:kelp_roll"
  "create:wrench_pickup.*missing"
  "modid:example.*data map.*dimension"
  "Error loading class:.*ClassNotFoundException"
  "Error loading class:.*invalid dist DEDICATED_SERVER"
  "Method overwrite conflict"
  "Discarding @Unique"
  "JarJar.*passed in as source"
  "idas:chests/"
  "idas:has_structure/"
  "valhelsia_structures:chests/spawner_dungeon_dispenser"
  "bei_ExtraDragonFight"
  "garnished:dye_blowing/quark/"
  "Couldn't load advancements:.*wander_add_map"
  "Integrated API Error: Couldn't parse spawner mob list idas:"
  "LootrServiceRegistry.*not found"
  "Fabric API detected.*Moonlight"
  "Couldn't parse element.*beautify:blocks/"
  "Parsing error loading recipe create:crafting/kinetics/"
  "Parsing error loading recipe dndesires:crafting/"
  "is a Fabric mod and cannot be loaded"
  "Failed to load plugin.*KubeJSPlugin.*create_aquatic_ambitions"
  "Tried to load invalid item.*alexsmobs:"
  "Couldn't load fabric:overlays metadata"
  "AllTheLeaks.*Failed to instantiate constructor"
  "Parsing error loading recipe create_factory:"
  "Couldn't load tag create_factory:sweet_berries_jam"
  "create_things_and_misc:deleted_mod_element"
  "@Mixin target.*AbstractClientPlayer.*create_sa"
  "fml.modloadingissue.brokenfile.fabric"
  "Assets URL.*uses unexpected schema"
  "Could not find Sign for wood"
  "Static binding violation.*PRIVATE @Overwrite.*modernfix"
  "BuiltinKubeJSClientPlugin does not load on server"
  "FTBChunksKubeJSPlugin.*does not have required mod.*ftbchunks"
  "Failed to process update information"
  "The following mods have version differences that were not resolved"
  "supplementaries:inject/pillager_quiver"
)

analyze_logs() {
  local log_file="$DATA_DIR/logs/latest.log"
  if [[ ! -f "$log_file" ]]; then
    warn "No log file found at $log_file"
    return 1
  fi

  local ignore_regex
  ignore_regex=$(printf '%s|' "${KNOWN_OK_PATTERNS[@]}"); ignore_regex="${ignore_regex%|}"

  local errors warnings
  errors=$(grep -E "\[.+/(ERROR|FATAL)\]" "$log_file" | grep -vE "$ignore_regex" || true)
  warnings=$(grep -E "\[.+/WARN\]" "$log_file" | grep -vE "$ignore_regex" | head -15 || true)

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
  log "CozyCreate — Server Smoke Test (Docker)"
  log "Pack:   $(grep '^name' "$PACK_ROOT/pack.toml" | cut -d'"' -f2)"
  log "MC:     $(grep 'minecraft' "$PACK_ROOT/pack.toml" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
  hr

  preflight
  hr

  local server_ok=0 log_ok=0

  if start_stack; then
    server_ok=1
    hr
    analyze_logs && log_ok=1
  else
    hr
    warn "Last 60 log lines:"
    docker logs --tail 60 cozycreate 2>&1 | sed 's/^/  /' || true
  fi

  hr
  if (( server_ok && log_ok )); then
    ok "RESULT: PASSED — server is stable"
    echo ""
    echo "  Full log: $DATA_DIR/logs/latest.log"
    echo ""
    exit 0
  else
    fail "RESULT: FAILED — see output above"
    echo ""
    echo "  Full log: $DATA_DIR/logs/latest.log"
    echo ""
    exit 1
  fi
}

main
