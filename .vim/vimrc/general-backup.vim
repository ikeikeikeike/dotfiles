" ----------------------------------------------------

" バックアップ関係

" ----------------------------------------------------
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
"set writebackup
" バックアップをとる場合
set backup
" バックアップをとらない
"set nobackup

" バックアップファイルを作るディレクトリ
set backupdir=~/.vim/vim_backup
" スワップファイルを作るディレクトリ
set directory=~/.vim/vim_swap

" バックアップファイル名をFILE.bakに指定する。
set backupext=.bak
" 編集前のファイルをファイルFILE.origとして保存しておく。
"set patchmode=.orig
