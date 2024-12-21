#!/bin/bash

echo -e "\e[34m==>\e[0m 尝试运行备份脚本"

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

echo -e "\e[32m==>\e[0m 成功。"