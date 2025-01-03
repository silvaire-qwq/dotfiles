# Clear Screen
clear

# Auto Check & Update Dotfiles
cd ~/Dotfiles

if [[ $(sudo git diff | wc -l) -ne 0 ]]; then
	# Add Files
	sudo git add . &>/dev/null
	# Commit
	sudo git commit -m "* Started On $(date "+%Y/%m/%d %H:%M:%S")" &>/dev/null
	# Remote
	sudo git push -uf origin main
fi

# Start Hyprland
Hyprland >/dev/null 2>&1
