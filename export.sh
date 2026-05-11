#!/usr/bin/env bash
set -euo pipefail

PACK_VERSION="1.0.1"
MINECRAFT_VERSION="1.21.1"
NEOFORGE_VERSION="21.1.228"
PACK_NAME="CozyCreate"
BUILD_DIR="build"
TOOLS_DIR="$BUILD_DIR/tools"
CLIENT_DIR="$BUILD_DIR/client"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { echo -e "${GREEN}[export]${NC} $1"; }
warn() { echo -e "${YELLOW}[warn]${NC} $1"; }
fail() { echo -e "${RED}[fail]${NC} $1"; exit 1; }

# ── 1. Ensure packwiz CLI ──────────────────────────────────────────────────────
PACKWIZ_BIN=$(command -v packwiz 2>/dev/null || echo "")
if [[ -z "$PACKWIZ_BIN" ]]; then
  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64)  PW_ARCH="amd64" ;;
    aarch64) PW_ARCH="arm64" ;;
    *) fail "Unsupported architecture: $ARCH — install packwiz manually: https://packwiz.infra.link" ;;
  esac
  mkdir -p "$TOOLS_DIR"
  PACKWIZ_BIN="$TOOLS_DIR/packwiz"
  if [[ ! -f "$PACKWIZ_BIN" ]]; then
    log "Downloading packwiz CLI (linux/$PW_ARCH)..."
    PW_URL="https://github.com/packwiz/packwiz/releases/latest/download/packwiz_linux_${PW_ARCH}"
    curl -fL --progress-bar -o "$PACKWIZ_BIN" "$PW_URL"
    chmod +x "$PACKWIZ_BIN"
  fi
fi
log "packwiz: $PACKWIZ_BIN"

# ── 2. Sync configs to pack root ───────────────────────────────────────────────
log "Syncing server/config/ → config/ ..."
mkdir -p config
rsync -a --delete \
  --exclude='spark/tmp-client/' \
  --exclude='waila/' \
  server/config/ config/

# ── 3. Refresh packwiz index (picks up config/ files) ─────────────────────────
log "Refreshing packwiz index..."
"$PACKWIZ_BIN" refresh

# ── 4. Export .mrpack ─────────────────────────────────────────────────────────
MRPACK_FILE="${PACK_NAME}-${PACK_VERSION}.mrpack"
log "Exporting .mrpack..."
"$PACKWIZ_BIN" modrinth export -o "$MRPACK_FILE"
log "Generated: $MRPACK_FILE"

# ── 5. Build self-contained client zip ────────────────────────────────────────
ZIP_FILE="${PACK_NAME}-${PACK_VERSION}-client.zip"
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
name=Cozy Create $PACK_VERSION
EOF

# Prism instance thumbnail
if [[ -f icon.png ]]; then
  cp icon.png "$CLIENT_DIR/icon.png"
fi

# Collect download URLs for client + both side mods
log "Resolving client mod list (skipping server-only mods)..."
declare -a MOD_URLS=()
for toml in mods/*.pw.toml; do
  side=$(grep '^side = ' "$toml" | sed 's/side = "\(.*\)"/\1/')
  [[ "$side" == "server" ]] && continue
  url=$(grep '^url = ' "$toml" | sed 's/url = "\(.*\)"/\1/')
  filename=$(grep '^filename = ' "$toml" | sed 's/filename = "\(.*\)"/\1/')
  MOD_URLS+=("$url $filename")
done
log "Downloading ${#MOD_URLS[@]} mods (up to 8 parallel)..."

# Parallel download with a bounded job pool
DOWNLOAD_FAIL=0
declare -a PIDS=()
for entry in "${MOD_URLS[@]}"; do
  url="${entry%% *}"
  filename="${entry##* }"
  dest="$CLIENT_DIR/.minecraft/mods/$filename"
  if [[ ! -f "$dest" ]]; then
    (curl -fsSL -o "$dest" "$url" || { echo "FAIL: $filename" >&2; exit 1; }) &
    PIDS+=($!)
    # Drain pool when it hits 8
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

log "Zipping client instance..."
rm -f "$ZIP_FILE"
(cd "$CLIENT_DIR" && zip -qr "../../$ZIP_FILE" .)
log "Generated: $ZIP_FILE"

# ── 6. Summary ────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Done!${NC}"
echo "  .mrpack  →  $MRPACK_FILE   (import into Prism; mods download automatically)"
echo "  .zip     →  $ZIP_FILE   (import into Prism; all mods bundled, no downloads)"
