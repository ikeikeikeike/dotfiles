" Display
"
"
" Zenkaku
highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/

set cursorline
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" highlight CursorLine term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow

set wildmenu
set number
set showmode
set title
set ruler
set showcmd
set showmatch
"set noshowmatch
set laststatus=2
set scrolloff=5

autocmd FileType typescript,python,ruby,javascript,coffee,cofeescript,php autocmd BufWritePre * :%s/\s\+$//ge " Delete end of blanks like spaces
autocmd FileType typescript,python,ruby,javascript,coffee,cofeescript,php autocmd BufWritePre * :%s/\t/  /ge  " Replace tab to space
" autocmd BufWritePre * :%s/\s\+$//ge " Delete end of blanks like spaces
" autocmd BufWritePre * :%s/\t/  /ge " Replace tab to space

" syntax on

" set showtabline=2
" set guioptions-=e


augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END


" highlight clear ErrorMsg
" highlight clear Error
" highlight Error	    cterm=bold ctermfg=7 ctermbg=1
" highlight ErrorMsg	cterm=bold ctermfg=7 ctermbg=1

