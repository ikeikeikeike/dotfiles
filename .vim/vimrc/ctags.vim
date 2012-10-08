" -------------------------------

" ctags

" -------------------------------

" set tags
if has("autochdir")
    " 編集しているファイルのディレクトリに自動で移動
    set autochdir
    set tags=tags;
elseif filereadable(expand('~/rtags'))
  au FileType ruby,eruby setl tags+=~/rtags
else
    set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags,./../../../../../../../../tags,./../../../../../../../../../tags,./../../../../../../../../../../tags,./../../../../../../../../../../../tags,./../../../../../../../../../../../tags
endif

" keymap (replace unite-tag)
nnoremap <C-]>    g<C-]>


