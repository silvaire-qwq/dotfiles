#!/bin/zsh

local SNIPPET=(
    OMZ::plugins/git/git.plugin.zsh
    OMZ::lib/git.zsh
    OMZ::lib/clipboard.zsh
    OMZ::lib/completion.zsh
    OMZ::lib/history.zsh
    OMZ::lib/key-bindings.zsh
    OMZ::lib/theme-and-appearance.zsh
)

local LIGHT=(
    zdharma-continuum/history-search-multi-word
    Aloxaf/fzf-tab
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
    ael-code/zsh-colored-man-pages
)

local command_not_found_handler() {
    cmd="$1"
    prt="zsh: command not found: $cmd"
    package=$(pacman -Ss "^$cmd$" | grep "/$cmd " | awk -F '/' '{print $2}' | cut -d' ' -f1)
    SUGGESTION_CMD="NOT FOUND"
    if [[ -n "$package" ]]; then
        echo -ne "\e[33;1mWARNING\e[0m  Install $package now? \e[1m[\e[32;1mY\e[0;1m/\e[31;1mn\e[0;1m]\e[0m "
        read result
        export result
        export exitNumbers=$(echo $result | grep "n" | wc -l)
        if [[ $exitNumbers -ne 0 ]]; then
            echo -e "\e[33;1mWARNING\e[0m  Exited by $USER"
        else
            export log="/tmp/$(date "+%Y%m%d%H%M%S")"
            sudo pacman -S $package --noconfirm &>$log
            case $? in
                "0")
                    echo -e "\e[32;1mSUCCESS\e[0m  Please run your command again."
                    ;;
                *)
                    echo -e "\e[31;1mERROR\e[0m    Please do it by yourself, because:"
                    echo -e "\e[90m"
                    cat $log
                    echo "\e[0m"
                    ;;
            esac
        fi
    else
        echo $prt
    fi
    return 127
}

# List (exa) Default Options
local EXA_DEFAULT_OPTS=(
    '--color=auto'
    '--icons=auto'
    '--sort=type'
    '-M'
    '--time-style=relative'
    '--smart-group'
)

local OPTIONS=(
    'AUTO_CD'
    'AUTO_PUSHD'
    'CDABLE_VARS'
    'PUSHD_IGNORE_DUPS'
    'ALWAYS_TO_END'
    'AUTO_LIST'
    'AUTO_MENU'
    'AUTO_PARAM_KEYS'
    'AUTO_PARAM_SLASH'
    'AUTO_REMOVE_SLASH'
    'HASH_LIST_ALL'
    'LIST_AMBIGUOUS'
    'NO_BAD_PATTERN'
    'EXTENDED_GLOB'
    'UNSET'
    'APPEND_HISTORY'
    'EXTENDED_HISTORY'
    'HIST_EXPIRE_DUPS_FIRST'
    'HIST_FCNTL_LOCK'
    'HIST_FIND_NO_DUPS'
    'HIST_IGNORE_SPACE'
    'HIST_NO_FUNCTIONS'
    'HIST_REDUCE_BLANKS'
    'INC_APPEND_HISTORY_TIME'
    # 'CORRECT'
    'INTERACTIVE_COMMENTS'
    'CHECK_JOBS'
    'CHECK_RUNNING_JOBS'
    'HUP'
)

# /---------- Set Opts  ----------/

setopt $OPTIONS

# /---------- Custom Configs ----------/


# More Histories
export HISTSIZE=65535
export SAVEHIST=65535

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
. /etc/locale.conf

# Zoxide Init
eval "$(zoxide init zsh)"

# The Fxck Init
eval "$(thefuck --alias)"

# Starship Init
eval "$(starship init zsh)"

# Bun Init 
[ -s "/home/arch/.bun/_bun" ] && source "/home/arch/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

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

if [[ $(command -v pacman) ]]; then
    alias 'banner'='sudo pacman -Rscn'
    alias 'ban'='sudo pacman -R'
fi

if [[ $(command -v paru) ]]; then
    alias 'sync'='paru'
    alias 'clean'='ccache -C && sudo rm -rf ~/.cache/yay && sudo rm -rf ~/.cache/paru && sudo rm -rf ~/.local/share/pikaur && sudo pacman -Sc && echo "OK!"'
fi

if [[ $(command -v timeshift) ]]; then
    alias 'shotlist'='sudo timeshift --list'
    alias 'snapshot'='sudo timeshift --create && sudo update-grub'
    alias 'banshot'='sudo timeshift --delete && sudo update-grub'
    alias 'clearshot'='sudo timeshift --delete-all && sudo update-grub'
    alias 'backup'='sudo timeshift --delete-all && sudo timeshift --create && sudo update-grub'
fi

if [[ -f ~/.config/wezterm/wezterm.lua ]]; then
    alias 'weztermrc'='sudo nvim ~/.config/wezterm/wezterm.lua'
fi

if [[ $(command -v exa) ]]; then
    alias 'l'="exa -lha $EXA_DEFAULT_OPTS"
    alias 'ls'="exa -lh $EXA_DEFAULT_OPTS"
    alias 'la'="exa -lha $EXA_DEFAULT_OPTS"
    alias 'll'="exa -lha $EXA_DEFAULT_OPTS"
fi

[[ ! $(command -v z) ]] || alias "cd"="z"
[[ ! -d ~/.config/hypr ]] || alias 'hypr'='cd ~/.config/hypr'
[[ ! $(command -v cava) ]] || alias 'c'='cava'

# Force Alias
if [[ 1 -eq 1 ]]; then
    alias ...=../..
    alias ....=../../..
    alias .....=../../../..
    alias ......=../../../../..
    alias 1='cd -'
    alias 2='cd -2'
    alias 3='cd -3'
    alias 4='cd -4'
    alias 5='cd -5'
    alias 6='cd -6'
    alias 7='cd -7'
    alias 8='cd -8'
    alias 9='cd -9'
    alias 'sd'='shutdown 0'
    alias '.zshrc'='nvim ~/.zshrc'
fi
