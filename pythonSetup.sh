#!/bin/bash

sudo mkdir -p /opt/{src,work}
cd /opt/src
sudo curl -OL https://download-cdn.jetbrains.com/python/pycharm-professional-2021.2.2.tar.gz

sudo tar -xzvf pycharm-professional-2021.2.2.tar.gz
sudo mv pycharm-2021.2.2 /opt/work/pycharm


