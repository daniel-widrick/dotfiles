#!/bin/bash

sudo mkdir /opt/{src,work}
cd /opt/src
sudo curl -OL https://download.jetbrains.com/rider/JetBrains.Rider-2021.2.2.tar.gz

sudo tar -xzvf JetBrains.Rider-2021.2.2.tar.gz
sudo mv /opt/src/JetBrains\ Rider-2021.2.2 /opt/work/rider

sudo curl -OL https://download.visualstudio.microsoft.com/download/pr/20283373-1d83-4879-8278-0afb7fd4035e/56f204f174743b29a656499ad0fc93c3/dotnet-sdk-6.0.100-rc.2.21505.57-linux-x64.tar.gz


sudo mkdir /opt/work/dotnet
cd /opt/work/dotnet
sudo tar -xzvf /opt/src/dotnet-sdk-6.0.100-rc.2.21505.57-linux-x64.tar.gz

dnf install -y mono-core mono-devel
