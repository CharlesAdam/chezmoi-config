#!/bin/bash

time_divider=18
fpath=~/Images/Wallpapers/Day/
fdate=$(date +"%H")
if [ "$fdate" -gt "$time_divider" ]; then
  fpath=~/Images/Wallpapers/Night/
fi

fname=$(ls $fpath | shuf -n 1)
echo "$fpath$fname"

if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
  plasma-apply-wallpaperimage "$fpath$fname"
fi

if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
  swww img "$fpath$fname"
fi
