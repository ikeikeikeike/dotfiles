" ------------------

" 縦に連番を入力する :3co

" ------------------
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor



" --------------------

" open / close

" --------------------
nnoremap <leader>ccc :<C-u>cclose<CR>
nnoremap <leader>cco :<C-u>copen<CR>


