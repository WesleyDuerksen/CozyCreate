#!/usr/bin/env bash
set -euo pipefail

PACK_VERSION="0.2.2"
MINECRAFT_VERSION="1.21.1"
NEOFORGE_VERSION="21.1.228"
PACK_NAME="CozyCreate"
BUILD_DIR="build"
TOOLS_DIR="$BUILD_DIR/tools"
CLIENT_DIR="$BUILD_DIR/client"
ROOT="$(pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { echo -e "${GREEN}[export]${NC} $1"; }
warn() { echo -e "${YELLOW}[warn]${NC} $1"; }
fail() { echo -e "${RED}[fail]${NC} $1"; exit 1; }

# ── 1. Ensure packwiz CLI ──────────────────────────────────────────────────────
PACKWIZ_BIN=$(command -v packwiz 2>/dev/null || echo "${HOME}/go/bin/packwiz")
if [[ ! -x "$PACKWIZ_BIN" ]]; then
  fail "packwiz not found — install with: go install github.com/packwiz/packwiz@latest"
fi
log "packwiz: $PACKWIZ_BIN"

# ── 2. Sync configs to pack root ───────────────────────────────────────────────
log "Syncing server/config/ → config/ ..."
rm -rf config
cp -r server/config config
rm -rf config/spark/tmp-client config/waila

# ── 3. Refresh packwiz index (picks up config/ files) ─────────────────────────
log "Refreshing packwiz index..."
"$PACKWIZ_BIN" refresh

# ── 4. Export .mrpack ─────────────────────────────────────────────────────────
MRPACK_FILE="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}.mrpack"
mkdir -p "$BUILD_DIR"
log "Cleaning previous build artifacts..."
rm -f "$BUILD_DIR"/*.mrpack "$BUILD_DIR"/*.zip
log "Exporting .mrpack..."
"$PACKWIZ_BIN" modrinth export -o "$MRPACK_FILE"
log "Generated: $MRPACK_FILE"

# ── 5. Build self-contained client zip ────────────────────────────────────────
ZIP_FILE="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}.zip"
log "Building self-contained client zip..."

rm -rf "$CLIENT_DIR"
mkdir -p "$CLIENT_DIR/.minecraft/mods"
mkdir -p "$CLIENT_DIR/.minecraft/config"

cat > "$CLIENT_DIR/mmc-pack.json" <<EOF
{
    "components": [
        {
            "important": true,
            "uid": "net.minecraft",
            "version": "$MINECRAFT_VERSION"
        },
        {
            "uid": "net.neoforged",
            "version": "$NEOFORGE_VERSION"
        }
    ],
    "formatVersion": 1
}
EOF

cat > "$CLIENT_DIR/instance.cfg" <<EOF
InstanceType=OneSix
name=Cozy Create
iconKey=cozycreate
OverrideMemory=true
MinMemAlloc=2048
MaxMemAlloc=6144
OverrideJavaArgs=true
JvmArgs=-XX:+UnlockExperimentalVMOptions -XX:+UseZGC -XX:+ZGenerational -XX:+AlwaysPreTouch
EOF

# Prism instance thumbnail — filename must match iconKey
if [[ -f assets/icon.png ]]; then
  cp assets/icon.png "$CLIENT_DIR/cozycreate.png"
fi

# Collect mods for client + both sides; CurseForge mods have no URL, copy from server/mods/
log "Resolving client mod list (skipping server-only mods)..."
declare -a DOWNLOAD_ENTRIES=()   # "url filename"
declare -a COPY_FILENAMES=()     # filenames to copy from server/mods/
for toml in mods/*.pw.toml; do
  side=$(grep '^side = ' "$toml" | sed 's/side = "\(.*\)"/\1/')
  [[ "$side" == "server" ]] && continue
  filename=$(grep '^filename = ' "$toml" | sed 's/filename = "\(.*\)"/\1/')
  url=$(grep '^url = ' "$toml" 2>/dev/null | sed 's/url = "\(.*\)"/\1/' || echo "")
  if [[ -n "$url" ]]; then
    DOWNLOAD_ENTRIES+=("$url $filename")
  else
    COPY_FILENAMES+=("$filename")
  fi
done
log "Will download ${#DOWNLOAD_ENTRIES[@]} mods, copy ${#COPY_FILENAMES[@]} from server/mods/ or client/mods/"

# Copy CurseForge mods — check server/mods/ first, then client/mods/ (for client-only jars)
for filename in "${COPY_FILENAMES[@]}"; do
  if [[ -f "server/mods/$filename" ]]; then
    cp "server/mods/$filename" "$CLIENT_DIR/.minecraft/mods/$filename"
  elif [[ -f "client/mods/$filename" ]]; then
    cp "client/mods/$filename" "$CLIENT_DIR/.minecraft/mods/$filename"
  else
    warn "Missing in server/mods/ and client/mods/: $filename"
  fi
done

# Parallel download for Modrinth mods
DOWNLOAD_FAIL=0
declare -a PIDS=()
for entry in "${DOWNLOAD_ENTRIES[@]}"; do
  url="${entry%% *}"
  filename="${entry##* }"
  dest="$CLIENT_DIR/.minecraft/mods/$filename"
  if [[ ! -f "$dest" ]]; then
    (curl -fsSL -o "$dest" "$url" || { echo "FAIL: $filename" >&2; exit 1; }) &
    PIDS+=($!)
    while [[ ${#PIDS[@]} -ge 8 ]]; do
      if ! wait "${PIDS[0]}"; then DOWNLOAD_FAIL=1; fi
      PIDS=("${PIDS[@]:1}")
    done
  fi
done
for pid in "${PIDS[@]}"; do
  if ! wait "$pid"; then DOWNLOAD_FAIL=1; fi
done
[[ $DOWNLOAD_FAIL -ne 0 ]] && fail "One or more mod downloads failed — check output above"

log "Copying configs..."
cp -r config/. "$CLIENT_DIR/.minecraft/config/"

# Low-end baseline options.txt — Minecraft fills in any keys we don't set
if [[ -f assets/options.txt ]]; then
  cp assets/options.txt "$CLIENT_DIR/.minecraft/options.txt"
fi

# Shader packs
if [[ -d shaderpacks ]]; then
  mkdir -p "$CLIENT_DIR/.minecraft/shaderpacks"
  cp shaderpacks/* "$CLIENT_DIR/.minecraft/shaderpacks/"
fi

log "Zipping client instance..."
rm -f "$ZIP_FILE"
(cd "$CLIENT_DIR" && zip -qr "$ROOT/$ZIP_FILE" instance.cfg mmc-pack.json cozycreate.png .minecraft)
log "Generated: $ZIP_FILE"

# ── 6. Build server zip ───────────────────────────────────────────────────────
SERVER_ZIP="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}-server.zip"
SERVER_DIR="$BUILD_DIR/server"
log "Building server zip..."

rm -rf "$SERVER_DIR"
mkdir -p "$SERVER_DIR/mods"

# Mods: server + both sides only
log "Copying server mods..."
for toml in mods/*.pw.toml; do
  side=$(grep '^side = ' "$toml" | sed 's/side = "\(.*\)"/\1/')
  [[ "$side" == "client" ]] && continue
  filename=$(grep '^filename = ' "$toml" | sed 's/filename = "\(.*\)"/\1/')
  src="server/mods/$filename"
  if [[ -f "$src" ]]; then
    cp "$src" "$SERVER_DIR/mods/$filename"
  else
    warn "Missing server mod: $filename"
  fi
done

# Configs and server icon
cp -r config "$SERVER_DIR/config"
[[ -f assets/server-icon.png ]] && cp assets/server-icon.png "$SERVER_DIR/server-icon.png"

# Start script: installs NeoForge once, then starts
cat > "$SERVER_DIR/start.sh" <<'STARTSCRIPT'
#!/usr/bin/env bash
set -euo pipefail

NF_VERSION="21.1.228"
NF_INSTALLER="neoforge-${NF_VERSION}-installer.jar"
NF_URL="https://maven.neoforged.net/releases/net/neoforged/neoforge/${NF_VERSION}/neoforge-${NF_VERSION}-installer.jar"

if [[ ! -f "libraries/net/neoforged/neoforge/${NF_VERSION}/unix_args.txt" ]]; then
  echo "[start] Installing NeoForge ${NF_VERSION}..."
  [[ ! -f "$NF_INSTALLER" ]] && curl -fL --progress-bar -o "$NF_INSTALLER" "$NF_URL"
  java -jar "$NF_INSTALLER" --install-server . --http-proxy ""
  rm -f "$NF_INSTALLER"
fi

echo "eula=true" > eula.txt
exec java @user_jvm_args.txt \
  @libraries/net/neoforged/neoforge/${NF_VERSION}/unix_args.txt "$@"
STARTSCRIPT
chmod +x "$SERVER_DIR/start.sh"

cp server/docker-compose.yml "$SERVER_DIR/docker-compose.yml"

log "Zipping server package..."
rm -f "$SERVER_ZIP"
(cd "$SERVER_DIR" && zip -qr "$ROOT/$SERVER_ZIP" .)
log "Generated: $SERVER_ZIP"

# ── 7. Summary ────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Done!${NC}"
echo "  .mrpack       →  $MRPACK_FILE   (import into Prism; mods download automatically)"
echo "  client .zip   →  $ZIP_FILE   (import into Prism; all mods bundled, no downloads)"
echo "  server .zip   →  $SERVER_ZIP   (unzip, docker compose up)"
