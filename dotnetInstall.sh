#!/bin/bash

sudo mkdir /opt/{src,work}
cd /opt/src
sudo curl -OL https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2021.2.1.tar.gz

sudo tar -xzvf JetBrains.Rider-2021.2.1.tar.gz
sudo mv /opt/src/JetBrains\ Rider-2021.2.1 /opt/work/rider

sudo curl -OL https://download.visualstudio.microsoft.com/download/pr/5fcb98bb-21e1-47a5-bb8e-bb25f41a3e52/04811d5d05b7e694f040d2a13c1aae4c/dotnet-sdk-6.0.100-rc.1.21463.6-linux-x64.tar.gz

sudo mkdir /opt/work/dotnet
cd /opt/work/dotnet
sudo tar -xzvf /opt/src/dotnet-sdk-6.0.100-rc.1.21463.6-linux-x64.tar.gz

dnf install -y mono-core mono-devel
