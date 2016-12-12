function Mixmeansnothing()
    if !exists('t:cwd')
       let t:cwd = system("mixup pwd")
    endif

    execute 'cd' t:cwd
endfunction

autocmd! BufWritePre * call Mixmeansnothing()
autocmd! BufWritePost * Neomake
