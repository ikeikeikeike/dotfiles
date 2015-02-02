let g:godef_split = 0
let g:godef_same_file_in_same_window = 1

au FileType go nmap <C-\> <Plug>(go-def)
" au FileType go nmap <C-]> <Plug>(go-def)
" au FileType go nmap <C-t> <C-b><Enter>
