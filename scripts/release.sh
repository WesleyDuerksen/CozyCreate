#!/usr/bin/env bash
set -euo pipefail

PACK_NAME="CozyCreate"
BUILD_DIR="build"

RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
log()  { echo -e "${GREEN}[release]${NC} $1"; }
fail() { echo -e "${RED}[fail]${NC} $1"; exit 1; }

command -v gh >/dev/null || fail "gh CLI not found — install from https://cli.github.com"

# Derive version from whatever .mrpack export.sh produced
MRPACK=$(ls "$BUILD_DIR/${PACK_NAME}"-*.mrpack 2>/dev/null | head -1)
[[ -z "$MRPACK" ]] && fail "No .mrpack found in $BUILD_DIR/ — run scripts/export.sh first"

PACK_VERSION="${MRPACK#${BUILD_DIR}/${PACK_NAME}-}"
PACK_VERSION="${PACK_VERSION%.mrpack}"

CLIENT_ZIP="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}.zip"
SERVER_ZIP="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}-server.zip"
TAG="v${PACK_VERSION}"

for f in "$CLIENT_ZIP" "$SERVER_ZIP"; do
  [[ -f "$f" ]] || fail "Missing artifact: $f — run scripts/export.sh first"
done

log "Releasing $TAG..."
gh release create "$TAG" \
  --title "${PACK_NAME} $PACK_VERSION" \
  --generate-notes \
  "$MRPACK" \
  "$CLIENT_ZIP" \
  "$SERVER_ZIP"

log "$TAG Published!"
