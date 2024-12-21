#!/bin/bash

case $(whoami) in
	"root")
		echo -e "\e[31m==>\e[0m 你不能使用 Root 账户运行这个脚本。"
		exit 1
		;;
esac

if test -d $ScriptDir; then
	for profile in "$ScriptDir"/*.sh; do
		test -r "$profile" && . "$profile"
		case $? in
			"0")
				sleep 0
				;;
			*)
				echo -e "\e[31m==>\e[0m 运行 $profile 时失败。"
				exit 1
				;;
		esac
	done
	unset profile
fi