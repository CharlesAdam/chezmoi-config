#!/bin/bash

#SSH
systemctl --user enable --now ssh-agent.service
systemctl --user enable --now gcr-ssh-agent.socket

#Wallpaper
systemctl --user enable --now swww.service
systemctl --user enable --now waybar.service
systemctl --user enable --now time-paper.service
