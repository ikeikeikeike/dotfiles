" -------------------------------

" ctags

" -------------------------------

" set tags
if has("autochdir")
    " 編集しているファイルのディレクトリに自動で移動
    set autochdir
    set tags=tags;
else
    set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags,./../../../../../../../../tags,./../../../../../../../../../tags,./../../../../../../../../../../tags,./../../../../../../../../../../../tags,./../../../../../../../../../../../tags
endif

if filereadable(expand('~/rtags'))
  au FileType ruby,eruby,erb set tags+=~/rtags
endif

if filereadable(expand('~/ptags'))
  au FileType php,php3,phtml set tags+=~/ptags
endif

" keymap (replace unite-tag)
nnoremap <C-]>    g<C-]>


