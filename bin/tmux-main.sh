#!/bin/bash

if ! tmux has-session -t main 2>/dev/null; then
  tmux new-session -d -s main
fi

ssh_hosts=$(awk '/^Host / {for (i=2;i<=NF;i++) print $i}' ~/.ssh/config | sort -u)

for host in $ssh_hosts; do
  if ! tmux has-session -t $host 2>/dev/null; then
    tmux new-session -d -s $host
  fi

done

exec tmux attach-session -t main
