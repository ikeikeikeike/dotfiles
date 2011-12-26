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

" unites
if v:version > 700
  " anything like buffer management app.
  Bundle 'unite.vim'
  Bundle 'tsukkee/unite-tag'
  Bundle 'tsukkee/unite-help'
  Bundle 'ujihisa/unite-locate'
  Bundle 'heavenshell/unite-zf'
  " Bundle 'Sixeight/unite-grep'
  Bundle 'ujihisa/unite-colorscheme'
  Bundle 'unite-font'
endif
" ~~~~~~~~~~~~
" general
" ~~~~~~~~~~~~
" yank and clipboard
Bundle 'kana/vim-fakeclip'

" buffer
" Bundle 'minibufexpl.vim'

" auto complete
Bundle 'ujihisa/neco-look'

" color & theme
Bundle 'Color-Sampler-Pack'
Bundle 'ChrisKempson/Vim-Tomorrow-Theme'

" sudo
Bundle 'sudo.vim'

" background for windows?
" Bundle 'Shougo/vimproc'

" ~~~~~~~~~~~~
" move
" ~~~~~~~~~~~~
" Bundle 'fuzzyjump.vim'
if v:version > 700
  Bundle 'clones/vim-l9'
  Bundle 'FuzzyFinder'
endif


" ~~~~~~~~~~~~
" programmings
" ~~~~~~~~~~~~
if v:version > 700
  " yankring
  Bundle 'YankRing.vim'
  Bundle 'm4i/YankRingSync'

  " auto complete
  Bundle 'Shougo/neocomplcache'
endif

" Todo tasklist
Bundle 'TaskList.vim'

" " source viewer for tags
" Bundle 'Source-Explorer-srcexpl.vim'

" " easytags
" Bundle 'xolox/vim-easytags'

" taglist
Bundle 'taglist.vim'

if v:version > 700
  " tagbar
  Bundle 'majutsushi/tagbar'
endif

" " 保存前差分 表示
" Bundle 'Changed'

" vim search auto complete
Bundle 'SearchComplete'

" tree view
Bundle "scrooloose/nerdtree"

" ~~~~~~~~~~
" help, doc
" ~~~~~~~~~~
Bundle 'thinca/vim-ref'
Bundle 'ref.vim'
Bundle 'Shougo/echodoc'
Bundle 'php-doc'

" ~~~~~~~~~~~~
" languages
" ~~~~~~~~~~~~
" sql
Bundle 'sql.vim--Fishburn-syntax'

" html & javascript indentations
Bundle "lukaszb/vim-web-indent"

" python
if ! &diff
  Bundle 'pyflakes.vim'
endif
Bundle 'pep8'
Bundle 'amitdev/vimpy'
" Bundle 'project.tar.gz'

" Bundle 'vim-ipython'

" php
Bundle 'justinrainbow/php-xdebug.vim'

" scm
Bundle 'fugitive.vim'

" grep
Bundle 'ack.vim'
Bundle 'grep.vim'
Bundle 'thinca/vim-qfreplace'

" diff
Bundle 'DirDiff.vim'

" session
if v:version > 700
  if ! &diff
    Bundle 'session.vim'
  endif
endif
" Bundle 'sessionman.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" support input , text-object
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Bundle 'kana/vim-smartchr'
Bundle 'tpope/vim-surround'
" Bundle 'vim-scripts/AutoClose'

" ~~~~~~~
" funny
" ~~~~~~~
Bundle 'koron/nyancat-vim'

"----------------------------------------------------
" 基本的な設定
"----------------------------------------------------

"カラースキーマを設定
" colorscheme anotherdark
" colorscheme adaryn
" colorscheme asu1dark
colorscheme breeze
" set background=light      " 背景色の傾向(カラースキーマがそれに併せて色の明暗を変えてくれる)
" set background=dark



" ビープ音を鳴らさない
set vb t_vb=

" File ---------------------------------
set autoread        " 更新時自動再読込み
set hidden          " 編集中でも他のファイルを開けるようにする


" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
set formatoptions=lmoq      " 整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,s,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set clipboard=unnamed,autoselect   " バッファにクリップボードを利用する [use fakeclip, reattach-to-user-namespace]


" " タブページを常に表示
" set showtabline=2
" " gVimでもテキストベースのタブページを使う
" set guioptions-=e

" --------------------
" general keymap
" --------------------
nnoremap <leader>ccc :<C-u>cclose<CR>
nnoremap <leader>cco :<C-u>copen<CR>

" --------------------
" move
" --------------------
" jkを直感的に
nnoremap <silent> j gj
nnoremap <silent> gj j
nnoremap <silent> k gk
nnoremap <silent> gk k
nnoremap <silent> $ g$
nnoremap <silent> g$ $
vnoremap <silent> j gj
vnoremap <silent> gj j
vnoremap <silent> k gk
vnoremap <silent> gk k
vnoremap <silent> $ g$
vnoremap <silent> g$ $


" --------------------
" color
" --------------------
" 256色モード
" if stridx($TERM, "xterm-256color") >= 0
  " set t_Co=256
" else
  " set t_Co=16
" endif


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

set history=1000 " コマンド・検索パターンの履歴数

set number " 行番号表示

set showmode " モード表示

set title " 編集中のファイル名を表示

set ruler " ルーラーの表示

set showcmd " 入力中のコマンドをステータスに表示する

set showmatch   " ()や{}の対応関係をハイライトする
"set noshowmatch " ()や{}の対応関係をハイライトしない

set laststatus=2 " ステータスラインを常に表示

" ステータスライン文字コード表示
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)%m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}

set scrolloff=5  " スクロール時に余分に表示する行数，画面の行数より大きくするとカーソルが常に画面中央にくるようになる

autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

autocmd BufWritePre * :%s/\t/  /ge " 保存時にtabをスペースに変換する

" nnoremap <C-i>  :<C-u>help<Space> " Ctrl-iでヘルプ

" set clipboard=unnamed,autoselect " yank=clipboard
" set clipboard+=unnamed

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
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
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □ とか○ の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


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
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags,./../../../../../../../../tags,./../../../../../../../../../tags,./../../../../../../../../../../tags,./../../../../../../../../../../../tags,./../../../../../../../../../../../tags
endif

" keymap (replace unite-tag)
nnoremap <C-]>  g<C-]>

"-------------------------------------------------------------------------------
"" Indent and Dictionary
"-------------------------------------------------------------------------------

set autoindent   " 自動でインデント

set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。

" set cindent      " Cプログラムファイルの自動インデントを始める

set expandtab    "タブの代わりに空白文字挿入

"set noexpandtab " タブはタブのまま

set ts=2 sw=2 sts=0 " タブは半角2文字分のスペース

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
" ポップアップメニューの色変える
" highlight Pmenu gui=bold ctermbg=gray ctermfg=black
" highlight PmenuSel gui=bold ctermfg=white
" highlight PmenuSel gui=bold ctermbg=gray ctermfg=lightgreen
" highlight PmenuSbar ctermbg=darkgray
" highlight PmenuThumb ctermbg=lightgray
" highlight Pmenu ctermbg=8 guibg=#606060
" highlight PmenuSel ctermbg=12 guibg=SlateBlue
" highlight PmenuSbar ctermbg=0 guibg=#404040
" highlight PmenuThumb ctermbg=0 guibg=Red

" autocmd settings
if has("autocmd")

  " set filetype
  autocmd BufNewFile,BufRead *.wsgi set filetype=python
  autocmd BufNewFile,BufRead *.vimrc set filetype=vim
  autocmd BufNewFile,BufRead *.vimperatorrc set filetype=vim
  autocmd BufNewFile,BufRead *.vrapperrc set filetype=vim
  autocmd BufNewFile,BufRead *.go set filetype=go

  " Enable omni completion.
  autocmd FileType eruby,html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

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

  " php syntax
  autocmd filetype php :set makeprg=php\ -l\ %
  autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l

endif


" #######################

" 検索系

" #######################

set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する

set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する

set wrapscan " 検索時に最後まで行ったら最初に戻る

set noincsearch " 検索文字列入力時に順次対象文字列にヒットさせない

"set nohlsearch " 検索結果文字列の非ハイライト表示
set hlsearch " 検索結果文字列のハイライトを有効にする

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


" ######################################

" vimdiff

" ######################################
if &diff
  colorscheme colorer
endif


" ---------------------------------------

" plugin

" ---------------------------------------


" ######################################

" コメント整形 Nerd_Commenter の基本設定

" ######################################
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
" 未対応ファイルタイプのエラーメッセージを表示しない
let NERDShutUp=1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle


if v:version > 700

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
  nnoremap <silent> <Leader><C-f> :<C-u>UniteWithBufferDir -vertical -buffer-name=files file<CR>
  inoremap <silent> <Leader><C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
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
  " autocmd BufEnter *
        " \   if empty(&buftype)
        " \|      nnoremap <buffer> <Leader><C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
        " \|  endif
  " unite-tag
  nnoremap <silent> <Leader><C-e> :<C-u>Unite tag<CR>
  inoremap <silent> <Leader><C-e> <ESC>:<C-u>Unite tag<CR>

  " ######################################

  " unite-help

  " ######################################
  " " Execute help.
  " nnoremap <Leader><C-h>  :<C-u>Unite -start-insert help<CR>
  " " Execute help by cursor keyword.
  " nnoremap <silent> <Leader>g<C-h>  :<C-u>UniteWithCursorWord help<CR>

endif


" ######################################

" FuzzyFinder

" ######################################
if v:version > 700
  " file search
  nnoremap <silent> <C-f> :<C-u>FufFile **<CR>
  inoremap <silent> <C-f> <ESC>:<C-u>FufFile  **<CR>
  nnoremap <silent> <Leader>f :<C-u>FufFile $VIRTUAL_ENV_PYTHON_LIB/python*/site-packages/**<CR>
  inoremap <silent> <Leader>f <ESC>:<C-u>FufFile $VIRTUAL_ENV_PYTHON_LIB/python*/site-packages/**<CR>
  " tag search
  nnoremap <silent> <C-e> :<C-u>FufTag<CR>
  inoremap <silent> <C-e> <ESC>:<C-u>FufTag<CR>
  nnoremap <buffer> <Leader><C-]> :<C-u>FufTagWithCursorWord<CR>
endif

" ######################################

" 保管 newcomplecache auto-complete snippets

" ######################################
if v:version > 700

  " 自動で補完候補をポップアップ
  let g:neocomplcache_enable_at_startup = 1
  " 大文字が入力されるまで大文字小文字の区別を無視
  let g:neocomplcache_enable_smart_case = 1
  " _ 区切りの補完を有効化します。
  let g:neocomplcache_enable_underbar_completion = 1
  " シンタックスをキャッシュするときの最小文字長を3文字 default 4
  let g:neocomplcache_min_syntax_length = 3
  " C-j snippet
  imap <C-j> <Plug>(neocomplcache_snippets_expand)

  " SuperTab like snippets behavior. TABでスニペットを展開
  " imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  " :NeoComplCacheEditSnippets [filetype]
  " ユーザ定義用のスニペットファイルの編集ができる。
  " ftを指定しなければ現在のftのスニペットファイルを開く。
  " ちなみに、プラグインに組み込まれてるスニペットファイルは下記にある。
  " ~/.vim/autoload/neocomplcache/sources/snippets_complete/
  " User snippets の保存ディレクトリ
  let g:neocomplcache_snippets_dir = '~/.vim/snippets'
  " key map
  nnoremap <silent> <Space>es  :<C-u>NeoComplCacheEditSnippets

  " " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
        \'default' : '',
        \ 'java' : $HOME.'/.vim/dict/java.dict',
        \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
        \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
        \ 'css' : $HOME.'/.vim/dict/css.dict',
        \ 'ocaml' : $HOME.'/.vim/dict/ocaml.dict',
        \ 'perl' : $HOME.'/.vim/dict/perl.dict',
        \ 'php' : $HOME.'/.vim/dict/php.dict',
        \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
        \ 'python' : $HOME.'/.vim/dict/python.dict',
        \ 'vim' : $HOME.'/.vim/dict/vim.dict'
        \ }

endif

" ######################################

" vim-smartchr

" ######################################

" 演算子の間に空白を入れる
" inoremap <buffer><expr> < search('^#include\%#', 'bcn')? ' <': smartchr#one_of(' < ', ' << ', '<')
" inoremap <buffer><expr> > search('^#include <.*\%#', 'bcn')? '>': smartchr#one_of(' > ', ' >> ', '>')
" inoremap <buffer><expr> + smartchr#one_of(' + ', '++', '+')
" inoremap <buffer><expr> - smartchr#one_of(' - ', '--', '-')
" inoremap <buffer><expr> / smartchr#one_of(' / ', '// ', '/')
" *はポインタで使うので、空白はいれない
" inoremap <buffer><expr> & smartchr#one_of(' & ', ' && ', '&')
" inoremap <buffer><expr> % smartchr#one_of(' % ', '%')
" inoremap <buffer><expr> <Bar> smartchr#one_of(' <Bar> ', ' <Bar><Bar> ', '<Bar>')
" inoremap <buffer><expr> , smartchr#one_of(', ', ',')
" " 3項演算子の場合は、後ろのみ空白を入れる
" inoremap <buffer><expr> ? smartchr#one_of('? ', '?')
" inoremap <buffer><expr> : smartchr#one_of(': ', '::', ':')

" " =の場合、単純な代入や比較演算子として入力する場合は前後にスペースをいれる。
" " 複合演算代入としての入力の場合は、直前のスペースを削除して=を入力
" inoremap <buffer><expr> = search('\(&\<bar><bar>\<bar>+\<bar>-\<bar>/\<bar>>\<bar><\) \%#', 'bcn')? '<bs>= '
        " \ : search('\(*\<bar>!\)\%#', 'bcn') ? '= '
        " \ : smartchr#one_of(' = ', ' == ', '=')

" " 下記の文字は連続して現れることがまれなので、二回続けて入力したら改行する
" inoremap <buffer><expr> } smartchr#one_of('}', '}<cr>')
" inoremap <buffer><expr> ; smartchr#one_of(';', ';<cr>')
" " 「->」は入力しづらいので、..で置換え
" inoremap <buffer><expr> . smartchr#loop('.', '->', '...')
" " 行先頭での@入力で、プリプロセス命令文を入力
" inoremap <buffer><expr> @ search('^\(#.\+\)\?\%#','bcn')? smartchr#one_of('#define', '#include', '#ifdef', '#endif', '@'): '@'

" inoremap <buffer><expr> " search('^#include\%#', 'bcn')? ' "': '"'
" " if文直後の(は自動で間に空白を入れる
" inoremap <buffer><expr> ( search('\<\if\%#', 'bcn')? ' (': '('


" ######################################

" surround.vim  (ds, cs, ys, vs)

" ######################################



" ######################################

" grep.vim

" ######################################
" for darwin settings
let Grep_Xargs_Path = "/opt/local/bin/gxargs"
" ignore settings
let Grep_Skip_Dirs = '.svn .hg .git .idea .settings'
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
"
" YankRingSync.vim
"
" ######################################
" yankring.vim path
" let g:yankringsync_yankring_path = '~/.vim/bundle/YankRing.vim/plugin/yankring.vim'


" ######################################
"
" fakeclip.vim
"
" ######################################



" ######################################

" session.vim

" ######################################



" ######################################

" ref.vim

" ######################################




" ######################################

" vim-ref

" ######################################
let g:ref_phpmanual_path = $HOME . '/share/doc/php-chunked-xhtml/'
let g:ref_phpmanual_cmd = 'w3m -dump %s'



" ######################################

" echodoc

" ######################################
let g:echodoc_enable_at_startup = 1


" ######################################

" cd.vim

" ######################################
" au BufEnter * execute ':lcd ' . expand("%:p:h")



" ######################################

" easytags

" ######################################



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
" let g:SrcExpl_RefreshMapKey = '<Space>'
" let g:SrcExpl_GoBackMapKey  = '<C-b>'
" nmap <Leader><F8> :SrcExplToggle<CR>


" xdebug
let g:debuggerMaxDepth = 10


" ----------------------------------------------------------------------

" python
" @link http://sontek.net/turning-vim-into-a-modern-python-ide

" ----------------------------------------------------------------------

" pyflakes
"let g:pyflakes_use_quickfix=0
highlight SpellBad ctermbg=darkred

" pep8
let g:pep8_map='<leader>8'

" complete with document
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" TaskList
nmap <Leader>T :TaskList<CR>

" tag list plugins
if v:version > 700
  " tagbar
  let g:tagbar_usearrows = 1
  nmap <Leader>ll :TagbarToggle<CR>
else
  " taglist
  let Tlist_Use_Right_Window = 1   " right window.
  let Tlist_Auto_Highlight_Tag = 1 " auto highlighted tag.
  let Tlist_Auto_Open = 1          " auto enabled taglist.
  let Tlist_WinWidth = 40          " max window size.
endif


" Add  the  virtualenv's   site-packages  to  vim path
if ! &diff

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

endif


" function GetSitePackages()
  " let path = ""
  " python << EOM
" """
" virtualenv path
" """
" import os
" import sys
" import commands
" from distutils.sysconfig import get_python_lib

" def get_virtualenv_python_lib():
    " """like a get_python_lib()"""
    " #if isinstance(sys.version_info, tuple):
    " #  version = "%s.%s" % (sys.version_info[0], sys.version_info[1])
    " #else:
    " #  version = "%s.%s" % (sys.version_info.major, sys.version_info.minor)
    " v = commands.getoutput('%s/bin/python -V' % os.environ["VIRTUAL_ENV"])
    " v = v.split()[1].split('.')
    " version = "%s.%s" % (v[0], v[1])
    " return "%s/lib/python%s/site-packages" % (os.environ["VIRTUAL_ENV"], version)

" vim.command('let path = "%s"' % get_virtualenv_python_lib())
" commands.getoutput('export get_virtualenv_python_lib=%s' % get_virtualenv_python_lib())
" EOM
  " return path
" endfunction

" call GetSitePackages()


" ######################################

" project.vim

" ######################################
" python django, https://code.djangoproject.com/wiki/UsingVimWithDjango
" Django Project=/Users/ikeda/.virtualenvs/mw_py27/backend/ CD=. filter="[^_]*.py" {
 " settings.py
 " urls.py
 " apps=apps {
  " Polls=polls {
   " views.py
   " models.py
  " }
  " ToDo=todo {
   " views.py
   " models.py
  " }
 " media=mediaDir {
  " images=imagesDir {
  " }
 " }
" }



" ######################################

" auto highlight

" ######################################
" call AutoHighlightToggle()

let ColorRoller = {}

" let ColorRoller.colors = [
" \ 'Solarized',
" \ 'adaryn',
" \ 'adrian',
" \ 'aiseered',
" \ 'almost-default',
" \ 'anotherdark',
" \ 'aqua',
" \ 'astronaut',
" \ 'asu1dark',
" \ 'autumn',
" \ 'autumn2',
" \ 'autumnleaf',
" \ 'baycomb',
" \ 'bclear',
" \ 'biogoo',
" \ 'blacksea',
" \ 'bluegreen',
" \ 'borland',
" \ 'breeze',
" \ 'brookstream',
" \ 'buttercream',
" \ 'calmar256-dark',
" \ 'calmar256-light',
" \ 'camo',
" \ 'candy',
" \ 'candycode',
" \ 'chela_light',
" \ 'chocolateliquor',
" \ 'clarity',
" \ 'cleanphp',
" \ 'colorer',
" \ 'dante',
" \ 'darkZ',
" \ 'darkblue2',
" \ 'darkbone',
" \ 'darkslategray',
" \ 'darkspectrum',
" \ 'dawn',
" \ 'denim',
" \ 'desert256',
" \ 'desertEx',
" \ 'dusk',
" \ 'dw_blue',
" \ 'dw_cyan',
" \ 'dw_green',
" \ 'dw_orange',
" \ 'dw_purple',
" \ 'dw_red',
" \ 'dw_yellow',
" \ 'earendel',
" \ 'eclipse',
" \ 'ekvoli',
" \ 'fine_blue',
" \ 'fine_blue2',
" \ 'fnaqevan',
" \ 'fog',
" \ 'freya',
" \ 'fruit',
" \ 'fruity',
" \ 'golden',
" \ 'guardian',
" \ 'habilight',
" \ 'herald',
" \ 'impact',
" \ 'inkpot',
" \ 'ironman',
" \ 'jammy',
" \ 'jellybeans',
" \ 'kellys',
" \ 'leo',
" \ 'lettuce',
" \ 'lucius',
" \ 'manxome',
" \ 'marklar',
" \ 'maroloccio',
" \ 'martin_krischik',
" \ 'matrix',
" \ 'molokai',
" \ 'moria',
" \ 'moss',
" \ 'motus',
" \ 'mustang',
" \ 'navajo-night',
" \ 'navajo',
" \ 'neon',
" \ 'neverness',
" \ 'night',
" \ 'nightshimmer',
" \ 'no_quarter',
" \ 'northland',
" \ 'nuvola',
" \ 'oceanblack',
" \ 'oceandeep',
" \ 'oceanlight',
" \ 'olive',
" \ 'papayawhip',
" \ 'peaksea',
" \ 'print_bw',
" \ 'pyte',
" \ 'railscasts',
" \ 'railscasts2',
" \ 'rdark',
" \ 'relaxedgreen',
" \ 'robinhood',
" \ 'rootwater',
" \ 'satori',
" \ 'sea',
" \ 'settlemyer',
" \ 'sienna',
" \ 'silent',
" \ 'simpleandfriendly',
" \ 'softblue',
" \ 'soso',
" \ 'spring',
" \ 'summerfruit256',
" \ 'synic',
" \ 'tabula',
" \ 'tango',
" \ 'tango2',
" \ 'taqua',
" \ 'tcsoft',
" \ 'tir_black',
" \ 'tolerable',
" \ 'torte',
" \ 'twilight',
" \ 'two2tango',
" \ 'vc',
" \ 'vibrantink',
" \ 'vividchalk',
" \ 'vylight',
" \ 'winter',
" \ 'wombat',
" \ 'wombat256',
" \ 'wood',
" \ 'wuye',
" \ 'xemacs',
" \ 'xoria256',
" \ 'zenburn',
" \ 'zmrok',
      " \ ]


let ColorRoller.colors = [
\ 'mine',
\ 'breeze',
\ 'ChocolateLiquor',
\ 'Tomorrow-Night-Bright',
\ 'adaryn',
\ 'anotherdark',
\ 'asu1dark',
      \ ]


function! ColorRoller.change()
  let color = get(self.colors, 0)
  " tabpagecolorscheme を使用している場合は↓の "colorscheme" を "Tcolorscheme" に変える。
  silent exe "colorscheme " . color
  redraw
  echo self.colors
endfunction

function! ColorRoller.roll()
  let item = remove(self.colors, 0)
  call insert(self.colors, item, len(self.colors))
  call self.change()
endfunction

function! ColorRoller.unroll()
  let item = remove(self.colors, -1)
  call insert(self.colors, item, 0)
  call self.change()
endfunction

nnoremap <silent><Down>   :<C-u>call ColorRoller.roll()<CR>
nnoremap <silent><Up>     :<C-u>call ColorRoller.unroll()<CR>
" nnoremap <silent><Leader><f9> :<C-u>call ColorRoller.roll()<CR>

