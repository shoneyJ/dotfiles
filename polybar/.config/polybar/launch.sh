#!/bin/bash

# Kill existing polybar instances
killall -q polybar

killall -q i3bar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
while pgrep -u $UID -x i3bar >/dev/null; do sleep 1; done
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi
