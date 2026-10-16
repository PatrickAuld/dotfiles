#!/usr/bin/env bash

set -euo pipefail

os_name() {
  uname -s
}

is_darwin() {
  [[ "$(os_name)" == "Darwin" ]]
}

is_linux() {
  [[ "$(os_name)" == "Linux" ]]
}

require_darwin() {
  if ! is_darwin; then
    echo "Skipping (macOS-only): $0" >&2
    exit 0
  fi
}

require_linux() {
  if ! is_linux; then
    echo "Skipping (Linux-only): $0" >&2
    exit 0
  fi
}

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    if [ "${DOTFILES_HEADLESS:-0}" = 1 ] || [ ! -t 0 ] || [ ! -t 1 ]; then
      sudo -n "$@"
    else
      sudo "$@"
    fi
  else
    echo "Package installation requires root or sudo." >&2
    return 1
  fi
}

apt_update() {
  run_as_root env DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a apt-get update
}

apt_install() {
  run_as_root env DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=a \
    apt-get install -y -o Dpkg::Options::=--force-confdef \
    -o Dpkg::Options::=--force-confold "$@"
}

