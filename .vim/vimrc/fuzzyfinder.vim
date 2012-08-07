" ######################################

" FuzzyFinder

" ######################################
if v:version > 700
    " file search
    nnoremap <silent> <C-f> :<C-u>FufFile **<CR>
    inoremap <silent> <C-f> <ESC>:<C-u>FufFile    **<CR>
    nnoremap <silent> <Leader>f :<C-u>FufFile $VIRTUAL_ENV_PYTHON_LIB/python*/site-packages/**<CR>
    inoremap <silent> <Leader>f <ESC>:<C-u>FufFile $VIRTUAL_ENV_PYTHON_LIB/python*/site-packages/**<CR>
    nnoremap <silent> <Leader><S-f> :<C-u>FufFile $PYTHON_LIB/python*/site-packages/**<CR>
    inoremap <silent> <Leader><S-f> <ESC>:<C-u>FufFile $PYTHON_LIB/python*/site-packages/**<CR>
    " tag search
    nnoremap <silent> <C-e> :<C-u>FufTag<CR>
    inoremap <silent> <C-e> <ESC>:<C-u>FufTag<CR>
    nnoremap <buffer> <Leader><C-]> :<C-u>FufTagWithCursorWord<CR>
endif
