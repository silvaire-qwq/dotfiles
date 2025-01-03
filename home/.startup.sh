# Clear Screen
clear

# Auto Check & Update Dotfiles
cd ~/Dotfiles

if [[ $(sudo git diff | wc -l) -ne 0 ]]; then
	# Language
	export LANG="en_US.UTF-8"
	# Prompt
	echo -e "\e[34m*\e[0m Ready to Push"
	echo -e "\e[90;2m"
	# Add Files
	sudo git add .
	# Commit
	sudo git commit -m "* Started On $(date "+%Y/%m/%d %H:%M:%S")"
	# Remote
	sudo git push -uf origin main
	# Stop Grey
	echo -e "\e[0m"
	# Language
	export LANG="zh_CN.UTF-8"
fi

# Start Hyprland
Hyprland >/dev/null 2>&1
