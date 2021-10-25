#!/bin/bash

BASEDIR="$(cd "$(dirname "$BASH_SOURCE[0]}")" && pwd)"

#git
rm -f ~/.gitconfig
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig

#i3
mkdir -p ~/.config/i3
rm -f ~/.config/i3/config
ln -s ${BASEDIR}/.config/i3/config ~/.config/i3/config
ln -s ${BASEDIR}/.config/i3/i3status.conf ~/.config/i3/i3status.conf

#terminator
mkdir -p ~/.config/terminator
rm -f ~/.config/terminator/config
ln -s ${BASEDIR}/.config/terminator/config ~/.config/terminator/config
ln -s ${BASEDIR}/.profile ~/.profile

#tigervnc server
mkdir -p ~/.vnc
rm -f ~/.vnc/config
ln -s ${BASEDIR}/.vnc/config ~/.vnc/config
rm -f ~/.vnc/xstartup
ln -s ${BASEDIR}/.vnc/xstartup ~/.vnc/xstartup

#timezone
timedatectl set-timezone America/New_York
