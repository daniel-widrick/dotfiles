
ssh-keygen -t rsa -b 8192 -N "" -f ~/.ssh/id_rsa
mkdir ~/git-repos
cd ~/git-repos
yes | git clone git@github.com:daniel-widrick/dotfiles.git
cd dotfiles
./run.sh

