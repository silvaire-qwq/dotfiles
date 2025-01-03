# Clear Screen
clear

# Auto Check & Update Dotfiles
cd ~/Dotfiles

if [[ $(sudo git diff | wc -l) -ne 0 ]]; then
	# Language
	export LANG="en_US.UTF-8"
	# Add Files
	sudo git add . &>/dev/null
	# Commit
	sudo git commit -m "* Started On $(date "+%Y/%m/%d %H:%M:%S")" &>/dev/null
	# Remote
	echo -e "\e[35;1m==>\e[0;1m Ready to Push"
	echo -e "\e[90;2m"
	sudo git push -uf origin main
	echo -e "\e[0m"
	# Language
	export LANG="zh_CN.UTF-8"
fi

# Start Hyprland
Hyprland >/dev/null 2>&1
