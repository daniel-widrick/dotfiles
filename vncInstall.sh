#!/bin/bash

sudo dnf install -y tigervnc-server
sudo cp /usr/lib/systemd/system/vncserver@.service /etc/systemd/system/
sudo /usr/bin/cp .vnc/vncserver.users /etc/tigervnc/vncserver.users
sudo dnf install -y terminator i3 ImageMagick

#Install Brave-Browser
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser google-noto-emoji-color-fonts
sudo fc-cache -f -v

cp .vnc/xstartup ~/.vnc/
cp .vnc/config ~/.vnc/

echo "#############"
echo "run 'vncserver' to finish setting up vnc server"
echo "#############"
