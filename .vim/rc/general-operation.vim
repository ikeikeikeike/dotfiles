"" Indent and Dictionary
"

set backspace=indent,eol,start
set formatoptions=lmoq
set autoindent
set smartindent
" set cindent
"set noexpandtab
set expandtab
set ts=2 sw=2 sts=0
set tabstop=2 shiftwidth=2 softtabstop=0

set clipboard+=unnamedplus

if $ARCHI == 'darwin'
  let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }
endif
