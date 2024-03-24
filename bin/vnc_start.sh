#!/usr/bin/bash

cd $HOME

XDG_RUNTIME_DIR=/tmp/ WLR_BACKENDS=headless WLR_LIBINPUT_NO_DEVICES=1 sway &
sleep 5
swaymsg --socket /tmp/sway-ipc.*.sock exec 'WAYLAND_DISPLAY=wayland-1 wayvnc 0.0.0.0 & swaylock'

systemd-notify READY=1
while true
do
	sleep 60
done
