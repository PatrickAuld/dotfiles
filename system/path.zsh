# Shared tools
export PATH="$ZSH/bin:/usr/local/bin:$PATH"

# OS-specific tools
case "$(uname -s)" in
  Darwin)
    export PATH="$ZSH/darwin_bin:$PATH"
    ;;
  Linux)
    export PATH="$ZSH/linux_bin:$PATH"
    ;;
esac

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
