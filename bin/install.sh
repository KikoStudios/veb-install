#!/usr/bin/env sh
set -e

# Source the config (adjust path if needed)
CONFIG_URL="https://raw.githubusercontent.com/KikoStudios/veb-install/main/install-config.sh"
echo "Downloading config from ${CONFIG_URL} ..."
curl -fsSL "${CONFIG_URL}" -o /tmp/veb-install-config.sh
. /tmp/veb-install-config.sh

# Determine OS and ARCH
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
  linux)
    case "$ARCH" in
      x86_64) DL_URL="$URL_LINUX_X64" ;;
      aarch64|arm64) DL_URL="$URL_MAC_ARM64" ;;  # if you treat arm Linux same as Mac ARM? adjust
      *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
    esac
    ;;
  darwin)
    case "$ARCH" in
      x86_64) DL_URL="$URL_MAC_ARM64" ;;  # if you only built one Mac version
      arm64) DL_URL="$URL_MAC_ARM64" ;;
      *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

echo "Downloading binary from ${DL_URL}"
curl -fsSL "${DL_URL}" -o /tmp/veb
chmod +x /tmp/veb

# Install location
if [ -w /usr/local/bin ]; then
  mv /tmp/veb /usr/local/bin/veb
else
  mkdir -p "$HOME/bin"
  mv /tmp/veb "$HOME/bin/veb"
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.profile"
  echo "Added $HOME/bin to PATH in .profile"
fi

echo "Installation complete. Run: veb --help"
