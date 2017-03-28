" ctrlp config

let g:ctrlp_custom_ignore = '(migration|data|build|node_modules|.git|pyc$|coverage)'
nnoremap <leader>. :CtrlPTag<cr>

" Speed up ctrlp by using a cache dir
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag') " may need to install the_silver_searcher via brew
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

