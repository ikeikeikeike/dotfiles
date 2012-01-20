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


