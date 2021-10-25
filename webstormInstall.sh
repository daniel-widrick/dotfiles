sudo mkdir -p /opt/{src,work}
cd /opt/src/

sudo curl -OL https://download-cdn.jetbrains.com/webstorm/WebStorm-2021.2.3.tar.gz
sudo tar -xzvf WebStorm-2021.2.3.tar.gz
sudo rm -rf /opt/work/webstorm.bck
sudo mv /opt/work/webstorm /opt/work/webstorm.bck
sudo mv WebStorm-212.5457.55 /opt/work/webstorm
