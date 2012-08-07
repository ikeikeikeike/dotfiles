" #######################

" 検索系

" #######################
"
set history=1000 " コマンド・検索パターンの履歴数

set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する

set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する

set wrapscan " 検索時に最後まで行ったら最初に戻る

set noincsearch " 検索文字列入力時に順次対象文字列にヒットさせない

"set nohlsearch " 検索結果文字列の非ハイライト表示
set hlsearch " 検索結果文字列のハイライトを有効にする

" ハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
