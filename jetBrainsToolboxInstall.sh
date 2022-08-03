
mkdir -p /opt/{src,work}
cd /opt/src
#sudo curl -LO https://download.jetbrains.com/go/goland-2021.2.3.tar.gz
sudo curl -LO https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.25.12569.tar.gz
sudo tar -xzvf jetbrains-toolbox-1.25.12569.tar.gz
mv jetbrains-toolbox-1.25.12569 /opt/work/jetbrains-toolbox

#sudo dnf install golang -y
