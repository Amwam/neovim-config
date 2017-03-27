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
map <left>  <c-O>
map <right> <c-I>

"Folding
set foldmethod=indent
set foldlevelstart=20 " Keep folds open, when opening a buffer
nnoremap <space> za
vnoremap <space> zf

set inccommand=split
set gdefault " Global subsitute by default

" Write the file if there is a change, on exiting insert mode
au InsertLeave * if &mod && expand('%')!=''|write|endif

" Write file on focus lost
au FocusLost * silent! :wa

set textwidth=1000 " default text width, purposly high just in case

autocmd FileType python set colorcolumn=100
autocmd FileType javascript set colorcolumn=100

" Tab options
set expandtab " Insert spaces instead of tabs
set tabstop=4 " 4 spaces for every tab
set shiftwidth=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 " Two spaces for JS

set bs=2 " make backspace behave like normal again

" Search improvements
set incsearch "Highlight as you search
set ignorecase "ignore case when seaching
set smartcase "Ignores case, except when capitals are used

set cursorline " Highlight current line

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
Plug 'sbdchd/neoformat'
nnoremap <leader>= :Neoformat<CR>

let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin', '--single-quote', '--trailing-comma', 'es5', '--jsx-bracket-same-line=true'],
            \ 'stdin': 1,
            \ }

Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
set diffopt=vertical " side by side diffs

Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-javascript'
Plug 'craigdallimore/vim-jest-cli'
" Run :Jest to run jest tests
command Jest Dispatch jest 

Plug 'jelera/vim-javascript-syntax'
" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

Plug 'hashivim/vim-terraform'
Plug 'hynek/vim-python-pep8-indent'

Plug 'easymotion/vim-easymotion'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'elzr/vim-json'
  let g:vim_json_syntax_conceal = 0

" Color scheme
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
Plug 'joshdick/onedark.vim'

Plug 'rakr/vim-one'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

Plug 'keith/swift.vim'

call plug#end()

"Color scheme
"colo monokai
set background=dark
colo onedark

" Neomake configuration
let g:neomake_python_enabled_makers = ['flake8']
let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe=substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

if findfile('.flowconfig', '.;') !=# ''
  let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))
  if g:flow_path != 'flow not found'
    let g:neomake_javascript_flow_maker = {
          \ 'exe': 'sh',
          \ 'args': ['-c', g:flow_path.' --json 2> /dev/null | flow-vim-quickfix'],
          \ 'errorformat': '%E%f:%l:%c\,%n: %m',
          \ 'cwd': '%:p:h' 
          \ }

    let g:neomake_jsx_flow_maker = {
          \ 'exe': 'sh',
          \ 'args': ['-c', g:flow_path.' --json 2> /dev/null | flow-vim-quickfix'],
          \ 'errorformat': '%E%f:%l:%c\,%n: %m',
          \ 'cwd': '%:p:h' 
          \ }
    let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'flow']
    let g:neomake_jsx_enabled_makers = g:neomake_jsx_enabled_makers + [ 'flow']
  endif
endif

" This is kinda useful to prevent Neomake from unnecessary runs
if !empty(g:neomake_javascript_enabled_makers)
  autocmd! BufWritePost * Neomake
endif
" Open the list when there are errors
" 2 keeps the cursor position in place
let g:neomake_open_list = 2

" ctrlp configuration
let g:ctrlp_custom_ignore = 'migration\|data\|build\|node_modules\|.git\|pyc$|coverage\'
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

let g:gutentags_ctags_exclude = ['.git', '.idea', 'node_modules', 'migration', 'data', 'build', 'coverage']
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

command! PrettyJSON %!python -m json.tool
