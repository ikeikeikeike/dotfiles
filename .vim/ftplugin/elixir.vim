" let t:cwd = !mixup pwd
let t:cwd = system("mixup pwd")

autocmd! BufWritePre * execute 'cd' t:cwd
autocmd! BufWritePost * Neomake

" augroup neomake_run
  " autocmd! InsertLeave *.ex Neomake
  " autocmd! InsertLeave *.exs Neomake
" augroup END
