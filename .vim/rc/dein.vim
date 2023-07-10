function ClearDeinCache()
  execute ':call dein#clear_state()'
  execute ':call dein#recache_runtimepath()'
endfunction

" workaround fzf
set rtp+=~/.cache/dein/repos/github.com/junegunn/fzf
" let g:fzf_layout = { 'left': '~40%' }
nnoremap <C-]>                   :<C-u>FZFTags<CR>
nnoremap <silent> <Leader><C-f>  :<C-u>FZF<CR>
nnoremap <silent> <C-b>          :<C-U>Buffers<CR>

