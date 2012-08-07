" ######################################

" vim-indent-guides

" ######################################
" let g:indent_guides_enable_on_vim_startup " gvim only  - vim立ち上げ時に自動的にvim-indent-guidesをオンにする -
" autocmd FileType python,php,ruby,scala IndentGuidesEnable " use terminal

" let g:indent_guides_auto_colors = 1
" let g:indent_guides_color_change_percent = 10
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black guibg=black ctermbg=6 " インデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey guibg=darkgrey ctermbg=0 " 二段階目のインデントの色
let g:indent_guides_guide_size = 1 " インデントの色付け幅
