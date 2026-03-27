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
