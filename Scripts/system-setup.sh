#!/bin/sh

service_exists() {
    local n=$1
    if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
        return 0
    else
        return 1
    fi
}

#Setup DE
sudo pacman -S --needed xdg-desktop-portal hyprland xdg-desktop-portal-hyprland uwsm libnewt

#Setup Login Manager
if service_exists ly; then
	sudo pacman -S --needed ly
	sudo systemctl enable ly.service
fi

#Setup Extra DE Tools
sudo pacman -S --needed waybar hyprlock dunst wofi

#Setup Tools
sudo pacman -S --needed neovim htop alacritty git zoxide firefox chezmoi wget

#Setup Fonts
sudo pacman -S --needed ttf-sharetech-mono-nerd

if systemctl is-active --quiet 'ly.service'; then
	sudo systemctl start ly.service
fi

#Setup Extra
sudo pacman -S --needed spotify-player lazygit feh
