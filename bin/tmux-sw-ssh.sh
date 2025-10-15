#!/bin/bash

direction="$1" # either '-h' or '-v'; default to -h if empty

if [[ "$direction" != "-v" ]]; then
  direction="-h"
fi

ssh_hosts=$(awk '/^Host / {for (i=2;i<=NF;i++) print $i}' ~/.ssh/config | sort -u)
session_name=$(tmux display-message -p '#S')
host_name="${session_name//_/.}"
if echo "$ssh_hosts" | grep -qx "$host_name"; then
  user=$(whoami)
  ssh_target="${user}@${host_name}"
  tmux split-window $direction -c "#{pane_current_path}" "ssh $ssh_target"
else
  tmux split-window $direction -c "#{pane_current_path}"
fi
