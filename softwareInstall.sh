#!/bin/bash

##To be executed as root


dnf install -y vim i3 terminator net-tools bind-utils nmap nc dnf-plugins-core


#Install Brave-Browser
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install brave-browser
