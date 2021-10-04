#!/bin/bash

BASEDIR="$(cd "$(dirname "$BASH_SOURCE[0]}")" && pwd)"

#git
rm -f ~/.gitconfig
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig

#i3
mkdir -p ~/.config/i3
rm -f ~/.config/i3/config
ln -s ${BASEDIR}/.config/i3/config ~/.config/i3/config

#terminator
mkdir -p ~/.config/terminator
rm -f ~/.config/terminator/config
ln -s ${BASEDIR}/.config/terminator/config ~/.config/terminator/config
