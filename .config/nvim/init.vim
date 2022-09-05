set exrc

set guicursor=
set relativenumber
set nu

set hidden
set noerrorbells

set noswapfile
set nobackup

set undodir=~/.vim/undodir
set undofile

set incsearch
set scrolloff=8

set colorcolumn=128
set signcolumn=yes

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set clipboard+=unnamedplus


call plug#begin(stdpath("data") . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

:colorscheme tokyonight
