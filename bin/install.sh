#!/bin/bash
set -e

OS=$(uname -s)
BIN_DIR="/usr/local/bin"
[ "$EUID" -ne 0 ] && BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

if [ "$OS" = "Linux" ] || [ "$OS" = "Darwin" ]; then
    echo "🔧 Downloading veb CLI for $OS..."
    curl -L https://vebinstall.overload.studio/bin/veb-linux -o ~/.local/bin/veb
    chmod +x "$BIN_DIR/veb"
    echo "✅ Installed successfully! Run 'veb' from anywhere."
else
    echo "❌ OS $OS not supported yet."
    exit 1
fi
