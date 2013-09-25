"set autogroup
augroup MyAutoCmd
  autocmd!
augroup END

" vaxeの動作にはautowriteを有効にする必要がある
autocmd MyAutoCmd FileType haxe
      \ setl autowrite
autocmd MyAutoCmd FileType hxml
      \ setl autowrite
autocmd MyAutoCmd FileType nmml.xml
      \ setl autowrite

let g:vaxe_haxe_version = 3

function! s:init_vaxe_keymap()
  " .hxmlファイルを開いてくれるやつ
  nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
  " タグファイル作ってくれるやつ(別途、.ctagsの定義をしませう)
  nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
  " 自動インポートな
  nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
endfunction

autocmd MyAutoCmd FileType haxe call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType hxml call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType nmml.xml call s:init_vaxe_keymap()

" 以下はNeocomplete用
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'
