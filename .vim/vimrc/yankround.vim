" ######################################
"
" yankring.vim
"
" ######################################

nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

let g:yankround_dir = '~/.cache/yankround'
let g:yankround_max_history = 2000

" Yankの履歴参照
nmap <Leader>y :Unite yankround<CR>
" let g:yankring_manual_clipboard_check = 0
