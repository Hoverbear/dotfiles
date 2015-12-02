filetype off " Just for now!
set nocompatible              " be iMproved

call plug#begin('~/.config/nvim/plugged')
" Language support
Plug 'sheerun/vim-polyglot'
Plug 'mustache/vim-mustache-handlebars'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-liquid'
" Theme
Plug 'ajh17/Spacegray.vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
" Utility
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'racer-rust/vim-racer'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" General
set history=700
set autoread
set magic
set showmatch " Brackets
set noerrorbells
set novisualbell
set mouse=a
set number
set clipboard=unnamedplus
filetype plugin on

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1 " https://github.com/powerline/fonts
let g:airline_theme = "murmur"
let g:tmuxline_powerline_separators = 1

" Racer
set hidden
let g:racer_cmd = '~/.cargo/bin/racer'
let $RUST_SRC_PATH = '~/git/rust/src/'
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:racer_experimental_completer = 1

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Colors and fonts
syntax enable
set encoding=utf8
set ffs=unix,mac,dos
set background=dark
colorscheme spacegray

" Fix some junk
set nobackup
set nowb
set noswapfile
set nocompatible

" Indents
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ai " Auto Indent
set si " Smart Indent
set wrap
