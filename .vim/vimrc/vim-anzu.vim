""""""""""""""

" vim-anzu.vim

""""""""""""""

" mapping
nmap n <Plug>(anzu-N-with-echo)
nmap N <Plug>(anzu-n-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear status
" nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

" statusline
" set statusline=%{anzu#search_status()}

" if start anzu-mode key mapping
" nmap n <Plug>(anzu-mode-n)
" nmap N <Plug>(anzu-mode-N)
" nmap * <Plug>(anzu-star)
" nmap # <Plug>(anzu-sharp)

" nnoremap <expr> n anzu#mode#mapexpr("n", "", "zzzv")
" nnoremap <expr> N anzu#mode#mapexpr("N", "", "zzzv")

" nmap n <Plug>(anzu-n-with-echo)<Plug>(anzu-sign-matchline)
" nmap N <Plug>(anzu-N-with-echo)<Plug>(anzu-sign-matchline)

