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
XKB_DIR="/etc/X11/xkb"

# Ensure target directories exist, create if missing
if [[ ! -d "$RULES_DIR" ]]; then
  echo "Creating $RULES_DIR..."
  mkdir -p "$RULES_DIR"
fi
if [[ ! -d "$SYMBOLS_DIR" ]]; then
  echo "Creating $SYMBOLS_DIR..."
  mkdir -p "$SYMBOLS_DIR"
fi
if [[ ! -d "$XKB_DIR" ]]; then
  echo "Creating $XKB_DIR..."
  mkdir -p "$XKB_DIR"
fi

# Copy files
echo "Copying rules..."
cp -rf ./rules/* "$RULES_DIR/"

echo "Copying symbols..."
cp -rf ./symbols/* "$SYMBOLS_DIR/"

echo "Copying xkb files..."
cp -rf ./xkb/* "$XKB_DIR/"

echo "Installation complete"
