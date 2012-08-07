" ----------------------------------

" omuni

" ----------------------------------
setlocal omnifunc=syntaxcomplete#Complete
" ポップアップメニューの色変える
" highlight Pmenu gui=bold ctermbg=gray ctermfg=black
" highlight PmenuSel gui=bold ctermfg=white
" highlight PmenuSel gui=bold ctermbg=gray ctermfg=lightgreen
" highlight PmenuSbar ctermbg=darkgray
" highlight PmenuThumb ctermbg=lightgray
" highlight Pmenu ctermbg=8 guibg=#606060
" highlight Pmenu term=reverse ctermbg=235 guibg=#2d2d2d
" highlight Pmenu term=bold ctermfg=12 guifg=SlateBlue
" highlight PmenuSel ctermbg=12 guibg=SlateBlue
" highlight PmenuSbar ctermbg=0 guibg=#404040
" highlight PmenuThumb ctermbg=0 guibg=Red

if has('mac')
    highlight Pmenu ctermbg=227 gui=bold
else
    highlight Pmenu ctermbg=234 gui=bold
endif


" highlight Pmenu ctermbg=254 gui=bold
" highlight Pmenu guibg=#003000
" highlight PmenuSel guibg=#006800
" highlight PmenuSbar guibg=#001800
" highlight PmenuThumb guifg=#006000

" hi Pmenu ctermbg=0
" hi PmenuSel ctermbg=4
" hi PmenuSbar ctermbg=2
" hi PmenuThumb ctermfg=3

" autocmd settings
if has("autocmd")

    " set filetype
    autocmd BufNewFile,BufRead *.wsgi set filetype=python
    autocmd BufNewFile,BufRead *.vimrc set filetype=vim
    autocmd BufNewFile,BufRead *.vimperatorrc set filetype=vim
    autocmd BufNewFile,BufRead *.vrapperrc set filetype=vim
    autocmd BufNewFile,BufRead *.go set filetype=go

    autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

    " ファイルタイプの検索を有効にする
    filetype plugin on
    " そのファイルタイプにあわせたインデントを利用する
    filetype indent on
    " これらのftではインデントを無効に
    "autocmd FileType php filetype indent off

    " 無効
    " autocmd FileType html :set indentexpr=
    " autocmd FileType xhtml :set indentexpr=

    " ファイルタイプごとに辞書ファイルを指定
    autocmd FileType vim :set dictionary+=~/.vim/dict/vim.dict
    autocmd FileType php :set dictionary+=~/.vim/dict/php.dict

    " pydiction.vim
    autocmd FileType python let g:pydiction_location = '~/.vim/dict/pydiction/complete-dict'

    " 辞書ファイルを使用する設定に変更
    set complete+=k

endif
