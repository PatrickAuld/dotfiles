# Shell integrations from agent install-shell-integrations
#
# Lazy-load on first prompt to reduce startup time.
if [[ -o interactive ]]; then
  autoload -U add-zsh-hook
  __cursor_lazy_load() {
    add-zsh-hook -d precmd __cursor_lazy_load
    eval "$(~/.local/bin/agent shell-integration zsh)"
  }
  add-zsh-hook precmd __cursor_lazy_load
fi
