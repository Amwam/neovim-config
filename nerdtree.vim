" NERDTree config

" Nerd tree with Cntrl-N
map <C-n> :NERDTreeToggle<CR>

" NerdTree ignore certain file types (array of regular expressions
let NERDTreeIgnore = ['\.pyc$', '.DS_Store$', '.git/*', '.idea/*']
let NERDTreeShowHidden=1

