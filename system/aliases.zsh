# Prefer GNU ls (`gls`) when installed via coreutils on macOS; otherwise use
# the system `ls` (e.g. GNU ls on Linux).
if command -v gls >/dev/null 2>&1; then
  LS_BIN='gls'
else
  LS_BIN='ls'
fi

alias ls="$LS_BIN -F --color"
alias l="$LS_BIN -lAh --color"
alias ll="$LS_BIN -l --color"
alias la="$LS_BIN -A --color"
