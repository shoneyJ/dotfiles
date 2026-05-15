#!/bin/bash

direction="$1" # either '-h' or '-v'; default to -h if empty

if [[ "$direction" != "-v" ]]; then
  direction="-h"
fi

ssh_hosts=$(awk '/^Host / {for (i=2;i<=NF;i++) print $i}' ~/.ssh/config | sort -u)
session_name=$(tmux display-message -p '#S')
host_name="${session_name//_/.}"

# Use the systemd ssh-agent socket directly (matches ~/.bashrc setting)
SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"

if echo "$ssh_hosts" | grep -qx "$host_name"; then
  tmux split-window $direction -c "#{pane_current_path}" -e "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" "ssh $host_name"
else
  tmux split-window $direction -c "#{pane_current_path}"
fi
