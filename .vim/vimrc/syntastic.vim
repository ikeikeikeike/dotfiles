" ######################################

" syntastic

" ######################################
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_loc_list=2
" let g:syntastic_mode_map = { 'mode': 'active',
  " \ 'active_filetypes': ['perl'],
  " \ 'passive_filetypes': ['python'] }
" let g:syntastic_check_on_open = 1
" let g:syntastic_quiet_warnings = 0
" let g:syntastic_enable_signs = 1
" let g:syntastic_enable_highlighting = 0
" let g:syntastic_python_checker_args='--ignore=E501,E302,E231,E261,E201,W402,W293'
" let g:syntastic_python_checker_args='--ignore=E501'


let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1

" @see ~/.pylintrc
let g:syntastic_python_python_exec = '/opt/local/bin/python'
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_python_pep8_args='--ignore=E501'
let g:syntastic_python_pylint_args='-d C0111 -d C0301 -d C0103 -d R0904 -d W0232 -d R0903 -d W0142 -f parseable -r n'
let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'flake8', 'pylint']
" let g:syntastic_python_checkers = ['flake8']
let g:loaded_syntastic_python_pep257_checker = 0
" let g:loaded_syntastic_python_pydocstyle_checker = 0

" let g:syntastic_ruby_exec=$RUBY_EXE
let g:syntastic_ruby_exec=system('echo -n `rbenv which ruby`')

" for go lang
let g:syntastic_go_checkers = ['golint', 'gotype', 'govet', 'go']
" let g:syntastic_go_checkers = ['go', 'golint']

" buffergator
" let g:buffergator_viewport_split_policy="B"
