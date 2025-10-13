#!/bin/bash

#spotify-player is mpris events are very slow, so we are listening to notifications from dbus

state=0

dbus-monitor "interface='org.freedesktop.Notifications'" |
  while read line; do
    if [[ $line == "signal"* ]]; then
      state=0
      echo $line
      continue
    fi
    if [[ $line == "method"* ]]; then
      state=1
      echo $line
      continue
    fi
    if [[ $state == 0 ]]; then
      #echo "skipped line: " $line
      continue
    fi
    if [[ $line == "string"* && $line == *"spotify_player"* ]]; then
      state=2
      echo $line
    fi
    if [[ $line == "string"* && $line == *"/home/charlos/.cache/spotify-player/image"* ]]; then
      state=0
      echo $line | grep -oP '"(\/home\/charlos\/\.cache\/spotify-player\/image.*?)"' |
        xargs -I '{}' cp {} /home/charlos/.cache/custom/music/image/current-album.jpg
      continue
    fi
  done

#dbus-monitor "interface='org.freedesktop.Notifications'" |
#  grep --line-buffered "string" |
#  grep --line-buffered -e method -e ":" -e '""' -e urgency -e notify -v |
#  grep --line-buffered '.*(?=string)|(?<=string).*' -oPi |
#  grep --line-buffered -v '^\s*$' |
#  xargs -I '{}' echo {}
