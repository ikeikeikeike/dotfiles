"
" golang
"

if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif

let g:go_bin_path = expand("~/.go/bin")

exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

set completeopt=menu,preview

au FileType go setlocal sw=4 ts=4 sts=4 noet
au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m

""" vim-go
" let g:go_play_open_browser = 0
" let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 1  " auto BufWritePre *.go Fmt
let g:go_fmt_command = "goimports"
" let g:go_disable_autoinstall = 1

au FileType go nmap <C-@> <Plug>(go-run)
au FileType go nmap <C-i> <Plug>(go-doc-browser)
au FileType go nmap <C-h> <Plug>(go-doc-browser)
au FileType go nmap <leader>gb <Plug>(go-build)

" au FileType go nmap <Leader>s <Plug>(go-implements)
" au FileType go nmap <Leader>gi <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
" au FileType go nmap <leader>gt <Plug>(go-test)
" au FileType go nmap <leader>r <Plug>(go-run)
" au FileType go nmap <leader>b <Plug>(go-build)
" au FileType go nmap <leader>t <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" au FileType go nmap <Leader>e <Plug>(go-rename)
" au FileType go nmap <Leader>gl :GoLint<CR>
