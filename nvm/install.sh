#!/usr/bin/env bash

set -euo pipefail

# Some environments configure npm with a user-local prefix (e.g. ~/.npm).
# Ensure the directories exist before any installer scripts invoke npm.
mkdir -p "$HOME/.npm/bin" "$HOME/.npm/lib" "$HOME/.npm/share"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required to install nvm; skipping." >&2
  exit 0
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
