"
" neo snippet
"


" C-j snippet
"
" imap <C-j> <Plug>(neocomplcache_snippets_expand)
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" キー入力時にキーワード補完を行う入力数を制御する
" let g:neocomplcache_auto_completion_start_length = 4
" ポップアップメニューで表示される候補の数を制御する
" let g:neocomplcache_max_list = 50
" 自動補完 無効 手動: <C-x><C-u>
" g:neocomplcache_disable_auto_complete = 1

" SuperTab like snippets behavior. TABでスニペットを展開
" imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" :NeoComplCacheEditSnippets [filetype]
" ユーザ定義用のスニペットファイルの編集ができる。
" ftを指定しなければ現在のftのスニペットファイルを開く。
" ちなみに、プラグインに組み込まれてるスニペットファイルは下記にある。
" ~/.vim/autoload/neocomplcache/sources/snippets_complete/
" User snippets の保存ディレクトリ
" let g:neocomplcache_snippets_dir = '~/.vim/snippets'
let g:neosnippet#snippets_directory='~/.vim/snippets'

" key map
nnoremap <silent> <Space>es    :<C-u>NeoComplCacheEditSnippets


