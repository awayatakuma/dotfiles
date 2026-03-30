#!/usr/bin/env bash
set -eux
source "$(dirname "$0")/envs.bash"

# For Ubuntu
FALLBACK_VERSION="v2.2.0"
FONT_NAME="UDEVGothicJPDOC"
FONT_DIR="$XDG_DATA_HOME/fonts/$FONT_NAME"

# Attempt to fetch latest version via API, fallback if it fails or rate limited
LATEST_VERSION=$(curl -sf "https://api.github.com/repos/yuru7/udev-gothic/releases/latest" | grep '"tag_name"' | awk -F'"' '{print $4}' | sed 's/^v//' || echo "")

VERSION=${LATEST_VERSION:-$FALLBACK_VERSION}
echo "Installing $FONT_NAME v$VERSION"

ZIP_NAME="${FONT_NAME}_v${VERSION}.zip"
URL="https://github.com/yuru7/udev-gothic/releases/download/v${VERSION}/${ZIP_NAME}"

# Simple skip if directory already exists
if [ -d "$FONT_DIR" ]; then
    echo "$FONT_NAME already exists."
    exit 0
fi

mkdir -p "$FONT_DIR"
TMP_DIR=$(mktemp -d)

curl -fLo "$TMP_DIR/$ZIP_NAME" "$URL"
unzip -q "$TMP_DIR/$ZIP_NAME" -d "$TMP_DIR"
cp "$TMP_DIR/${FONT_NAME}_v${VERSION}"/*.ttf "$FONT_DIR/"

if command -v fc-cache >/dev/null; then
    fc-cache -fv "$XDG_DATA_HOME/fonts"
fi

rm -rf "$TMP_DIR"
