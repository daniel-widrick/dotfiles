#!/bin/bash

if [ ! -f ~/.gitconfig ]
then
	touch ~/.gitconfig
fi

export USERPROFILE=~

git submodule update --init --recursive
git submodule update --recursive --remote

docker compose up -d apt-cache
docker compose up -d linux-dev-desktop --build
