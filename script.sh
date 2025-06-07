#!/usr/bin/env bash
# install_grave_key.sh — Install custom XKB rules, symbols, and xkb files
# Must be run with root privileges
set -euo pipefail

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Use sudo or run as root."
  exit 1
fi

# Directories to copy into
RULES_DIR="/usr/share/X11/xkb/rules"
SYMBOLS_DIR="/usr/share/X11/xkb/symbols"

# if we only want wayland then there's a better way
# which won't be overitten by an update to xkeyboard-config
if [[ "$1" == "wayland" ]]; then
  RULES_DIR="/etc/xkb/rules"
  SYMBOLS_DIR="/etc/xkb/symbols"
fi

# Ensure target directories exist, create if missing
if [[ ! -d "$RULES_DIR" ]]; then
  echo "Creating $RULES_DIR..."
  mkdir -p "$RULES_DIR"
fi
if [[ ! -d "$SYMBOLS_DIR" ]]; then
  echo "Creating $SYMBOLS_DIR..."
  mkdir -p "$SYMBOLS_DIR"
fi

# Copy files
echo "Copying rules..."
cp -f ./rules/* "$RULES_DIR/"

echo "Copying symbols..."
cp -f ./symbols/* "$SYMBOLS_DIR/"

echo "Installation complete"
