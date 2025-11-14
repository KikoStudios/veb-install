#!/bin/bash
set -euo pipefail

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Linux)
        BINARY_NAME="veb-linux"
        ;;
    Darwin)
        BINARY_NAME="veb-darwin"
        ;;
    *)
        echo "❌ Unsupported OS: $OS"
        exit 1
        ;;
esac

# Decide install location
if [ "$EUID" -eq 0 ]; then
    BIN_DIR="/usr/local/bin"
else
    BIN_DIR="$HOME/.local/bin"
fi

mkdir -p "$BIN_DIR"

echo "🔧 Downloading veb CLI for $OS..."

# Download safely
curl -fL "https://vebinstall.overload.studio/bin/$BINARY_NAME" -o "$BIN_DIR/veb"

# Make executable
chmod +x "$BIN_DIR/veb"

# Verify binary
if file "$BIN_DIR/veb" | grep -qi 'html'; then
    echo "❌ ERROR: Downloaded file is HTML, not a binary."
    echo "⚠️ This means the server is returning a redirect or wrong MIME type."
    echo "Downloaded path: $BIN_DIR/veb"
    exit 1
fi

echo "✅ Installed successfully!"
echo "➡️  Run 'veb' from anywhere."
