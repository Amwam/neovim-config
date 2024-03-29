syntax on " Syntax highlighting
filetype plugin indent on
set number " Show the current line number instead of '0'
set hidden " hide buffers instead of closing
set title " Change the terminal title

let mapleader = " "

set mouse=a " Mouse support

set autoindent " always set autoindenting on
set copyindent " copy the previous indentation on autoindenting

" Use up and down to switch tabs
map <up> <esc>:tabnext<CR>
map <down> <esc>:tabprevious<CR>

" Use left and right to switch buffers
map <left>  <c-O>
map <right> <c-I>

" Folding
set foldmethod=indent
set foldlevelstart=20 " Keep folds open, when opening a buffer
nnoremap <space> za
vnoremap <space> zf

set inccommand=split
set gdefault " Global subsitute by default
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
        execute ":'<,'>normal @".nr2char(getchar())
    endfunction
" Write the file if there is a change, on exiting insert mode
au InsertLeave * if &mod && expand('%')!=''|write|endif

" Write file on focus lost
au FocusLost * silent! :wa

set textwidth=1000 " default text width, purposly high just in case

autocmd FileType python set colorcolumn=100
autocmd FileType javascript set colorcolumn=100
au BufNewFile,BufRead *.flow call SetFileTypeSH("javascript") " flow files

" Tab options
set expandtab " Insert spaces instead of tabs
set tabstop=4 " 4 spaces for every tab
set shiftwidth=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 " Two spaces for JS

set bs=2 " make backspace behave like normal again

" Search improvements
set incsearch " Highlight as you search
set ignorecase " Ignore case when seaching
set smartcase " Ignores case, except when capitals are used

set cursorline " Highlight current line

" Trim trailing whitespace on save, for specified file types only
autocmd BufWritePre *.{py,h,c,java,rs,js,json,php} :%s/\s\+$//e

" Don't use vims backup swapfiles
set nobackup
set noswapfile

" Enables :Paste to just do what you want
command Paste execute 'set noai | insert | set ai'

" Set the clipboard to use the OS X default, rather than vim's
set clipboard=unnamed

" neovim terminal settings
:tnoremap <Esc> <C-\><C-n>

" Redraw after macros are finished
:set lazyredraw

" pyenv setup
let g:python_host_prog = '/Users/amit/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/amit/.pyenv/versions/neovim3/bin/python'

call plug#begin('~/.vim/plugged')
Plug 'benekastah/neomake'
source ~/.config/nvim/neomake.vim

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>" " Start at the top of the results

Plug 'sbdchd/neoformat'
source ~/.config/nvim/neoformat.vim

Plug 'ctrlpvim/ctrlp.vim'
source ~/.config/nvim/ctrlp.vim

Plug 'airblade/vim-gitgutter'

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
set diffopt=vertical " side by side diffs

Plug 'tpope/vim-commentary'

Plug 'mileszs/ack.vim'
nmap <leader>a <Esc>:Ack! <space>
" Use the_silver_searcher if it is installed for faster searching, instead of ack
if executable('ag')
    let g:ackprg = 'ag --nogroup --nocolor --column' " Use the_silver_searcher instead
else
    echo "Install 'the_silver_searcher' for faster searching, falling back to 'ack'"
endif

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
source ~/.config/nvim/nerdtree.vim


Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['.git', '.idea', 'node_modules', 'migration', 'data', 'build', 'coverage']
set tags=./tags;

Plug 'craigdallimore/vim-jest-cli'
" Run :Jest to run jest tests
command Jest Dispatch jest 

Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

Plug 'hashivim/vim-terraform'
Plug 'hynek/vim-python-pep8-indent'

Plug 'easymotion/vim-easymotion'


Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Color scheme
Plug 'joshdick/onedark.vim'

" deoplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:jedi#completions_enabled = 0 " disable jedi-vim completion
let g:jedi#smart_auto_mappings = 0 " disbale auto insert of 'import' when using 'from x ...'
let g:jedi#show_call_signatures_delay = 50 " ms to show the tooltip

Plug 'keith/swift.vim'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" Show indent markers
Plug 'Yggdroot/indentLine'

" Distraction free writing
Plug 'junegunn/goyo.vim'
let g:goyo_width = 100
let g:goyo_height = '90%'

Plug 'skywind3000/vim-quickui'
 
call plug#end()

"Color scheme
set background=dark
colo onedark

source ~/.config/nvim/functions.vim
silent! so .vimlocal " Load an optional localvim file
