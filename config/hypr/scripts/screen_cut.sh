#!/bin/sh

grim -g "$(slurp -d -b "#1e1e2eaa" -c "#B4BEFEff" -s "#00000000" -F "Liga SFMono Nerd Font")" - | wl-copy
export scrd="$(date +%Y%m%d%H%M%S)"
wl-paste >>/home/arch/图片/Screenshots/$scrd.png
echo $(file /home/arch/图片/Screenshots/$scrd.png) >>/home/arch/图片/Screenshots/$scrd.check
if [[ $(grep -c "empty" /home/arch/图片/Screenshots/$scrd.check) -eq "1" ]]; then
	sudo rm -rf /home/arch/图片/Screenshots/$scrd.png /home/arch/图片/Screenshots/$scrd.check
	exit 1
else
	notify-send "屏幕截图" "已复制到剪贴板并保存。"
	sudo rm -rf /home/arch/图片/Screenshots/$scrd.check
	imv /home/arch/图片/Screenshots/$scrd.png
fi
