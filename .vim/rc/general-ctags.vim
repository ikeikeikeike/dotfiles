" ctags
"

" set tags
" if has("autochdir")
"   set autochdir
"   set tags=tags;
" else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags,./../../../../../../../../tags,./../../../../../../../../../tags,./../../../../../../../../../../tags,./../../../../../../../../../../../tags,./../../../../../../../../../../../tags
" endif


if filereadable(expand('~/rtags'))
  au FileType ruby,eruby,erb set tags+=~/rtags
endif

if filereadable(expand('~/ptags'))
  au FileType php,php3,phtml set tags+=~/ptags
endif
