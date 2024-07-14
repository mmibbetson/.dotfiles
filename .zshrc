HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob notify
unsetopt beep nomatch
bindkey -e
zstyle :compinstall filename '/var/home/mmibbetson/.zshrc'
autoload -Uz compinit
compinit

function add_to_path {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Aliases
alias ls="eza --group-directories-first --color=auto --icons=auto"
alias la="eza --all --group-directories-first --color=auto --icons=auto"
alias tree="eza --tree --group-directories-first --color=auto --icons=auto"
alias ec="emacsclient -c -a=''"
alias lzg="lazygit"

# gruvbox for fzf
FZF_DEFAULT_OPTS="--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
XDG_CONFIG_HOME="$HOME/.config"

# Default fzf behaviour to use ripgrep
FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g \"!.git/\" 2> /dev/null"

# gruvbox for bat
BAT_THEME="gruvbox-dark"

# Path management
# Zig binary
add_to_path "$HOME/Projects/zig_projects/zig-linux-x86_64-0.14.0-dev.239+80d7e260d"

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

# Prompt
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"
