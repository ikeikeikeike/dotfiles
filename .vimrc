
" viとの互換性をとらない(vimの独自拡張機能を使う為)
set nocompatible

" ------------
"
"   vundle
"
" ------------

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'vundle'

" unites
if v:version > 700
    " anything like buffer management app.
    Bundle 'Shougo/unite.vim'
    Bundle 'tsukkee/unite-tag'
    Bundle 'tsukkee/unite-help'
    Bundle 'ujihisa/unite-locate'
    Bundle 'heavenshell/unite-zf'
    " Bundle 'Sixeight/unite-grep'
    " Bundle 'ujihisa/unite-colorscheme'
    " Bundle 'unite-font'
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
Bundle 'taichouchou2/vim-rsense'

" color & theme
Bundle 'Color-Sampler-Pack'
" Bundle 'ChrisKempson/Vim-Tomorrow-Theme'
Bundle 'nginx.vim'

" () color
Bundle 'kien/rainbow_parentheses.vim'

" sudo
Bundle 'sudo.vim'

" undo
Bundle 'Gundo'


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
    " Bundle 'Shougo/neocomplcache'
    Bundle 'neocomplcache'
    Bundle 'Shougo/neocomplcache-snippets-complete'
    " Bundle "Shougo/neocomplcache-clang"

endif

" Todo tasklist
Bundle 'TaskList.vim'

" source viewer for tags
Bundle 'Source-Explorer-srcexpl.vim'
Bundle 'trinity.vim'

" easytags
" Bundle 'xolox/vim-easytags'

" taglist
Bundle 'taglist.vim'

if v:version > 700
    " tagbar
    Bundle 'majutsushi/tagbar'
endif

" " 保存前差分 表示
" Bundle 'Changed'

" tree view
Bundle "scrooloose/nerdtree"

" comment
Bundle "scrooloose/nerdcommenter"

" which-func-mode
Bundle "tyru/current-func-info.vim"

" indent
Bundle 'nathanaelkane/vim-indent-guides'

" vimshell
" Bundle 'Shougo/vimshell'

" vimproc
Bundle 'Shougo/vimproc'

" quickrun
Bundle 'thinca/vim-quickrun'

" ~~~~~~~~~~~~~~~~~~
" write multiselect
" ~~~~~~~~~~~~~~~~~~
" Bundle 'multiselect'
" Bundle 'genutils'

" ~~~~~~~~~
" error (syntax) check
" ~~~~~~~~~
Bundle "scrooloose/syntastic"
" Bundle 'errormarker.vim'
" Javascript
Bundle 'javaScriptLint.vim'
" Less
Bundle 'groenewege/vim-less'


" ~~~~~~~~~~
" help, doc
" ~~~~~~~~~~
Bundle 'thinca/vim-ref'
Bundle 'ref.vim'
Bundle 'Shougo/echodoc'
Bundle 'php-doc'
Bundle 'Modeliner'


" ~~~~~~~~~~~~
" languages
" ~~~~~~~~~~~~
" sql
Bundle 'sql.vim--Fishburn-syntax'

" html & javascript indentations
Bundle "lukaszb/vim-web-indent"
Bundle "teramako/jscomplete-vim"

" python
if ! &diff
    " has pyflakes
    " Bundle 'mitechie/pyflakes-pathogen'
    " has not pyflakes
    Bundle 'pyflakes.vim'
endif
Bundle 'pep8'
" Bundle 'nvie/vim-flake8'
Bundle 'amitdev/vimpy'
Bundle 'vim-scripts/django.vim'
" Bundle 'jmcantrell/vim-virtualenv'
" Bundle 'project.tar.gz'
" Bundle 'vim-ipython'

" ruby
Bundle 'astashov/vim-ruby-debugger'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'

" php
" Bundle 'justinrainbow/php-xdebug.vim'

" CoffeeScript
Bundle "kchmck/vim-coffee-script"
Bundle "carlosvillu/coffeScript-VIM-Snippets"
Bundle "othree/coffee-check.vim"
" Bundle "shadow.vim"

" html5
Bundle 'html5.vim'
Bundle 'HTML5-Syntax-File'

" Haskell
Bundle "lukerandall/haskellmode-vim"
Bundle "ujihisa/neco-ghc"
Bundle "eagletmt/ghcmod-vim"

" Clojure
" Bundle 'VimClojure'
Bundle 'vim-scripts/slimv.vim'


" ~~~~~~~~~
" profiler
" ~~~~~~~~~
" Bundle 'mattn/benchvimrc-vim'


" -------

" scm
" Bundle 'fugitive.vim'
Bundle 'mattn/gist-vim'

" grep
Bundle 'ack.vim'
Bundle 'grep.vim'
Bundle 'thinca/vim-qfreplace'


 " diff
Bundle 'DirDiff.vim'
" session
" if v:version > 700
    " if ! &diff
        " Bundle 'session.vim'
    " endif
" endif
" Bundle 'sessionman.vim'

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" support input , text-object
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Bundle 'kana/vim-smartchr'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
" Bundle 'vim-scripts/AutoClose'
Bundle 'ZenCoding.vim'
Bundle 'tpope/vim-endwise.git'


" ~~~~~~~
" funny
" ~~~~~~~
" Bundle 'koron/nyancat-vim'
" Bundle 'mattn/vdbi-vim'
" Bundle "mattn/hahhah-vim"

" ~~~~~~~
" api
" ~~~~~~~
Bundle 'mattn/webapi-vim'

" ----------------
"
" *
" * `setting loader`
" *
"
"   -- general --
"   - general
"   - general-move
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
"   - gist
"   - undo
"   - grep
"   - slimv
"   - unite
"   - omuni
"   - gundo
"   - ctags
"   - xdebug
"   - rsense
"   - srcexl
"   - flake8
"   - echodoc
"   - vim-ref
"   - session
"   - easytags
"   - 256color
"   - fakeclip
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
let &statusline='%<%F %r%h%w%y%{"['.(&fenc!=''?&fenc:&enc).'|'.&ff.']"}  %l/%L (%P) %{cfi#format("[%s()]", "[no function]")} [WORKON=%{pythonworkon}] %m%=%{strftime("%Y/%m/%d %H:%M")}'

" ステータスライン文字コード表示
" set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}\ \ %l/%L\ (%P)\ %{cfi#format(\"[%s()]\",\ \"[no\ function]\")}\ %m%=%{strftime(\"%Y/%m/%d\ %H:%M\")}
" let &statusline='%<%F %r%h%w%y%{"['.(&fenc!=''?&fenc:&enc).'|'.&ff.']"}  %l/%L (%P) %{cfi#format("[%s()]", "[no function]")} %m%=%{strftime("%Y/%m/%d %H:%M")}'
