#!/bin/bash

# Extract unique hosts from ~/.ssh/config
ssh_hosts=$(awk '/^Host / {for (i=2;i<=NF;i++) print $i}' ~/.ssh/config | sort -u)

# Let user pick a host using fzf
chosen_host=$(echo "$ssh_hosts" | fzf --prompt="Select SSH host: ")

if [ -z "$chosen_host" ]; then
  echo "No host selected. Exiting."
  exit 1
fi

# Sanitize session name (replace dots with underscores)
session_name="${chosen_host//./_}"

# Check if session exists
if tmux has-session -t "$session_name" 2>/dev/null; then
  tmux attach-session -t "$session_name"
else
  user=$(whoami)
  ssh_target="${user}@${chosen_host}"
  tmux new-session -s "$session_name" "ssh $ssh_target"
fi
