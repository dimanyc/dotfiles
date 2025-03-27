set number
set colorcolumn=80
set clipboard=unnamed
set paste
set term=screen-256color
set termguicolors
set signcolumn=yes
set tabstop=2
set noswapfile
syntax on
set re=0

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-test/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

source ~/.config/vim/vim-coc.vimrc
source ~/.config/vim/vim-colors.vimrc


nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'
