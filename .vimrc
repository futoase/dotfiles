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

if &compatible
  set nocompatible
endif
set runtimepath^=/Users/futoase/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/Users/futoase/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('altercation/vim-colors-solarized')
call dein#add('scrooloose/syntastic')
call dein#add('vim-scripts/opsplorer')
call dein#add('vim-scripts/nginx.vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('tsaleh/vim-matchit')
call dein#add('ecomba/vim-ruby-refactoring')
call dein#add('rking/ag.vim')
call dein#add('jnwhiteh/vim-golang')
call dein#add('Shougo/neocomplcache')
call dein#add('vim-scripts/sudo.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/unite.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-fugitive')
call dein#add('Lokaltog/powerline')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('elixir-lang/vim-elixir')
call dein#add('honza/dockerfile.vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('kchmck/vim-coffee-script')
call dein#add('vim-ruby/vim-ruby')
call dein#add('JuliaLang/julia-vim')
call dein#add('mklabs/grunt.vim')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-bundler')
call dein#add('tpope/vim-rake')
call dein#add('basyura/unite-rails')
call dein#add('dag/vim-fish')
call dein#add('ekalinin/Dockerfile.vim')
call dein#add('chase/vim-ansible-yaml')
call dein#add('toyamarinyon/vim-swift')
call dein#add('yoppi/fluentd.vim')
call dein#add('chrisbra/Recover.vim')
call dein#add('raichoo/purescript-vim')
call dein#add('kurayama/systemd-vim-syntax')
call dein#add('AndrewRadev/vim-eco')
call dein#add('derekwyatt/vim-scala')
call dein#add('mattn/gist-vim', {'depends': 'mattn/webapi-vim'})
call dein#add('xolox/vim-session')
call dein#add('xolox/vim-misc')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('cespare/vim-toml')
call dein#add('dart-lang/dart-vim-plugin')
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('haya14busa/incsearch.vim')
call dein#add('mxw/vim-jsx')
call dein#add('Shutnik/jshint2.vim')
call dein#add('AndrewRadev/switch.vim')
call dein#add('lambdatoast/elm.vim')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('rking/ag.vim')
call dein#add('honza/vim-snippets')
call dein#add('rust-lang/rust.vim')
call dein#add('moll/vim-node')
call dein#add('rhysd/vim-crystal')
call dein#add('junegunn/vim-easy-align')
call dein#add('udalov/kotlin-vim')
call dein#add('tfnico/vim-gradle')

"if dein#check_install()
"  call dein#install()
"endif

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
autocmd BufWritePre * :%s/\s\+$//ge

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

let g:session_autoload='no'
