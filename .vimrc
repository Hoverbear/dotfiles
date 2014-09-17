set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-dispatch'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'oblitum/rainbow'
Plugin 'wting/rust.vim'
Plugin 'gabrielelana/vim-markdown'
"Plugin 'Valloric/YouCompleteMe' " This is a COMPILED plugin. https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-super-quick-installation
                                " You'll need clang, cmake, and python-devel
Plugin 'scrooloose/syntastic'
" The following are examples of different formats supported.


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

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


" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Colors and fonts
syntax enable
set encoding=utf8
set ffs=unix,mac,dos
set background=dark
colorscheme solarized 
highlight MatchParen cterm=bold ctermfg=cyan
" Rainbow Colors Improved Setup
au FileType c,cpp,objc,objcpp,go,rust,javascript,java call rainbow#load()
au FileType clojure call rainbow#load([['(', ')'], ['\[', '\]'], ['{', '}']], '"[-+*/=><%^&$#@!~|:?\\]"')


" Fix some junk
set nobackup
set nowb
set noswapfile
set nocompatible

" Indents
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

set ai " Auto Indent
set si " Smart Indent
set wrap
