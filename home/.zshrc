#!/bin/zsh

#
#          █████████████           
#        ██▒▒▒▒▒▒▒▒▒▒▒▒▒██        
#      ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██     
#    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██       
#   ██▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒  ▒▒▒▒██   
#   ██▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒  ▒▒▒▒██   
#  ██▒▒ ▒ ▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
#  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
#  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
#  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
#  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██
#  ██▒██▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██
#  ███  ██▒▒██  ██▒▒▒██  ██▒▒██
#  ██     ██     ████      ████
#
#  All in One
#  Silvaire's Awesome Z Shell Config
#  by @silvaire-qwq
#

# /---------- Index ----------/
# / - Configs                 /
# / - Custom Configs          /
# / - Plugins Manager         /
# / - Aliases                 /
# /---------------------------/


# /---------- Configs ----------/

local SNIPPET=(
    # [C] zinit snippet "string"
    # [P] string
    OMZ::plugins/git/git.plugin.zsh
    OMZ::lib/git.zsh
    OMZ::lib/clipboard.zsh
    OMZ::lib/completion.zsh
    OMZ::lib/history.zsh
    OMZ::lib/key-bindings.zsh
    OMZ::lib/theme-and-appearance.zsh
)

local LIGHT=(
    # [C] zinit light "string"
    # [P] string
    zdharma-continuum/history-search-multi-word
    Aloxaf/fzf-tab
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
    ael-code/zsh-colored-man-pages
)


# /---------- Custom Configs ----------/

# FZF Default Opts
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--height=100% --border --header-lines 1 --tac --tiebreak=begin \
--delimiter : \
--no-scrollbar --border-label "Search" \
"

# Source Profiles & Envs
. /etc/profile
. /etc/environment

# Zoxide Init
eval "$(zoxide init zsh)"

# The Fxck Init
eval "$(thefuck --alias)"

# Starship Init
eval "$(starship init zsh)"

# /---------- Plugins Manager ----------/

autoload -Uz compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
compinit -D

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit"
	command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

zinit ice lucid wait='0'
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'

for zinit_temp ("${SNIPPET[@]}") {
    zinit snippet "$zinit_temp"
}
unset zinit_temp

for zinit_temp ("${LIGHT[@]}") {
    zinit light "$zinit_temp"
}
unset zinit_temp

# /---------- Aliases ----------/

alias 'banner'='sudo pacman -Rscn'
alias 'ban'='sudo pacman -R'
alias 'sync'='paru'
alias 'shotlist'='sudo timeshift --list'
alias 'snapshot'='sudo timeshift --create && sudo update-grub'
alias 'banshot'='sudo timeshift --delete && sudo update-grub'
alias 'clearshot'='sudo timeshift --delete-all && sudo update-grub'
alias 'backup'='sudo timeshift --delete-all && sudo timeshift --create && sudo update-grub'
alias 'weztermrc'='sudo nvim ~/.config/wezterm/wezterm.lua'
alias 'l'="exa -lha --sort=type --icons=auto -M --time-style=relative --smart-group"
alias 'ls'="exa -lh --sort=type --icons=auto -M --time-style=relative --smart-group"
alias 'la'="exa -lha --sort=type --icons=auto -M --time-style=relative --smart-group"
alias 'll'="exa -lha --sort=type --icons=auto -M --time-style=relative --smart-group"
alias 'lc'='lolcat'
alias 'nf'='neofetch'
alias '.zshrc'='nvim ~/.zshrc'
alias "cd"="z"
alias 'time'='sudo mkdir $(date -d today +%Y%m%d-%H%M%S)'
alias 'hypr'='cd ~/.config/hypr/source'
alias 'fox'='musicfox'
alias 'clean'='ccache -C && sudo rm -rf ~/.cache/yay && sudo rm -rf ~/.cache/paru && sudo rm -rf ~/.local/share/pikaur && sudo pacman -Sc && echo "OK!"'
alias 'prt'='figlet'
alias 'fw'="fzf --disabled --bind 'change:reload:rg {q}'"
alias 'ff'="find . | fzf"
alias 'c'='cava'
alias 'sd'='shutdown 0'
