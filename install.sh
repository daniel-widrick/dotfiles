#!/bin/bash

#Turn base minimized ubuntu server into  useful dev machine


# Get apt to be quiet about restarting services
export DEBIAN_FRONTEND=noninteractive
export SCRIPT_DIR="$(dirname "$0")"

sudo apt update
sudo apt upgrade -y
#Install the basic utils
sudo apt install -y bind9-utils net-tools dnsutils vim git apt-file file cron \
	sway swaylock wayvnc xwayland kitty openssl\
	firefox
#Install Jet Brains Unofficial Jetbrains repo
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt-get update

sudo apt install goland -y
#Install Golang
mkdir ~/bin
cd ~/bin
git clone https://github.com/udhos/update-golang
cd update-golang
sudo ./update-golang.sh
export UPDATE_GOLANG=$(pwd)
echo "0  4  *  *  *	root	${UPDATE_GOLANG}/update-golang.sh" | sudo tee -a /etc/crontab
echo 'source /etc/profile.d/golang_path.sh' >> ~/.bashrc
cd $SCRIPT_DIR

#Configure sway
mkdir -p ~/.config/{kitty,sway,swaylock}/

ln -s ~/snap/firefox/common/Downloads ~/Downloads

cp anime*.png ~/Downloads
cp -r .config ~/.config
