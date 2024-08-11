#!/bin/bash

#Turn base minimized ubuntu server into  useful dev machine


# Get apt to be quiet about restarting services
export DEBIAN_FRONTEND=noninteractive
export SCRIPT_DIR="$(dirname "$0")"

sudo apt update
sudo apt upgrade -y
#Install the basic utils
sudo apt install -y bind9-utils net-tools dnsutils git apt-file file cron \
	sway swaylock wayvnc xwayland kitty openssl copyq xsel\
	grimshot fonts-jetbrains-mono \
	firefox
mkdir ~/Pictures
#Install Jet Brains Unofficial Jetbrains repo
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt-get update

sudo apt install goland -y
#Install Golang
mkdir ~/bin
cd ~/bin
git clone https://github.com/udhos/update-golang
cd update-golang
sudo ./update-golang.sh
export UPDATE_GOLANG=$(pwd)
echo "0  4  *  *  *	root	${UPDATE_GOLANG}/update-golang.sh" | sudo tee -a /etc/crontab
echo 'source /etc/profile.d/golang_path.sh' >> ~/.bashrc
cd $SCRIPT_DIR

#Configure sway
mkdir -p ~/.config/{kitty,sway,swaylock}/

ln -s ~/snap/firefox/common/Downloads ~/Downloads

cp anime*.png ~/Downloads
cp -r .config ~/.config


#Do NeoVim
mkdir -p ~/.config/nvim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim ripgrep build-essential gcc make
#Add nodejs....
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

#Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
bash -c "rustup update"

#Setup user lingering
sudo loginctl enable-linger lvlint67

#Setup vnc service
sudo cp etc/vncserver\@.service /etc/systemd/system/
sudo cp bin/vnc_st* /usr/local/bin/
sudo systemctl daemon-reload
sudo systemctl enable vncserver@lvlint67
sudo systemctl restart vncserver@lvlint67

#Install Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo cp kubectl /usr/local/bin/
sudo chmod +x /usr/local/bin/kubectl

#Install helm
mkdir /tmp/helm
cd /tmp/helm
curl -OL https://get.helm.sh/helm-v3.14.4-linux-amd64.tar.gz
ls -la
tar -xzvf helm-v3.14.4-linux-amd64.tar.gz 
sudo cp linux-amd64/ /usr/local/bin/
sudo cp linux-amd64/helm /usr/local/bin/
chmod +x /usr/local/bin/helm 
sudo chmod +x /usr/local/bin/helm
cd -




#Setup last parts of dev enviornment
mkdir ~/git-repos
cd ~/git-repos
git clone git@github.com:daniel-widrick/lineinfile.git
cd lineinfile
go build lineinfile.go
sudo cp ./lineinfile /usr/local/bin/lineinfile
/usr/local/bin/lineinfile ~/.bashrc 'alias cdg="cd ~/git-repos"'
