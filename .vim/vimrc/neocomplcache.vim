" ######################################

" 保管 newcomplecache auto-complete

" ######################################
if v:version > 700

    if neobundle#is_installed('neocomplete')
        " neocomplete用設定

        " 自動で有効
        let g:neocomplete#enable_at_startup = 1
        " 大文字が入力されるまで大文字小文字の区別を無視
        let g:neocomplete#enable_smart_case = 1
        " シンタックスをキャッシュするときの最小文字長を3文字 default 4
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        " 補完候補検索時に大文字・小文字を無視する
        let g:neocomplete#enable_ignore_case = 1

        let g:neocomplete#sources#dictionary#dictionaries = {
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

        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns._ = '\h\w*'

        if !exists('g:neocomplete#delimiter_patterns')
          let g:neocomplete#delimiter_patterns = {}
        endif
        " let g:neocomplete_delimiter_patterns['python'] = ['.']
        let g:neocomplete#delimiter_patterns['ruby'] = ['.']
        let g:neocomplete#delimiter_patterns['php'] = ['->', '::', '\']

        " ファイルタイプの関連付け
        if !exists('g:neocomplete#same_filetypes')
          let g:neocomplete#same_filetypes = {}
        endif
        let g:neocomplete#same_filetypes['asc'] = 'javascript'
        let g:neocomplete#same_filetypes['twig'] = 'html'

        " "インクルードパスの指定
        let g:neocomplete#sources#include#paths = {
                \ 'cpp'  : '.,/usr/include/c++/4.2.1,/opt/local/include,/usr/include',
                \ 'c'    : '.,/usr/include',
                \ 'ruby' : '.,$HOME/.rbenv/versions/**/lib/ruby/**/',
                \ 'perl' : '.,/System/Library/Perl,/Users/rhayasd/programs',
                \ }

        "インクルード文のパターンを指定
        let g:neocomplete#sources#include#patterns = {
                \ 'php' : '^\s*require_once',
                \ 'cpp' : '^\s*#\s*include',
                \ 'ruby' : '^\s*require',
                \ 'perl' : '^\s*use',
                \ }

        "インクルード先のファイル名の解析パターン
        let g:neocomplete#sources#include#exprs = {
                \ 'ruby' : "substitute(substitute(v:fname,'::','/','g'),'$','.rb','')"
                \ }

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        " let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

        " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        " let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        " let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        " let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    elseif neobundle#is_installed('neocomplcache')
        " neocomplcache用設定

        " 自動で有効
        let g:neocomplcache_enable_at_startup = 1
        " 大文字が入力されるまで大文字小文字の区別を無視
        let g:neocomplcache_enable_smart_case = 1
        " _ 区切りの補完を有効化します。
        let g:neocomplcache_enable_underbar_completion = 1
        " シンタックスをキャッシュするときの最小文字長を3文字 default 4
        let g:neocomplcache_min_syntax_length = 3
        " 補完候補検索時に大文字・小文字を無視する
        let g:neocomplcache_enable_ignore_case = 1
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

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        " let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        " let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        " let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    endif

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

endif
