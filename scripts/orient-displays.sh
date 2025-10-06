#!/usr/bin/env bash

set -xeuo pipefail

xrandr --output HDMI-0 --primary

# Get list of monitor names (excluding header line and HDMI-0)
MONITOR=$(xrandr --listmonitors | awk 'NR>1 {print $4}' | grep -v '^HDMI-0$' | head -n 1)

# Check if a monitor was found
if [ -z "$MONITOR" ]; then
  echo "No monitor found other than HDMI-0"
  exit 1
fi

# Rotate the selected monitor to the left
xrandr --output "$MONITOR" --rotate left
