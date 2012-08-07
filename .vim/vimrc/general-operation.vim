" -----------------------------

" Indent and Dictionary

" -----------------------------
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
set formatoptions=lmoq      " 整形オプション，マルチバイト系を追加
set clipboard=unnamed,autoselect   " バッファにクリップボードを利用する [use fakeclip, reattach-to-user-namespace]

set autoindent   " 自動でインデント

set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。

" set cindent      " Cプログラムファイルの自動インデントを始める

set expandtab    "タブの代わりに空白文字挿入

"set noexpandtab " タブはタブのまま

set ts=4 sw=4 sts=0 " タブは半角2文字分のスペース

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
