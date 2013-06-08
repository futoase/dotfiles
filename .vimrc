set guifont=Andale\ Mono:h20

set clipboard=unnamed
set number
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/opsplorer'
Bundle 'vim-scripts/nginx.vim'
Bundle 'leafgarland/typescript-vim'

syntax enable

if has('gui_running')
  set transparency=8
  set t_Co=256
  set background=dark
  let g:solarized_termcolors=256
  colorscheme solarized
endif

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
