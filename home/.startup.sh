# Clear Screen
clear

# Check Update Dotfiles
cd ~/Dotfiles
if [[ $(sudo git diff | wc -l) -ne 0 ]]; then
	sudo git add .
	sudo git commit -m "Local Commit on Boot"
fi

# Start Hyprland
Hyprland &>/dev/null
