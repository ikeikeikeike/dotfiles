" ------------
"
"   vundle
"
" ------------

" viとの互換性をとらない(vimの独自拡張機能を使う為)
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'vundle'

" anything like buffer management app.
Bundle 'unite.vim'
Bundle 'unite-tag'

" buffer
" Bundle 'minibufexpl.vim'

" ############
"
" programings
"
" ############
Bundle 'YankRing.vim'
" auto complete
Bundle 'Shougo/neocomplcache'
" Todo tasklist
Bundle 'TaskList.vim'
" source viewer for tags
Bundle 'Source-Explorer-srcexpl.vim'
" taglist
Bundle 'taglist.vim'
" 保存前差分 表示
Bundle 'Changed'
" search auto complete
Bundle 'SearchComplete'
" TabKkey 連続して入力補完
" Bundle 'SuperTab'


" help, doc
Bundle 'ref.vim'

" python
Bundle 'pyflakes.vim'
Bundle 'pep8'
Bundle 'pydoc.vim'
" Bundle 'vim-ipython'

" scm
Bundle 'fugitive.vim'

" grep
Bundle 'ack.vim'
Bundle 'grep.vim'

" session
Bundle 'session.vim'

"----------------------------------------------------
" 基本的な設定
"----------------------------------------------------

" ビープ音を鳴らさない
set vb t_vb=

" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

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


" 補完候補を表示する
set wildmenu

" コマンド・検索パターンの履歴数
set history=1000

"set number "行番号表示

set showmode "モード表示

set title "編集中のファイル名を表示

set ruler "ルーラーの表示

set showcmd "入力中のコマンドをステータスに表示する

set showmatch   " ()や{}の対応関係をハイライトする
"set noshowmatch " ()や{}の対応関係をハイライトしない

"ステータスラインを常に表示
set laststatus=2

"ステータスライン文字コード表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)%m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}

set scrolloff=5  " スクロール時に余分に表示する行数，画面の行数より大きくするとカーソルが常に画面中央にくるようになる


" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge
" Ctrl-iでヘルプ
" nnoremap <C-i>  :<C-u>help<Space>

"#######################

" プログラミングヘルプ系

"#######################

syntax on "カラー表示


"-------------------------------------------------------------------------------
" タグ関連 Tags
"-------------------------------------------------------------------------------
" set tags
if has("autochdir")
  " 編集しているファイルのディレクトリに自動で移動
  set autochdir
  set tags=tags;
else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif

" keymap (replace unite-tag)
" nnoremap <C-]>  g<C-]>

"-------------------------------------------------------------------------------
"" Indent and Dictionary
"-------------------------------------------------------------------------------

set autoindent   " 自動でインデント

set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。

set cindent      " Cプログラムファイルの自動インデントを始める

set expandtab    "タブの代わりに空白文字挿入

"set noexpandtab " タブはタブのまま

set ts=2 sw=2 sts=0 "タブは半角2文字分のスペース

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=0


" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz

" omuni
setlocal omnifunc=syntaxcomplete#Complete

" autocmd settings
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on
  " これらのftではインデントを無効に
  "autocmd FileType php filetype indent off

  autocmd FileType html :set indentexpr=
  autocmd FileType xhtml :set indentexpr=

  " php, python, ruby, any function
  " ファイルタイプごとに辞書ファイルを指定
  autocmd FileType vim :set dictionary+=~/.vim/dict/vim_functions.dict
  autocmd FileType php :set dictionary+=~/.vim/dict/php_functions.dict
  autocmd FileType python let g:pydiction_location = '~/.vim/dict/pydiction/complete-dict'

  "辞書ファイルを使用する設定に変更
  set complete+=k

  " php syntax
  autocmd filetype php :set makeprg=php\ -l\ %
  autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

endif


" ファイルを開いた際に、前回終了時の行で起動

"自動で補完候補をポップアップ
let g:neocomplcache_enable_at_startup = 1


" #######################

" 検索系

" #######################

set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する

set smartcase "検索文字列に大文字が含まれている場合は区別して検索する

set wrapscan "検索時に最後まで行ったら最初に戻る

set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない

"set nohlsearch "検索結果文字列の非ハイライト表示
set hlsearch "検索結果文字列のハイライトを有効にする

" ハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>


" ###################

" buffer

" ####################




" ####################

" window

" ####################
" 行・列を設定する
set sessionoptions+=resize
" 行数
" set lines=48 
" 横幅 
" set columns=160 
" コマンドラインの高さ
set cmdheight=1
" プレビューウィンドウの高さ
set previewheight=5
" 横分割したら新しいウィンドウは下に  
set splitbelow
" 縦分割したら新しいウィンドウは右に
set splitright


" #######################

" システム管理系

" #######################

" ----------------------------------------------------
" バックアップ関係
" ----------------------------------------------------
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
"set writebackup
" バックアップをとる場合
set backup
"" バックアップをとらない
"set nobackup

" バックアップファイルを作るディレクトリ
set backupdir=~/.vim/vim_backup
" スワップファイルを作るディレクトリ
set directory=~/.vim/vim_swap

" バックアップファイル名をFILE.bakに指定する。
set backupext=.bak
" 編集前のファイルをファイルFILE.origとして保存しておく。
"set patchmode=.orig

"set encoding=utf8 "menu encoding...
set fileencoding=utf8
:set encoding=utf-8
:set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" 文字コードの自動認識
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif


" ---------------------------------------

" plugin

" ---------------------------------------


" ######################################

" コメント整形 Nerd_Commenter の基本設定

" ######################################
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
"未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle

" ######################################

" bundle管理  Unite.vim

" ######################################
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1
let g:unite_update_time = 1000
" shrtcut
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^\\', '~/*')
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

" keymap
nnoremap <silent> <C-f> :<C-u>UniteWithBufferDir -vertical -buffer-name=files file<CR>
inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-b> :<C-u>Unite -vertical -buffer-name=files buffer file_mru bookmark<CR>
inoremap <silent> <C-b> <ESC>:<C-u>Unite -vertical -buffer-name=files buffer file_mru bookmark<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

" ######################################

" unite-tag

" ######################################
" <C-]> 拡張
autocmd BufEnter *
      \   if empty(&buftype)
      \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
      \|  endif
" unite-tag
nnoremap <silent> <C-T> :<C-u>Unite tag<CR>
inoremap <silent> <C-T> <ESC>:<C-u>Unite tag<CR>


" ######################################

" 保管 newcomplecache auto-complete

" ######################################
" 起動
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視
let g:neocomplcache_enable_smart_case = 1
" _ 区切りの補完を有効化します。
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3文字 default 4
let g:neocomplcache_min_syntax_length = 3
"

" ######################################

" grep.vim

" ######################################
" for darwin settings
let Grep_Xargs_Path = "/opt/local/bin/gxargs"
" ignore settings
let Grep_Skip_Dirs = '.svn .hg .git .idea'
let Grep_Skip_Files = '*.bak *~'
" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>


" ######################################
"
" YankRing.vim
"
" ######################################
" Yankの履歴参照
nmap <Leader>y :YRShow<CR>


" ######################################

" session.vim

" ######################################
let g:session_directory = "~/.vim/vim_session"


" ######################################

" ref.vim

" ######################################



" ######################################

" cd.vim

" ######################################
au BufEnter * execute ":lcd " . expand("%:p:h")



" ######################################

" srcexl
" link: http://d.hatena.ne.jp/guyon/20080409/1207737955

" ######################################
" "自動でプレビューを表示する。TODO:うざくなってきたら手動にする。またはソースを追う時だけ自動に変更する。
" let g:SrcExpl_RefreshTime   = 1
" "プレビューウインドウの高さ
" let g:SrcExpl_WinHeight     = 9
" "tagsは自動で作成する/ しない
" " let g:SrcExpl_UpdateTags    = 1
" "マッピング
" let g:SrcExpl_RefreshMapKey = "<Space>"
" let g:SrcExpl_GoBackMapKey  = "<C-b>"
" nmap <Leader><F8> :SrcExplToggle<CR>


" ----------------------------------------------------------------------

" @link http://sontek.net/turning-vim-into-a-modern-python-ide

" ----------------------------------------------------------------------

" pyflakes
"let g:pyflakes_use_quickfix=0

" pep8
let g:pep8_map='<leader>8'

" complete with document
 au FileType python set omnifunc=pythoncomplete#Complete
 let g:SuperTabDefaultCompletionType = "context"
 set completeopt=menuone,longest,preview

" TaskList
map <Leader>T :TaskList<CR>

" taglist
" let Tlist_Use_Right_Window = 1   " right window.
" let Tlist_Auto_Highlight_Tag = 1 " auto highlighted tag.
" let Tlist_Auto_Open = 1          " auto enabled taglist.
" let Tlist_WinWidth = 40          " max window size.

" Add  the  virtualenv's   site-packages  to  vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF


