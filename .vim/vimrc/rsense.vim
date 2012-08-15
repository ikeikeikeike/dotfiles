" ######################################

" Rsense

" ######################################
" $RSENSE_HOME
let g:rsenseHome = $RSENSE_HOME
let g:rsenseUseOmniFunc = 1

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
