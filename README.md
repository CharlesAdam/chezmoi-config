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

## Notebook Configurations

### Generic

#### Fingerprint

As described [in the documentation](https://wiki.archlinux.org/title/Fprint) to enroll
```
sudo fprintd-enroll $USER
```
Then to configure add 
```
auth      sufficient pam_fprintd.so
```
at the top of the wanted /etc/pam.d/ file
Ex: /etc/pam.d/sudo for sudo commands and /etc/pam.d/ly for ly login

### Samsung Galaxy Book Pro 2

#### Display Brightness

To control your display brightness add the following boot parameter
```
i915.enable_dpcd_backlight=3
```
Ex: as described [here](https://wiki.archlinux.org/title/Kernel_parameters#systemd-boot) systemd-boot file can be found at **/boot/loader/entries/arch.conf**

#### Fingerprint
Fprintd requires version> 1.94.5

#### Sound
In my case I had to install sof-firmware and alsa-ucm-conf in addition to pulse audio for the audio card recognition.
Speakers should work out of box, however if it does not please refer to [this great documentation](https://github.com/joshuagrisham/samsung-galaxybook-extras?tab=readme-ov-file#sound-from-the-speakers-enabling-speaker-amps)
