#!/bin/zsh
if [[ $(echo $TERM | tr -cd "[:alnum:]\"\n") != "linux" ]]; then
    sleep 0
else
    clear
    Hyprland > /dev/null 2>&1
fi
