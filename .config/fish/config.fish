if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx fish_greeting ""

fish_vi_key_bindings

# Aliases
alias ls="eza --group-directories-first --color=auto --icons=auto"
alias la="eza --all --group-directories-first --color=auto --icons=auto"
alias tree="eza --tree --group-directories-first --color=auto --icons=auto"
alias em="emacsclient -c -a 'emacs'"
alias lzg="lazygit"
alias lzd="lazydocker"

# May switch this to emacs once configs are ready
if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx MANPAGER "nvim +Man!"
  alias vimdiff="nvim -d"
end

# gruvbox for fzf
set -gx FZF_DEFAULT_OPTS "--color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
set -gx XDG_CONFIG_HOME "$HOME/.config"

# Default fzf behaviour
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow -g \"!.git/\" 2> /dev/null"

# gruvbox for bat
set -gx BAT_THEME "gruvbox-dark"

# Path management
# AppImages
fish_add_path "$HOME/appimages"

# Scripts
fish_add_path "$HOME/scripts"

# Dotnet
fish_add_path "/usr/share/dotnet"
fish_add_path "$HOME/.dotnet/tools"

# Rust
fish_add_path "$HOME/.cargo/bin"

# Node
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

zoxide init fish | source
