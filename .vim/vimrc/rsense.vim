" ######################################

" Rsense

" ######################################

"{{{
" Rsense
let g:rsenseHome = $RSENSE_HOME
let g:rsenseUseOmniFunc = 1

function! SetUpRubySetting()
  setlocal completefunc=RSenseCompleteFunction
  nmap <buffer>tj :RSenseJumpToDefinition<CR>
  nmap <buffer>tk :RSenseWhereIs<CR>
  nmap <buffer>td :RSenseTypeHelp<CR>
endfunction
autocmd FileType ruby,eruby,ruby.rspec call SetUpRubySetting()

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


"}}}
