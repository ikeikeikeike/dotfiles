" ----------------------------------------------------------------------

" python
" @link http://sontek.net/turning-vim-into-a-modern-python-ide
" add flake8, remove pep8, pyflakes || replaced 2012-05-13T16:08:50 add tatsuo

" ----------------------------------------------------------------------


" pyflakes
" let g:pyflakes_use_quickfix=0
" highlight SpellBad ctermbg=darkred

" pep8
" let g:pep8_map='<leader>8'

" complete with document
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" TaskList
" nmap <Leader>T :TaskList<CR>
nnoremap <F6> :TaskList<CR>

" tag list plugins
if v:version > 700
    " tagbar
    let g:tagbar_usearrows = 1
    nnoremap <F7> :TagbarToggle<CR>
    " nmap <Leader>ll :TagbarToggle<CR>
else
    " taglist
    let Tlist_Use_Right_Window = 1     " right window.
    let Tlist_Auto_Highlight_Tag = 1 " auto highlighted tag.
    let Tlist_Auto_Open = 1          " auto enabled taglist.
    let Tlist_WinWidth = 40          " max window size.
endif


" Add  the  virtualenv's   site-packages  to  vim path
if ! &diff

let g:pythonworkon = "System"
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
    vim.command("let g:pythonworkon = '%s'" % os.path.basename(project_base_dir))
EOF

endif

" vim-virtualenv
let g:virtualenv_auto_activate = 1
