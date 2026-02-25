# Shared tools
export PATH="$ZSH/bin:/usr/local/bin:$PATH"

# User-local binaries (especially important on Linux where /usr/local/bin may require sudo)
export PATH="$HOME/.local/bin:$PATH"

# OS-specific tools
case "$(uname -s)" in
  Darwin)
    export PATH="$ZSH/bin_darwin:$PATH"
    ;;
  Linux)
    export PATH="$ZSH/bin_linux:$PATH"
    ;;
esac

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
