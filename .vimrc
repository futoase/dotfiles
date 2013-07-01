set guifont=Andale\ Mono:h20

set clipboard=unnamed
set number
set nocompatible
set wildmenu
set autoread
set wrapscan
set incsearch
set hlsearch
set showcmd
set showmode
set display=uhex
set cursorline

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/opsplorer'
Bundle 'vim-scripts/nginx.vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'ecomba/vim-ruby-refactoring'

syntax enable

if has('gui_running')
  set transparency=8
  set t_Co=256
  set background=dark
  let g:solarized_termcolors=256
  colorscheme solarized
endif

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
