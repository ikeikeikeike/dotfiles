" -*- coding: utf-8 -*-
" viとの互換性をとらない(vimの独自拡張機能を使う為)
set nocompatible

" ------------------------
"
"   vundle -> neobundle
"
" ------------------------

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" unites
if v:version > 700
    " anything like buffer management app.
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'tsukkee/unite-tag'
    NeoBundle 'tsukkee/unite-help'
    NeoBundle 'ujihisa/unite-locate'
    " NeoBundle 'heavenshell/unite-zf'
    " NeoBundle 'Sixeight/unite-grep'
    " NeoBundle 'ujihisa/unite-colorscheme'
    " NeoBundle 'unite-font'
endif
" ~~~~~~~~~~~~
" general
" ~~~~~~~~~~~~
" yank and clipboard
NeoBundle 'kana/vim-fakeclip'

" buffer
" NeoBundle 'minibufexpl.vim'

" auto complete
NeoBundle 'ujihisa/neco-look'

" color & theme
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
" NeoBundle 'ChrisKempson/Vim-Tomorrow-Theme'
NeoBundle 'nginx.vim'

" () color
NeoBundle 'kien/rainbow_parentheses.vim'

" sudo
NeoBundle 'sudo.vim'

" undo
NeoBundle 'Gundo'

" csv
" NeoBundle 'chrisbra/csv.vim'

" ~~~~~~~~~~~~
" move
" ~~~~~~~~~~~~
" NeoBundle 'fuzzyjump.vim'
if v:version > 700
    NeoBundle 'clones/vim-l9'
    NeoBundle 'FuzzyFinder'
endif


" ~~~~~~~~~~~~
" programmings
" ~~~~~~~~~~~~
if v:version > 700
    " yankring
    NeoBundle 'YankRing.vim'
    NeoBundle 'm4i/YankRingSync'

    " auto complete
    " NeoBundle 'neocomplcache'
    NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'Shougo/neosnippet'
    " NeoBundle "Shougo/neocomplcache-clang"

endif

" Todo tasklist
NeoBundle 'TaskList.vim'

" source viewer for tags
" NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'trinity.vim'

" easytags
" NeoBundle 'xolox/vim-easytags'

" taglist
NeoBundle 'taglist.vim'

if v:version > 700
    " tagbar
    NeoBundle 'majutsushi/tagbar'
endif

" " 保存前差分 表示
" NeoBundle 'Changed'

" tree view
NeoBundle "scrooloose/nerdtree"

" comment
NeoBundle "scrooloose/nerdcommenter"

" which-func-mode
NeoBundle "tyru/current-func-info.vim"

" indent
NeoBundle 'nathanaelkane/vim-indent-guides'

" vimshell
" NeoBundle 'Shougo/vimshell'

" vimproc
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac_old.mak',
\     'unix' : 'make -f make_unix.mak',
\     'linux' : 'make -f make_unix.mak',
\   },
\ }

" quickrun
NeoBundle 'thinca/vim-quickrun'

" ~~~~~~~~~~~~~~~~~~
" write multiselect
" ~~~~~~~~~~~~~~~~~~
" NeoBundle 'multiselect'
" NeoBundle 'genutils'

" ~~~~~~~~~
" error (syntax) check
" ~~~~~~~~~
NeoBundle "scrooloose/syntastic"
" NeoBundle 'errormarker.vim'
" Javascript
NeoBundle 'javaScriptLint.vim'
" Less (css)
NeoBundle 'groenewege/vim-less'


" ~~~~~~~~~~
" help, doc
" ~~~~~~~~~~
NeoBundle 'thinca/vim-ref'
NeoBundle 'ref.vim'
NeoBundle 'Shougo/echodoc'
NeoBundle 'php-doc'
NeoBundle 'Modeliner'


" ~~~~~~~~~~~~
" languages
" ~~~~~~~~~~~~
" Sql
NeoBundle 'sql.vim--Fishburn-syntax'

" Html & javascript indentations
NeoBundle 'Simple-Javascript-Indenter' " 1.0.1 A simple javascript indent script, support OOP, jquery
NeoBundle 'nono/jquery.vim' " Syntax file for jQuery in ViM
NeoBundle 'jelera/vim-javascript-syntax'
" NeoBundle 'teramako/jscomplete-vim'

" Python
if ! &diff
    " has pyflakes
    " NeoBundle 'mitechie/pyflakes-pathogen'
    " has not pyflakes
    NeoBundle 'pyflakes.vim'
endif
NeoBundle 'pep8'
" NeoBundle 'nvie/vim-flake8'
" NeoBundle 'amitdev/vimpy'
NeoBundle 'vim-scripts/django.vim'
" NeoBundle 'jmcantrell/vim-virtualenv'
" NeoBundle 'project.tar.gz'
" NeoBundle 'vim-ipython'
NeoBundle "davidhalter/jedi-vim", {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'git submodule update --init',
\     'mac' : 'git submodule update --init',
\     'unix' : 'git submodule update --init',
\     'linux' : 'git submodule update --init',
\   },
\ }


" ruby
" NeoBundle 'astashov/vim-ruby-debugger'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'rhysd/unite-ruby-require.vim'

" php
" NeoBundle 'justinrainbow/php-xdebug.vim'

" CoffeeScript
NeoBundle "kchmck/vim-coffee-script"
NeoBundle "othree/coffee-check.vim"
" NeoBundle "shadow.vim"

" html5
NeoBundle 'html5.vim'
NeoBundle 'HTML5-Syntax-File'

" Haskell
NeoBundle "lukerandall/haskellmode-vim"
NeoBundle "ujihisa/neco-ghc"
NeoBundle "eagletmt/ghcmod-vim"

" Clojure
" NeoBundle 'VimClojure'
NeoBundle 'vim-scripts/slimv.vim'

" golang
NeoBundle 'Blackrush/vim-gocode'

" Haxe
NeoBundle 'jdonaldson/vaxe'

" typescript
NeoBundle 'leafgarland/typescript-vim'

" ~~~~~~~~~
" profiler
" ~~~~~~~~~
" NeoBundle 'mattn/benchvimrc-vim'


" -------

" scm
" NeoBundle 'fugitive.vim'
NeoBundle 'mattn/gist-vim'

" grep
" NeoBundle 'ack.vim'
" NeoBundle 'rking/ag.vim'
NeoBundle 'grep.vim'
NeoBundle 'thinca/vim-qfreplace'


 " diff
NeoBundle 'DirDiff.vim'
" session
" if v:version > 700
    " if ! &diff
        " NeoBundle 'session.vim'
    " endif
" endif
" NeoBundle 'sessionman.vim'

" Search and replace
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-over'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" support input , text-object
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" NeoBundle 'kana/vim-smartchr'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
" NeoBundle 'vim-scripts/AutoClose'
NeoBundle 'ZenCoding.vim'
NeoBundle 'tpope/vim-endwise.git'
NeoBundle 'kana/vim-smartinput' " Vim plugin: Provide smart input assistant

" ~~~~~~~
" funny
" ~~~~~~~
" NeoBundle 'koron/nyancat-vim'
" NeoBundle 'mattn/vdbi-vim'
" NeoBundle "mattn/hahhah-vim"

" ~~~~~~~
" api
" ~~~~~~~
NeoBundle 'mattn/webapi-vim'


"
" status line
"
" NeoBundle 'bling/vim-airline'
" NeoBundle 'itchyny/lightline.vim'



" ----------------
"
" *
" * `setting loader`
" *
"
"   -- general --
"   - general
"   - general-move
"   - general-diff
"   - general-file
"   - general-backup
"   - general-search
"   - general-encode
"   - general-window
"   - general-display
"   - general-operation
"   - general-colorscheme
"
"   -- user function --
"   - python
"   - userfunction
"
"   -- plugins --
"   - ref
"   - tab
"   - gist
"   - undo
"   - grep
"   - slimv
"   - unite
"   - omuni
"   - gundo
"   - ctags
"   - xdebug
"   - migemo
"   - rsense
"   - srcexl
"   - flake8
"   - echodoc
"   - vim-ref
"   - session
"   - easytags
"   - 256color
"   - fakeclip
"   - jedi-vim
"   - yankring
"   - surround
"   - nerdtree
"   - vimclojre
"   - syntastic
"   - jscomplete
"   - fuzzyfinder
"   - haskell_doc
"   - errormarker
"   - yankringsync
"   - vim-smartchr
"   - nerdcommenter
"   - neocomplecache
"   - vim-indent-guides
"   - rainbow_parentheses
"   - neocomplcache-rsense
"
"

" ----------------
for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
  exe 'source' f
endfor



" --------------------------------
"
" Finish
"
" --------------------------------

" ステータスライン文字コード表示
" set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)\ %{cfi#format(\"[%s()]\",\ \"[no\ function]\")}\ %m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}
" let &statusline='%<%F %r%h%w%y%{"['.(&fenc!=''?&fenc:&enc).'|'.&ff.']"}  %l/%L (%P) %{cfi#format("[%s()]", "[no function]")} [WORKON=%{pythonworkon}-%{VirtualEnvStatusline()}] %m%=%{strftime("%Y/%m/%d %H:%M")}'

" ステータスライン文字コード表示
" set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)\ %{cfi#format(\"[%s()]\",\ \"[no\ function]\")}\ %m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}
" let &statusline='%<%F %r%h%w%y%{"['.(&fenc!=''?&fenc:&enc).'|'.&ff.']"}  %l/%L (%P) %{cfi#format("[%s()]", "[no function]")} %m%=%{strftime("%Y/%m/%d %H:%M")}'

" not switch vim-airline
if &diff == 0
    let &statusline='%<%F %r%h%w%y%{"['.(&fenc!=''?&fenc:&enc).'|'.&ff.']"}  %l/%L (%P) %{cfi#format("[%s()]", "[no function]")} [WORKON=%{pythonworkon}] %{anzu#search_status()} %m%=%{strftime("%Y/%m/%d %H:%M")}'
endif


" For cron
" set backupskip=/tmp/*,/private/tmp/*
