
nnoremap <c-\> :call MyGoToDefinition()<cr>
nnoremap <c-g> :<C-U>call MyTagStackPop()<cr>
nnoremap <Leader>\ :LspReferences<CR>
nnoremap <Leader>] :LspTypeDefinition<CR>

" nnoremap gd :call MyGoToDefinition()<cr>
" nnoremap gt :<C-U>call MyTagStackPop()<cr>

let g:LanguageClient_useVirtualText=0


