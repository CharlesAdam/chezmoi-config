#!/bin/sh

service_exists() {
  local n=$1
  if [[ $(systemctl list-units --all -t service --full --no-legend "$n.service" | sed 's/^\s*//g' | cut -f1 -d' ') == $n.service ]]; then
    return 0
  else
    return 1
  fi
}

setup_fingerprint(){

#Fingerprint Configuration

	read -p "Enable Fingerprint ? (Y/N) " -n 1 -r
	echo
	if ! [[ $REPLY =~ ^[Yy]$ ]]
	then
		return
	fi
	sudo pacman -S --noconfirm --needed fprintd
	echo
	sudo fprintd-enroll $USER
	if ! grep -q "auth      sufficient pam_fprintd.so" "/etc/pam.d/sudo"
	then
		first_line="#%PAM-1.0\nauth      sufficient pam_fprintd.so"
		echo "missing auth parameter from sudo file, adding it ..."
		sudo sed -i "1s/.*/$first_line/" /etc/pam.d/sudo
	fi
	if ! grep -q "auth      sufficient pam_fprintd.so" "/etc/pam.d/ly"
	then
		first_line="#%PAM-1.0\nauth      sufficient pam_fprintd.so"
		echo "missing auth parameter from sudo file, adding it ..."
		sudo sed -i "1s/.*/$first_line/" /etc/pam.d/ly
	fi
}

setup_ssh(){
	read -p "Setup SSH Key and Agent? (Y/N) " -n 1 -r
	echo
	if ! [[ $REPLY =~ ^[Yy]$ ]]
	then
		return
	fi
	if [ -f ~/.ssh/id_ed25519 ] || [ -f ~/.ssh/id_ed25519.pub ]
	then
		echo "ssh files already have been created, please delete them"
		return
	fi
	echo
	read -p "enter your email: " email
	echo
	read -p "your email is $email (Y/N)? :" -n 1 -r
	echo
	if ! [[ $REPLY =~ ^[Yy]$ ]]
	then
		return
	fi
	ssh-keygen -t ed25519 -C $email
	PRIVATE_KEY= "~/.ssh/ed25519"
	ssh-add $PRIVATE_KEY
	/usr/lib/seahorse/ssh-askpass $PRIVATE_KEY

}

#Setup DE
sudo pacman -Sy --noconfirm --needed xdg-desktop-portal hyprland xdg-desktop-portal-hyprland uwsm libnewt wl-clipboard swww hyprpolkitagent

#Setup Login Manager
if ! service_exists ly; then
  	sudo pacman -S --noconfirm --needed ly
  	sudo systemctl enable --now ly@tty1.service
fi

#Setup Development En""vironment
sudo pacman -S --noconfirm --needed neovim alacritty git chezmoi docker

#Setup Tools
sudo pacman -S --noconfirm --needed htop zoxide firefox wget man unzip

#Setup Extra DE Tools
sudo pacman -S --noconfirm --needed waybar hyprlock dunst wofi zellij

#Setup Fonts
sudo pacman -S --noconfirm --needed ttf-sharetech-mono-nerd
sudo pacman -S --noconfirm --needed noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

#Setup Extra
sudo pacman -S --noconfirm --needed spotify-player lazygit feh openssl cava grim slurp

## Setup gnome-keyring

sudo pacman -S --noconfirm --needed gnome-keyring seahorse
systemctl --user enable gcr-ssh-agent.socket
systemctl --user start gcr-ssh-agent.socket

### To Add Keys execute /usr/lib/seahorse/ssh-askpass <KEY FILE>


setup_fingerprint
setup_ssh

if ! systemctl is-active --quiet 'ly.service'; then
  	sudo systemctl start ly@tty1.service
fi
