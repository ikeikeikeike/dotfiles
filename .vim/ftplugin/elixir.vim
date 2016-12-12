autocmd! BufWritePost * Neomake
autocmd! BufWritePre *
\ if !exists('t:cwd')
\ |   let t:cwd = system("mixup pwd")
\ | endif
