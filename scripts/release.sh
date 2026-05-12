#!/usr/bin/env bash
set -euo pipefail

PACK_VERSION="1.0.1"
PACK_NAME="CozyCreate"
BUILD_DIR="build"

MRPACK="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}.mrpack"
CLIENT_ZIP="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}.zip"
SERVER_ZIP="$BUILD_DIR/${PACK_NAME}-${PACK_VERSION}-server.zip"
TAG="v${PACK_VERSION}"

RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
log()  { echo -e "${GREEN}[release]${NC} $1"; }
fail() { echo -e "${RED}[fail]${NC} $1"; exit 1; }

command -v gh >/dev/null || fail "gh CLI not found — install from https://cli.github.com"

for f in "$MRPACK" "$CLIENT_ZIP" "$SERVER_ZIP"; do
  [[ -f "$f" ]] || fail "Missing artifact: $f — run export.sh first"
done

log "Creating draft release $TAG..."
gh release create "$TAG" \
  --title "CozyCreate $PACK_VERSION" \
  --draft \
  --generate-notes \
  "$MRPACK" \
  "$CLIENT_ZIP" \
  "$SERVER_ZIP"

log "Draft release created — open GitHub to review and publish."
