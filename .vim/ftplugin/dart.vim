
" nnoremap gd :call MyGoToDefinition()<cr>
" nnoremap gt :<C-U>call MyTagStackPop()<cr>

" nnoremap <c-]> :LspDefinition<cr>
" nnoremap <c-t> :<C-U>call MyTagStackPop()<cr>

nnoremap <c-]> :LspDefinition<CR>
nnoremap <c-\> :vsp<CR>:LspDefinition<CR>
nnoremap <Leader>\ :LspReferences<CR>
nnoremap <Leader>] :LspImplementation<CR>
