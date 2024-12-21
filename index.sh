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

case $(whoami) in
	"root")
		echo -e "\e[31m==>\e[0m 你不能使用 Root 账户运行这个脚本。"
		exit 1
		;;
esac

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