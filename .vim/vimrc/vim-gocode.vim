"
" golang
"

if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
endif
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")

" complete detail view
set completeopt=menu,preview

au FileType go setlocal sw=4 ts=4 sts=4 noet
au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m

" autoformat
auto BufWritePre *.go Fmt

" if neobundle#is_installed('neocomplete')

    " " Enable heavy omni completion.
    " if !exists('g:neocomplete#sources#omni#input_patterns')
        " let g:neocomplete#sources#omni#input_patterns = {}
    " endif
    " let g:neocomplete#sources#omni#input_patterns.go = '\h\w*\.\?'

" elseif neobundle#is_installed('neocomplcache')

    " " neocomplcache
    " if !exists('g:neocomplcache_omni_patterns')
        " let g:neocomplcache_omni_patterns = {}
    " endif
    " let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'

" end
