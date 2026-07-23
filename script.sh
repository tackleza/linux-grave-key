#!/usr/bin/env bash

# Install the custom grp:grave_switch XKB rules.

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./script.sh [--auto|--wayland|--x11]

Install the custom grave-key layout switcher.

Options:
  --auto      Detect Wayland or X11 automatically (default).
  --wayland   Install for the current user in $XDG_CONFIG_HOME/xkb.
              Do not run this mode with sudo.
  --x11       Install system-wide in /usr/share/X11/xkb.
              The script asks for sudo when necessary.
  -h, --help  Show this help message.
EOF
}

fail() {
  echo "Error: $*" >&2
  exit 1
}

detect_session_type() {
  local session_type="${XDG_SESSION_TYPE:-}"
  session_type="${session_type,,}"

  case "$session_type" in
    wayland|x11)
      echo "$session_type"
      return
      ;;
  esac

  # A Wayland session commonly also exports DISPLAY for XWayland, so check the
  # Wayland socket before falling back to DISPLAY.
  if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    echo "wayland"
  elif [[ -n "${DISPLAY:-}" ]]; then
    echo "x11"
  else
    fail "Could not detect Wayland or X11. Use --wayland or --x11."
  fi
}

if (( $# > 1 )); then
  usage >&2
  fail "Only one mode flag may be specified."
fi

requested_mode="${1:---auto}"
if [[ "$requested_mode" == "--auto" && -n "${SUDO_USER:-}" ]] && (( EUID == 0 )); then
  fail "Auto mode must run without sudo so it can detect your desktop session."
fi

mode="$requested_mode"
case "$mode" in
  --auto)
    mode="$(detect_session_type)"
    echo "Detected session: $mode"
    ;;
  --wayland)
    mode="wayland"
    ;;
  --x11)
    mode="x11"
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    fail "Unknown option: $mode"
    ;;
esac

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ "$mode" == "wayland" ]]; then
  if (( EUID == 0 )); then
    fail "Wayland installs per user. Run this script without sudo."
  fi

  [[ -n "${HOME:-}" ]] || fail "HOME is not set."
  config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  [[ "$config_home" == /* ]] || fail "XDG_CONFIG_HOME must be an absolute path."

  xkb_root="$config_home/xkb"
  echo "Installing Wayland configuration for user: ${USER:-$(id -un)}"
else
  if (( EUID != 0 )); then
    command -v sudo >/dev/null 2>&1 ||
      fail "sudo is required for the X11 system-wide installation."
    echo "X11 installation requires administrator access; requesting sudo..."
    exec sudo -- "$script_dir/script.sh" --x11
  fi

  xkb_root="/usr/share/X11/xkb"
  echo "Installing X11 configuration system-wide."
fi

rules_dir="$xkb_root/rules"
symbols_dir="$xkb_root/symbols"

echo "Target XKB directory: $xkb_root"
mkdir -p -- "$rules_dir" "$symbols_dir"

echo "Copying rules..."
cp -f -- "$script_dir"/rules/* "$rules_dir/"

echo "Copying symbols..."
cp -f -- "$script_dir"/symbols/* "$symbols_dir/"

echo "Installation complete. Log out and back in, or reboot, to apply it."
