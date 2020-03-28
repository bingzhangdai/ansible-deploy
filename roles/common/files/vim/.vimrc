" https://vimhelp.org/
" change cursor shape
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
" reset cursor on start:
autocmd VimEnter * silent !echo -ne "\e[2 q"

set nocompatible

set viminfo='100,<1000,s100,h

call plug#begin()
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
call plug#end()

if $TMUX != ''
    set ttimeoutlen=20
elseif &ttimeoutlen > 60 || &ttimeoutlen <= 0
    set ttimeoutlen=60
endif

" Enhance command-line completion
set wildmenu
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" Enable line numbers
set number
set numberwidth=1
" Highlight current line
" set cursorline
" Show the cursor position
set ruler
" Show the current mode
set showmode
" Show the (partial) command as it's being typed
set showcmd

set history=1000

set nobackup
set noswapfile

set showmatch
set matchtime=5
set autoindent
set cindent
set smartindent

syntax enable
" Enable syntax highlighting
syntax on
set t_Co=256

" colorscheme desert
colorscheme monokai
" override background
hi Normal ctermbg=BLACK 
hi LineNr ctermbg=BLACK 
hi NonText ctermbg=BLACK 

" Always show status line
set laststatus=2
" Enable mouse in normal and visual mode
set mouse=nv
" Disable error bells
set noerrorbells
" Show the filename in the window titlebar
set title
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab

set expandtab
%retab!

set fileencodings=utf-8,gb18030,ucs-bom,cp936,big5,euc-jp,euc-kr,latin1

filetype on
filetype indent on
highlight CursorLine cterm=NONE ctermbg=blue ctermfg=white
highlight ColorColumn guibg=Red
" Highlight searches
set hlsearch
" Ignore case when the pattern contains lowercase letters only
set smartcase
" Highlight dynamically as pattern is typed
set incsearch

nmap <silent> <C-N> :silent noh<CR>

au BufRead,BufNewFile *.asm,*ASM set filetype=masm
set foldenable
set foldmethod=manual
set autoread
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard+=unnamed
" Don't show the intro message when starting Vim
set shortmess=atI


autocmd BufNewFile *.cpp,*.c exec ":call SetTitle()" 
func SetTitle()
    if &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call append(line("."), "using namespace std;")
    endif
    if &filetype == 'c'
        call setline(1, "#include <stdio.h>")
        call append(line("."), "#include <stdlib.h>")
    endif
    call append(line(".")+1, "") 
    call append(line(".")+2, "int main(void) {")
    call append(line(".")+3, "")
    call append(line(".")+4, "    return 0;")
    call append(line(".")+5, "}")
    call append(line(".")+6, "")
endfunc
