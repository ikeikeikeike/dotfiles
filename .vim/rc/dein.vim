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

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

if $ARCHI != 'darwin'
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
    augroup END
  endif
endif

syntax on
colorscheme onedark

