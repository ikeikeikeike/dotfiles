" -------------------------------

" vim-smartinput.vim

" -------------------------------

let g:smartinput_no_default_key_mappings = 1

" ERB
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#define_rule({
\   'at': '<\%#', 'char': '%', 'input': '%=  %><Left><Left><Left>',
\   'filetype': ['eruby', 'eelixir'],
\ })
call smartinput#define_rule({
\   'at': '%.*\%#%', 'char': '%', 'input': '',
\   'filetype': ['eruby', 'eelixir'],
\ })
