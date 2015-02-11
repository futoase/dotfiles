set shell=/bin/sh

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
set spell

"neobundle
"
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/opsplorer'
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'rking/ag.vim'
NeoBundle 'jnwhiteh/vim-golang'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'honza/dockerfile.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'JuliaLang/julia-vim'
NeoBundle 'mklabs/grunt.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-rake'
NeoBundle 'basyura/unite-rails'
NeoBundle 'dag/vim-fish'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'yoppi/fluentd.vim'
NeoBundle 'chrisbra/Recover.vim'
NeoBundle 'raichoo/purescript-vim'
NeoBundle 'kurayama/systemd-vim-syntax'
NeoBundle 'AndrewRadev/vim-eco'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'xolox/vim-session'
NeoBundle 'xolox/vim-misc'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'cespare/vim-toml'
NeoBundle 'dart-lang/dart-vim-plugin'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'Shutnik/jshint2.vim'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'rking/ag.vim'
NeoBundle 'honza/vim-snippets'

filetype plugin indent on

set autoindent 
set shiftwidth=2
set tabstop=2
set expandtab

syntax enable

if has('gui_running')
  set transparency=8
  set t_Co=256
  set background=dark
  let g:solarized_termcolors=256
  colorscheme solarized
else
  colorscheme molokai
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

" rubocop
let g:syntastic_mode_map = { 'mode': 'passive',
            \  'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_quiet_messages = { 'level': 'warnings' }

" empty file is auto remove.
augroup BUFWRITE_POSTDELETE
  au!
  autocmd BufWritePost * call BufWritePostDelete()
augroup END

function! BufWritePostDelete()
  let crlen = 0
  if &binary == 0
    let crlen = &ff=='dos' ? 2 : 1
  endif
  if getfsize(expand('%:p')) <= crlen
    call delete(expand('%:p'))
  endif
endfunction

" use f command then IME off.
nnoremap <silent> f :set iminsert=0<CR>f
nnoremap <silent> F :set iminsert=0<CR>F

" emphansized tab and new line.
set list
set listchars=eol:¶,tab:>.

" Powerlne
set laststatus=2
set rtp+=~/.vim/neobundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

" spell check ascii code only
fun! s:SpellConf()
  set spell
  syntax spell notoplevel
  syntax match SpellNotAscii /\<\A\+\>/ contains=@NoSpell transparent
  syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END

au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif 

autocmd BufNewFile,BufRead *.cap set filetype=ruby
let g:NERDTreeShowHidden=1

" vim indent-guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2f4f4f ctermbg=242
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#008080 ctermbg=247

" python setting
au BufNewFile,BufRead *.py set nowrap tabstop=2 softtabstop=2 shiftwidth=2

" docker file
autocmd BufNewFile,BufReadPost Dockerfile set filetype=sh

set wrap
let g:session_autosave = 'no'

imap [ []<left>
imap ( ()<left>
imap { {}<left>

imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

nmap <Esc><Esc> :nohlsearch<CR><Esc>
