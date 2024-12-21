#!/bin/bash

export deps="/arch/deps"
export ScriptDir="/arch/scripts"
export WorkDir="/arch/storage"

export UserHomeConfig=(
	# Desktop
	hypr
	waybar
	mako
	wlogout
	wezterm

	# Terminal
	cava
	nvim
	lvim
	neofetch
)

export UserHomeDot=(
	.zshrc
	.zprofile
)

case $1 in
    "update")
        . "$deps/update.sh"
        cd $WorkDir/..
        ;;
    "push")
        bash "$deps/push.sh"
        ;;
    *)
        . "$deps/update.sh"
        cd $WorkDir/..
        bash "$deps/push.sh"
        ;;
esac