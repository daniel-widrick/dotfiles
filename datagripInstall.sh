#!/bin/bash

sudo mkdir -p /opt/{src,work}
cd /opt/src/
sudo curl -OL https://download-cdn.jetbrains.com/datagrip/datagrip-2021.2.3.tar.gz
sudo tar -xzvf datagrip-2021.2.3.tar.gz
sudo mv DataGrip-2021.2.3 /opt/work/datagrip
