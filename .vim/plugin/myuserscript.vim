" ============================================================================
" File:        myuserscript.vim
" Description:
" Maintainer:
" Version:     0.2
" Last Change:
" License:
" Author:      Tatsuo Ikeda
"
" ============================================================================


function Rsync_gigacast_local_dev()
  !rsync_gigacast_local_dev
endfunction

function Nwpwd()
  !nw `pwd`
endfunction

map <silent> <Leader>r :call Rsync_gigacast_local_dev()<cr>
map <silent> <Leader>c :call Nwpwd()<cr>


