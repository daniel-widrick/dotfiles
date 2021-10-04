#!/bin/bash

BASEDIR="$(cd "$(dirname "$BASH_SOURCE[0]}")" && pwd)"

#git
rm -f ~/.gitconfig
ln -s ${BASEDIR}/.gitconfig ~/.gitconfig
