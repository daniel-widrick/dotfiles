#!/bin/bash

if [ ! -f ~/.gitconfig ]
then
	touch ~/.gitconfig
fi

export USERPROFILE=~

docker compose up -d apt-cache
docker compose up -d linux-dev-desktop --build
