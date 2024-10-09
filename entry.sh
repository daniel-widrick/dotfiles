#!/bin/bash

export XDG_RUNTIME_DIR=/tmp/.xdg-runtime
export WAYLAND_DISPLAY=wayland-1

echo "Starting SSH Server..."
sshd

echo "My Docker user: ${MYUSERNAME}"

echo "Start sway..."
sudo -E -u ${MYUSERNAME} sway &
sleep 5
echo "Start wayvnc..."
sudo -E -u ${MYUSERNAME} wayvnc 0.0.0.0 5901 -r /$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
