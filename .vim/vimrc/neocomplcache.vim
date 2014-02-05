" ######################################

" 保管 newcomplecache auto-complete snippets

" ######################################
if v:version > 700

    " 自動で有効
    let g:neocomplcache_enable_at_startup = 1
    " 大文字が入力されるまで大文字小文字の区別を無視
    let g:neocomplcache_enable_smart_case = 1
    " _ 区切りの補完を有効化します。
    let g:neocomplcache_enable_underbar_completion = 1
    " シンタックスをキャッシュするときの最小文字長を3文字 default 4
    let g:neocomplcache_min_syntax_length = 3

    " C-j snippet
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

    " " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \'default' : '',
                \ 'c' : $HOME.'/.vim/dict/c.dict',
                \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
                \ 'java' : $HOME.'/.vim/dict/java.dict',
                \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
                \ 'lua' : $HOME.'/.vim/dict/lua.dict',
                \ 'ocaml' : $HOME.'/.vim/dict/ocaml.dict',
                \ 'scala' : $HOME.'/.vim/dict/scala.dict',
                \ 'scheme' : $HOME.'/.vim/dict/scheme.dict',
                \ 'perl' : $HOME.'/.vim/dict/perl.dict',
                \ 'php' : $HOME.'/.vim/dict/php.dict',
                \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
                \ 'python' : $HOME.'/.vim/dict/python.dict',
                \ 'vim' : $HOME.'/.vim/dict/vim.dict',
                \ 'css' : $HOME.'/.vim/dict/css.dict'
                \ }


    " 関数を補完するための区切り文字パターン
    if !exists('g:neocomplcache_delimiter_patterns')
      let g:neocomplcache_delimiter_patterns = {}
    endif
    " let g:neocomplcache_delimiter_patterns['python'] = ['.']
    " let g:neocomplcache_delimiter_patterns['ruby'] = ['.']
    let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

    " ファイルタイプの関連付け
    if !exists('g:neocomplcache_same_filetype_lists')
      let g:neocomplcache_same_filetype_lists = {}
    endif
    let g:neocomplcache_same_filetype_lists['asc'] = 'javascript'
    let g:neocomplcache_same_filetype_lists['twig'] = 'html'

    " "インクルードパスの指定
    let g:neocomplcache_include_paths = {
            \ 'cpp'  : '.,/usr/include/c++/4.2.1,/opt/local/include,/usr/include',
            \ 'c'    : '.,/usr/include',
            \ 'ruby' : '.,$HOME/.rvm/rubies/**/lib/ruby/**/',
            \ 'perl' : '.,/System/Library/Perl,/Users/rhayasd/programs',
            \ }

    "インクルード文のパターンを指定
    let g:neocomplcache_include_patterns = {
            \ 'php' : '^\s*require_once',
            \ 'cpp' : '^\s*#\s*include',
            \ 'ruby' : '^\s*require',
            \ 'perl' : '^\s*use',
            \ }

    "インクルード先のファイル名の解析パターン
    let g:neocomplcache_include_exprs = {
            \ 'ruby' : "substitute(substitute(v:fname,'::','/','g'),'$','.rb','')"
            \ }

    " Enable omni completion.
    autocmd FileType eruby,html,markdown set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    """ default javascript complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    " autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType python set omnifunc=pythoncomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    " let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    " let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    " let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


    """"""""""""""""""""""""""""""""""""""""""""
    " neocomplecache-clang "
    """"""""""""""""""""""""""""""""""""""""""""
    " {{{
    " libclangを使う
    let g:neocomplcache_clang_use_library = 1
    " ライブラリへのパス
    let g:neocomplcache_clang_library_path = '/usr/lib/clang/3.1'
    " clangへのパス
    let g:neocomplcache_clang_executable_path = '/usr/bin'
    " let g:neocomplcache_clang_auto_options = ''
    " clangのコマンドオプション
    let g:neocomplcache_clang_user_options =
        \'-I /usr/include/c++/4.2.1 '.
        \'-I /usr/include '.
        \'-I /opt/local/include/boost '
        " \'-I /usr/local/Cellar/gcc/4.6.2/gcc/include '.
        " \'-I /usr/local/Cellar/boost/1.48.0/include '
    " }}}

endif
