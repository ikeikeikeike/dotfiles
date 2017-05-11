" ######################################

" コメント整形 Nerd_Commenter の基本設定

" ######################################
let g:NERDCreateDefaultMappings = 0

" 未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle

let NERDSpaceDelims = 1
"let g:NERDCustomDelimiters = { 'py' : { 'left': '# ', 'leftAlt': '', 'rightAlt': '' }}
