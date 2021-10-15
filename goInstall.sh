
mkdir -p /opt/{src,work}
cd /opt/src
sudo curl -LO https://download.jetbrains.com/go/goland-2021.2.3.tar.gz
sudo tar -xzvf goland-2021.2.3.tar.gz
mv GoLand-2021.2.3 /opt/work/goland

sudo dnf install golang -y
