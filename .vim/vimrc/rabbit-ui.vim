function! s:edit_csv(path)
  call writefile(map(rabbit_ui#gridview(
        \ map(readfile(expand(a:path)),'split(v:val,",",1)')),
        \ "join(v:val, ',')"), expand(a:path))
endfunction

command! -nargs=1 -complete=file EditCSV  :call <sid>edit_csv(<q-args>)


