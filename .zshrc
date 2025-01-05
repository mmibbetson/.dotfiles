HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob notify
unsetopt beep nomatch
bindkey -e
zstyle :compinstall filename '/var/home/mmibbetson/.zshrc'
autoload -Uz compinit
compinit

#################
### Functions ###
#################

function add_to_path {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

function dno() {
    local regexp="$1"
    rg --files "*${regexp}*" ~/Documents/notes | fzf | xargs nvim
}

###############
### Aliases ###
###############

alias ls="eza --group-directories-first --color=auto --icons=auto"
alias la="eza --all --group-directories-first --color=auto --icons=auto"
alias ll="eza --long --group-directories-first --color=auto --icons=auto"
alias lla="eza --long --all --group-directories-first --color=auto --icons=auto"
alias tree="eza --tree --group-directories-first --color=auto --icons=auto"
alias lzg="lazygit"

####################
### Shell Config ###
####################



####################
### Other Config ###
####################

# Gruvbox theme for fzf
FZF_DEFAULT_OPTS="--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
XDG_CONFIG_HOME="$HOME/.config"

# Default fzf behaviour to use ripgrep
FZF_DEFAULT_COMMAND="rg --files --hidden --follow -g \"!.git/\" 2> /dev/null"

# Gruvbox theme for bat
BAT_THEME="gruvbox-dark"

############
### Path ###
############

# User binaries
# add_to_path "$HOME/bin"

# AppImages
add_to_path "$HOME/appimages"

# Scripts
add_to_path "$HOME/scripts"

# Dotnet
# add_to_path "/usr/share/dotnet"
# add_to_path "$HOME/.dotnet/tools"

# Rust
# add_to_path "$HOME/.cargo/bin"
# add_to_path "$HOME/.cargo/env"

######################
### Initialisation ###
######################

# Prompt
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

