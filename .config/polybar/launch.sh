#!/usr/bin/env bash

# Launch bar on every monitor
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload default --config=$HOME/.config/polybar/config.ini &
  done
else
  polybar --reload default --config=$HOME/.config/polybar/config.ini &
fi
