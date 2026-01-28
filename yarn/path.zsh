# sup yarn
# https://yarnpkg.com

if (( $+commands[yarn] )); then
  # Avoid shelling out on every startup; add known global bin dirs if present.
  local yarn_bin_paths=(
    "$HOME/.yarn/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "$HOME/.yarn/bin"
  )
  for yarn_bin in $yarn_bin_paths; do
    [[ -d "$yarn_bin" ]] && export PATH="$PATH:$yarn_bin"
  done
  unset yarn_bin_paths yarn_bin
fi
