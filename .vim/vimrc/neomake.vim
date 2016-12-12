let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mixup',
      \ 'args': ['credo', '--format=flycheck', '--strict'],
      \ 'cwd': getcwd(),
      \ 'errorformat':
          \ '%E%f:%l:%c: %m,' .
          \ '%E%f:%l: %m'
      \ }

let g:neomake_elixir_enabled_makers = ['mycredo', 'elixir']
" let g:neomake_elixir_enabled_makers = ['mycheck1', 'mycheck2', 'mix', 'dogma', 'elixir', 'credo']
" let g:neomake_verbose=3
" let g:neomake_logfile='/tmp/neomake.log'
