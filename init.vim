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

" Use up and down to switch tabs
map <up> <esc>:tabnext<CR>
map <down> <esc>:tabprevious<CR>

" Use left and right to switch buffers
map <left> :bprevious<CR>
map <right> :bnext<CR>

" Write the file if there is a change, on exiting insert mode
au InsertLeave * if &mod && expand('%')!=''|write|endif

" Write file on focus lost
au FocusLost * silent! :wa

set textwidth=150 " default text width, purposly high just in case

autocmd FileType python set colorcolumn=100
autocmd FileType javascript set colorcolumn=100

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
autocmd! BufWritePost * Neomake

"don't use vims backup swapfiles
set nobackup
set noswapfile

" enables :Paste to just do what you want
command Paste execute 'set noai | insert | set ai'

" Set the clipboard to use the OS X default, rather than vim's
set clipboard=unnamed

" Ack searching
nmap <leader>a <Esc>:Ack! <space>

"neovim terminal settings
:tnoremap <Esc> <C-\><C-n>

" Run JS Tests on Shift-F10
nnoremap <F10> :!mocha --require tests/setup.js --recursive ./tests<CR>

call plug#begin('~/.vim/plugged')
Plug 'benekastah/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-javascript'
Plug 'hashivim/vim-terraform'
Plug 'hynek/vim-python-pep8-indent'

" Color scheme
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'sickill/vim-monokai'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

call plug#end()

"Color scheme
colo monokai

" Neomake configuration
let g:neomake_python_enabled_makers = ['flake8']
let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe=substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

let g:neomake_javascript_enabled_makers = ['eslint']	

" Open the list when there are errors
" 2 keeps the cursor position in place
let g:neomake_open_list = 2

" ctrlp configuration
let g:ctrlp_custom_ignore = 'node_modules\|.git\|pyc$'
nnoremap <leader>. :CtrlPTag<cr>

" Speed up ctrlp by using a cache dir
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag') " may need to install the_silver_searcher via brew
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Nerd tree with Cntrl-N
map <C-n> :NERDTreeToggle<CR>

" NerdTree ignore certain file types (array of regular expressions
let NERDTreeIgnore = ['\.pyc$', '.DS_Store$', '.git/*', '.idea/*']
let NERDTreeShowHidden=1

let g:gutentags_exclude = ['.git', '.idea', 'node_modules']
set tags=./tags;

" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:jedi#completions_enabled = 0 " disable jedi-vim completion

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
