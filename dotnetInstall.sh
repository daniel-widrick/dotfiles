#!/bin/bash

sudo mkdir /opt/{src,work}
cd /opt/src
sudo curl -OL https://download.jetbrains.com/rider/JetBrains.Rider-2021.2.2.tar.gz

sudo tar -xzvf JetBrains.Rider-2021.2.2.tar.gz
sudo mv /opt/src/JetBrains\ Rider-2021.2.2 /opt/work/rider


sudo curl -OL https://download.visualstudio.microsoft.com/download/pr/17b6759f-1af0-41bc-ab12-209ba0377779/e8d02195dbf1434b940e0f05ae086453/dotnet-sdk-6.0.100-linux-x64.tar.gz


sudo mkdir /opt/work/dotnet
cd /opt/work/dotnet
sudo tar -xzvf /opt/src/dotnet-sdk-6.0.100-linux-x64.tar.gz

dnf install -y mono-core mono-devel
