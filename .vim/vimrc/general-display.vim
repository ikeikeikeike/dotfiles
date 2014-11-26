"#######################

" 表示系

"#######################

" Zenkaku
highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /\s\+$\|　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
" highlight CursorLine term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow

set wildmenu " 補完候補を表示する

set number " 行番号表示

set showmode " モード表示

set title " 編集中のファイル名を表示

set ruler " ルーラーの表示

set showcmd " 入力中のコマンドをステータスに表示する

set showmatch   " ()や{}の対応関係をハイライトする
"set noshowmatch " ()や{}の対応関係をハイライトしない

set laststatus=2 " ステータスラインを常に表示

set scrolloff=5  " スクロール時に余分に表示する行数，画面の行数より大きくするとカーソルが常に画面中央にくるようになる

autocmd FileType python,ruby,javascript,coffee,cofeescript,php autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
autocmd FileType python,ruby,javascript,coffee,cofeescript,php autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する
" autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する
" autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

" nnoremap <C-i>  :<C-u>help<Space> " Ctrl-iでヘルプ

syntax on "カラー表示

" " タブページを常に表示
" set showtabline=2
" " gVimでもテキストベースのタブページを使う
" set guioptions-=e
