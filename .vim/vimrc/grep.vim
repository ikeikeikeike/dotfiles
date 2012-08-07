" ######################################

" grep.vim

" ######################################
" for darwin settings
if has('mac')
    let Grep_Xargs_Path = "/opt/local/bin/gxargs"
endif
" ignore settings
let Grep_Skip_Dirs = '.svn .hg .git .idea .settings'
let Grep_Skip_Files = '*.bak *~'
" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>
