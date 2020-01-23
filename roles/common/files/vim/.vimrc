" highlight Cursor guifg=white guibg=black
" highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c-i:hor100
set nocompatible

set viminfo='100,<1000,s100,h

let g:rainbow_active = 1

set backspace=indent,eol,start

set number
set numberwidth=1
set ruler

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
syntax on
set t_Co=256
" colorscheme desert
colorscheme Monokai-Refined

set ignorecase

set mouse=a

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

set hlsearch
nmap <silent> <C-N> :silent noh<CR>
set incsearch

au BufRead,BufNewFile *.asm,*ASM set filetype=masm
set foldenable
set foldmethod=manual
set autoread
set clipboard+=unnamed

set shortmess=atI "


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

