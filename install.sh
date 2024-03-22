#!/bin/bash

#Turn base minimized ubuntu server into  useful dev machine


# Get apt to be quiet about restarting services
export DEBIAN_FRONTEND=noninteractive

apt update
apt upgrade -y
#Install the basic utils
apt install -y bind9-utils net-tools dnsutils vim git apt-file \
	sway swaylock wayvnc xwayland kitty openssl\
	firefox

#Configure sway
mkdir -p ~/.config/{kitty,sway,swaylock}/

ln -s ~/snap/firefox/common/Downloads ~/Downloads

cp anime*.png ~/Downloads
cp -r .config ~/.config
