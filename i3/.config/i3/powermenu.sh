#!/bin/bash

# Options
lock=" Lock"
poweroff="⏻ Power Off"
options="$lock\n$poweroff"

# rofi command
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
"$lock")

  i3lock

  ;;
"$poweroff")
  systemctl poweroff
  ;;
*) ;;
esac
