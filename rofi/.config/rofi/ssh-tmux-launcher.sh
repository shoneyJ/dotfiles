#!/bin/bash

# Grab SSH hosts from ~/.ssh/config
hosts=$(awk '/^Host / {for (i=2;i<=NF;i++) print $i}' ~/.ssh/config | sort -u)

# Use Rofi to select a host
selected=$(echo "$hosts" | rofi -dmenu -i -p "SSH Host:")

if [ -n "$selected" ]; then
  # Use tmux to open a new window with ssh session
  if [ -n "$TMUX" ]; then
    # Inside tmux: create a new window
    tmux new-window -n "$selected" "ssh $selected"
  else
    # Not inside tmux: start a new session
    tmux new-session -s "ssh-$selected" "ssh $selected"
  fi
fi
