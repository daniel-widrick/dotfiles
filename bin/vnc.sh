#/bin/bash

ps -ef | grep way | awk '{print $2}' | xargs kill
sleep 5
XDG_RUNTIME_DIR=/tmp/ WLR_BACKENDS=headless WLR_LIBINPUT_NO_DEVICES=1 sway &
sleep 5
swaymsg --socket /tmp/sway-ipc.*.sock exec 'WAYLAND_DISPLAY=wayland-1 wayvnc 0.0.0.0 & swaylock'
