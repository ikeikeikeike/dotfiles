" ######################################

" auto highlight

" ######################################
" call AutoHighlightToggle()

let ColorRoller = {}

let ColorRoller.colors = [
\ 'onedark',
\ 'wombat256',
\ 'breeze',
\ 'desert256',
\ 'xoria256',
\ 'tabula',
\ 'calmar256-dark',
\ 'adaryn',
\ 'adrian',
\ 'aiseered',
\ 'wombat',
\ 'wood',
\ 'xemacs',
\ 'zenburn',
\ 'zmrok',
\ 'anotherdark',
\ 'aqua',
\ 'astronaut',
\ 'asu1dark',
\ 'autumn',
\ 'autumn2',
\ 'autumnleaf',
\ 'baycomb',
\ 'bclear',
\ 'biogoo',
\ 'blacksea',
\ 'bluegreen',
\ 'borland',
\ 'brookstream',
\ 'buttercream',
\ 'camo',
\ 'candy',
\ 'candycode',
\ 'chela_light',
\ 'chocolateliquor',
\ 'clarity',
\ 'cleanphp',
\ 'colorer',
\ 'dante',
\ 'darkZ',
\ 'darkblue2',
\ 'darkbone',
\ 'darkslategray',
\ 'darkspectrum',
\ 'dawn',
\ 'denim',
\ 'desertEx',
\ 'dusk',
\ 'dw_blue',
\ 'dw_cyan',
\ 'dw_green',
\ 'dw_orange',
\ 'dw_purple',
\ 'dw_red',
\ 'dw_yellow',
\ 'earendel',
\ 'eclipse',
\ 'ekvoli',
\ 'fine_blue',
\ 'fine_blue2',
\ 'fnaqevan',
\ 'fog',
\ 'freya',
\ 'fruit',
\ 'fruity',
\ 'golden',
\ 'guardian',
\ 'habilight',
\ 'herald',
\ 'impact',
\ 'inkpot',
\ 'ironman',
\ 'jammy',
\ 'jellybeans',
\ 'kellys',
\ 'leo',
\ 'lettuce',
\ 'lucius',
\ 'manxome',
\ 'marklar',
\ 'maroloccio',
\ 'martin_krischik',
\ 'matrix',
\ 'molokai',
\ 'moria',
\ 'moss',
\ 'motus',
\ 'mustang',
\ 'navajo-night',
\ 'navajo',
\ 'neon',
\ 'neverness',
\ 'night',
\ 'nightshimmer',
\ 'no_quarter',
\ 'northland',
\ 'nuvola',
\ 'oceanblack',
\ 'oceandeep',
\ 'oceanlight',
\ 'olive',
\ 'papayawhip',
\ 'peaksea',
\ 'print_bw',
\ 'pyte',
\ 'railscasts',
\ 'railscasts2',
\ 'rdark',
\ 'relaxedgreen',
\ 'robinhood',
\ 'rootwater',
\ 'satori',
\ 'sea',
\ 'settlemyer',
\ 'sienna',
\ 'silent',
\ 'simpleandfriendly',
\ 'softblue',
\ 'soso',
\ 'spring',
\ 'synic',
\ 'tango',
\ 'tango2',
\ 'taqua',
\ 'tcsoft',
\ 'tir_black',
\ 'tolerable',
\ 'torte',
\ 'twilight',
\ 'two2tango',
\ 'vc',
\ 'vibrantink',
\ 'vividchalk',
\ 'vylight',
\ 'winter',
\ 'calmar256-light',
\ 'summerfruit256',
\ 'wuye',
\ ]

" let ColorRoller.colors = [
" \ 'breeze',
" \ 'ChocolateLiquor',
" \ 'Tomorrow-Night-Bright',
" \ 'adaryn',
" \ 'anotherdark',
" \ 'asu1dark',
      " \ ]


function! ColorRoller.change()
  let color = get(self.colors, 0)
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

" nnoremap <silent><Down>   :<C-u>call ColorRoller.roll()<CR>
" nnoremap <silent><Up>     :<C-u>call ColorRoller.unroll()<CR>
" nnoremap <silent><Leader><f9> :<C-u>call ColorRoller.roll()<CR>


