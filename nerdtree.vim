" NERDTree config

" Nerd tree with Cntrl-N
map <C-n> :NERDTreeToggle<CR>

" NerdTree ignore certain file types (array of regular expressions
let NERDTreeIgnore = ['\.pyc$', '.DS_Store$', '.git/*', '.idea/*', 'build', 'coverage', 'data', '.vscode', '.vagrant', '.ropeproject', '__pycache__', '.envbin', '.egss', 'flake8-out', '.tags', 'tags', 'tags.lock']
let NERDTreeShowHidden=1

