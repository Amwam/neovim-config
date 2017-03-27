" Neoformat config
nnoremap <leader>= :Neoformat<CR>

let g:neoformat_javascript_prettier = {
            \ 'exe': 'prettier',
            \ 'args': ['--stdin', '--single-quote', '--trailing-comma', 'es5', '--jsx-bracket-same-line=true'],
            \ 'stdin': 1,
            \ }



