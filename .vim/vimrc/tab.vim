" http://blog.remora.cx/2012/09/use-tabpage.html
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor
