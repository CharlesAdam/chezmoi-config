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
sudo pacman -Sy --noconfirm --needed xdg-desktop-portal hyprland xdg-desktop-portal-hyprland uwsm libnewt wl-clipboard swww

#Setup Login Manager
if ! service_exists ly; then
  sudo pacman -S --noconfirm --needed ly
  sudo systemctl enable --now ly@tty1.service
fi

#Setup Development Environment
sudo pacman -S --noconfirm --needed neovim alacritty git chezmoi docker

#Setup Tools
sudo pacman -S --noconfirm --needed htop zoxide firefox wget man unzip

#Setup Extra DE Tools
sudo pacman -S --noconfirm --needed waybar hyprlock dunst wofi

#Setup Fonts
sudo pacman -S --noconfirm --needed ttf-sharetech-mono-nerd
sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

if ! systemctl is-active --quiet 'ly.service'; then
  sudo systemctl start ly@tty1.service
fi

#Setup Extra
sudo pacman -S --noconfirm --needed spotify-player lazygit feh openssl cava grim slurp

## Setup gnome-keyring

sudo pacman -S --noconfirm --needed gnome-keyring seahorse
systemctl --user enable gcr-ssh-agent.socket
systemctl --user start gcr-ssh-agent.socket

### To Add Keys execute /usr/lib/seahorse/ssh-askpass <KEY FILE>
