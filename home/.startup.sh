# Clear Screen
clear

# Auto Check & Update Dotfiles
cd ~/Dotfiles

if [[ $(sudo git diff | wc -l) -ne 0 ]]; then
	# Need Update
	sudo git add .
	sudo git commit -m "[AP] Boot On $(date "+%Y/%m/%d %H:%M:%S")"
	sudo git push
fi

# Start Hyprland
Hyprland >/dev/null 2>&1
