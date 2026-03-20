#!/bin/bash

DIRECTORY="/mnt/MediaDrive"

while true; do
  TRUNCATED_DIRECTORY="${DIRECTORY:0:50}"

  ITEM=$( (echo ".." && ls "$DIRECTORY") | dmenu -i -p "$TRUNCATED_DIRECTORY" -fn "Inconsolata:bold:pixelsize=28" -nb "#292929" -nf "#CCCCCC" -sf "#fdf6e3" -sb "#3a615c" -l 15 -bw 8)

  if [ -n "$ITEM" ]; then
    if [ "$ITEM" == ".." ]; then
      DIRECTORY=$(dirname "$DIRECTORY")
    elif [ -d "$DIRECTORY/$ITEM" ]; then
      DIRECTORY="$DIRECTORY/$ITEM"
    elif [ -f "$DIRECTORY/$ITEM" ]; then
      xdg-open "$DIRECTORY/$ITEM"
      break
    else
      echo "Not valid"
    fi
  else
    break
  fi
done

