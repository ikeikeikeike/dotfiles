

if &compatible
  set nocompatible
endif

" Executers
let g:python_host_prog = '/opt/local/bin/python'

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
  let g:python3_host_prog = expand("$VIRTUAL_ENV/bin/python")
else
  let g:python3_host_prog = '/opt/local/bin/python3'
endif

" let g:ruby_host_prog = ''
" let g:node_host_prog = ''


if &runtimepath !~# '/dein.vim'
  if !isdirectory(expand('~/.cache/dein/repos/github.com/Shougo/dein.vim'))
    execute '!git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim'
  endif
endif


set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim


if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  call dein#add('junegunn/fzf', { 'rtp': '', 'build' : './install --all' })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })


  " Direct
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Indirect
  call dein#load_toml('~/.vim/rc/dein.toml',      {'lazy': 0})
  call dein#load_toml('~/.vim/rc/dein_lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif


filetype plugin indent on
syntax enable


if dein#check_install()
  call dein#install()
endif


for s:f in split(glob('~/.vim/rc/*.vim'), '\n')
  exe 'source' s:f
endfor



