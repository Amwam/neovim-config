syntax on "Syntax highlighting
filetype plugin indent on
set relativenumber " Line numbers in the gutter
set number " Show the current line number instead of '0'
set hidden " hide buffers instead of closing
set title " Change the terminal title

let mapleader = " "
"
" When not in insert mode, use normal line numbers, Write mode for relative
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting

" Force the use of hjkl
map <up> <nop>
map <down> <nop>

" Use left and right to switch buffers
map <left> :bprevious<CR>
map <right> :bnext<CR>

" Write the file if there is a change, on exiting insert mode
au InsertLeave * if &mod && expand('%')!=''|write|endif

" Write file on focus lost
au FocusLost * :wa

set textwidth=150 " default text width, purposly high just in case

" Tab options
set expandtab " Insert spaces instead of tabs
set tabstop=4 " 4 spaces for every tab
set shiftwidth=4

set bs=2 " make backspace behave like normal again

" Search improvements
set incsearch "Highlight as you search
set ignorecase "ignore case when seaching
set smartcase "Ignores case, except when capitals are used

" Trim trailing whitespace on save, for specified file types only
autocmd BufWritePre *.{py,h,c,java,rs,js,json,php} :%s/\s\+$//e

" Run Neomake on buffer changes
autocmd! BufWritePost,BufEnter * Neomake

" enables :Paste to just do what you want
command Paste execute 'set noai | insert | set ai'

" Set the clipboard to use the OS X default, rather than vim's
set clipboard=unnamed

" Ack searching
nmap <leader>a <Esc>:Ack! <space>


call plug#begin('~/.vim/plugged')
Plug 'benekastah/neomake'
call plug#end()

" Neomake configuration
let g:neomake_python_enabled_makers = ['pyflakes']
let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe=substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

let g:neomake_javascript_enabled_makers = ['eslint']	
