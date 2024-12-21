#!/bin/bash

case $(whoami) in
	"root")
		echo -e "\e[31m*\e[0m 你不能使用 Root 账户运行这个脚本。"
		exit 1
		;;
esac

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

if test -d $ScriptDir; then
	for profile in $ScriptDir/*.sh; do
		echo -e "\e[34m*\e[0m 尝试运行 $profile"
		test -r "$profile" && . "$profile"
		case $? in
			"0")
				echo -e "\e[32m*\e[0m 成功。"
				;;
			*)
				echo -e "\e[31m*\e[0m 失败。"
				;;
		esac
	done
	unset profile
fi