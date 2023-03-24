
if [[ ! -z "$IN_NIX_SHELL" ]]; then
  return
fi

# Include the user npm bin in the path
export PATH="$HOME/.npm/bin:$PATH"
