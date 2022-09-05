#!/bin/bash

##To be executed as root


dnf install -y vim net-tools bind-utils nmap nc dnf-plugins-core
dnf install -y neo-vim alacritty
#code completion for rust in neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-linux-x64.vsix > ~/bin/rust-analyzer
chmod +x ~/bin/rust-analyzer
#Run :CocInstall coc-rust-analyzer
#Run :PlugInstall tokyonight.nvim
