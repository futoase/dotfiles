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
Bundle 'rking/ag.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'vim-scripts/sudo.vim'

syntax enable

if has('gui_running')
  set transparency=8
  set t_Co=256
  set background=dark
  let g:solarized_termcolors=256
  colorscheme solarized
endif

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionaly_filetype_lists = {
    \ 'default': ''
    \ }
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
