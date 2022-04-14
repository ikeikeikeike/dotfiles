function ClearDeinCache()
  execute ':call dein#clear_state()'
  execute ':call dein#recache_runtimepath()'
endfunction

" workaround fzf
set rtp+=~/.cache/dein/repos/github.com/junegunn/fzf
nnoremap <C-]> :<C-u>FZFTags<CR>
nnoremap <silent> <Leader><C-f> :<C-u>FZF<CR>
" let g:fzf_layout = { 'left': '~40%' }

