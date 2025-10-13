#!/bin/bash

sh ~/bin/mpris-listener.sh &

alacritty --title spotify_player -e "spotify_player" &

FEH_SKIP_MAGIC=1 feh --scale-down --title "feh_spotify_current_artist" ~/.cache/custom/music/image/current-album.jpg &

alacritty --title cava_player -e "cava" &
