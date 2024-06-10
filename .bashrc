# If running interactively, start fish
if [[ $- == *i* ]]; then
  exec fish
fi

function add_to_path {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Path management
# AppImages
add_to_path "$HOME/appimages"

# Scripts
add_to_path "$HOME/scripts"

# Dotnet
add_to_path "/usr/share/dotnet"
add_to_path "$HOME/.dotnet/tools"

# Rust
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.cargo/env"

# Node (pnpm)
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
":$PNPM_HOME:") ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
