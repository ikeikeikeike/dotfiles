" ######################################

" errormarker.vim
" quickfix auto start
" error compiler

" ######################################
" autocmd QuickfixCmdPost make,grep,vimgrep,grepadd cw

" " ruby
" autocmd FileType ruby :set makeprg=ruby\ -c\ %
" " php
" autocmd filetype php :set makeprg=php\ -l\ %
" autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l
" " perl
" " autocmd FileType perl,cgi :compiler perl
" " cpp
" autocmd FileType cpp :set makeprg=g++\ -fsyntax-only\ %
" " c
" autocmd FileType c :set makeprg=gcc\ -fsyntax-only\ %

" " errormarker
" let g:errormarker_errortext = '!!'
" let g:errormarker_warningtext = '??'
" let g:errormarker_errorgroup = 'Error'
" let g:errormarker_warninggroup = 'Todo'
" if !exists('g:flymake_enabled')
   " let g:flymake_enabled = 1
   " autocmd BufWritePost *.cpp,*.h,*.hpp,*.cc,*.c,*.js,*.php,*.rb,*.pl,*.pm,*.t silent make! | redraw!
" endif
" if has('win32') || has('win64')
   " let g:errormarker_erroricon = expand('~/.vim/signs/err.bmp')
   " let g:errormarker_warningicon = expand('~/.vim/signs/warn.bmp')
" else
   " let g:errormarker_erroricon = expand('~/.vim/signs/err.bmp')
   " let g:errormarker_warningicon = expand('~/.vim/signs/err.png')
" endif
