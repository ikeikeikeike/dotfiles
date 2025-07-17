if &compatible
  set nocompatible
endif

" Executers
let g:python_host_prog = '/opt/local/bin/python'

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
  let g:python3_host_prog = expand("$VIRTUAL_ENV/bin/python")
else
  let g:python3_host_prog = '/opt/local/bin/python'
endif

" Bootstrap lazy.nvim
lua << EOF
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy-config")
EOF

filetype plugin indent on
syntax enable

" Source other vim config files
for s:f in split(glob('~/.vim/rc/*.vim'), '\n')
  if s:f !~ 'dein'  " Skip dein related files
    exe 'source' s:f
  endif
endfor