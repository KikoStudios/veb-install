# install-config.sh
# versioned installer download config

# version/tag you’re releasing
VERSION="beta"

# Base URL for your release assets
BASE_URL="https://github.com/KikoStudios/veb-install/releases/download/${VERSION}"

# Asset filenames per OS/ARCH
ASSET_LINUX_X64="Veb_x86_Linux_B0.0.1"       # Linux x64 binary name
ASSET_MAC_ARM64="Veb_arm64_Mac_B0.0.1"       # example — adjust if you build Mac
ASSET_WIN_X64="Veb_x64_Windows_B0.0.1.exe"   # Windows x64 example

# Final download URLs
URL_LINUX_X64="${BASE_URL}/${ASSET_LINUX_X64}"
URL_MAC_ARM64="${BASE_URL}/${ASSET_MAC_ARM64}"
URL_WIN_X64="${BASE_URL}/${ASSET_WIN_X64}"
