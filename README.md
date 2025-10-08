# chezmoi-config

## Usage
1. Install Chezmoi
2. Install Git
3. chezmoi init --apply https://github.com/CharlesAdam/chezmoi-config.git

## SSH Configuration

### Base Configuration

### Keyring
Enable and start the agent
```
systemctl --user --now enable gcr-ssh-agent.socket
```
Follow [Arch Linux Documentation](https://wiki.archlinux.org/title/GNOME/Keyring)

Generate keys with ssh-keygen command
```
ssh-keygen -t ed25519 -C "your_email@example.com"
```
and add to agent with
```
ssh-add ~/.ssh/<Private Key File Name>
```
or if you are using gnome Keyring you can persist it with
```
/usr/lib/seahorse/ssh-askpass <Private Key File>
```
Further documentation can be found [at the github page](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
