
# Emacsと同じキー操作を行う
bindkey -e

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000000
SAVEHIST=10000000

# auto complete compile
autoload -U compinit
compinit

# extra auto complete
#fpath=($fpath $HOME/.zsh_extend/autocomplete)
#autoload -Uz compinit
#compinit

# alias
source $HOME/.zsh_extend/aliases

# archifile
if [ -f $HOME/.archirc ]; then
  echo 1111
  source $HOME/.archirc
fi

#### Prompt Color Table Z shell
## Text Forground Colors
local fg_black=$'\e[0;30m'
local fg_red=$'\e[0;31m'
local fg_green=$'\e[0;32m'
local fg_brown=$'\e[0;33m'
local fg_blue=$'\e[0;34m'
local fg_purple=$'\e[0;35m'
local fg_cyan=$'\e[0;36m'
local fg_lgray=$'\e[0;37m'
local fg_dgray=$'\e[1;30m'
local fg_lred=$'\e[1;31m'
local fg_lgreen=$'\e[1;32m'
local fg_yellow=$'\e[1;33m'
local fg_lblue=$'\e[1;34m'
local fg_pink=$'\e[1;35m'
local fg_lcyan=$'\e[1;36m'
local fg_white=$'\e[1;37m'
## Text Background Colors
local bg_red=$'\e[0;41m'
local bg_green=$'\e[0;42m'
local bg_brown=$'\e[0;43m'
local bg_blue=$'\e[0;44m'
local bg_purple=$'\e[0;45m'
local bg_cyan=$'\e[0;46m'
local bg_gray=$'\e[0;47m'
## Attributes
local at_normal=$'\e[0m'
local at_bold=$'\e[1m'
local at_italics=$'\e[3m'
local at_underl=$'\e[4m'
local at_blink=$'\e[5m'
local at_outline=$'\e[6m'
local at_reverse=$'\e[7m'
local at_nondisp=$'\e[8m'
local at_strike=$'\e[9m'
local at_boldoff=$'\e[22m'
local at_italicsoff=$'\e[23m'
local at_underloff=$'\e[24m'
local at_blinkoff=$'\e[25m'
local at_reverseoff=$'\e[27m'
local at_strikeoff=$'\e[29m'
# compatibility
local RED=$'%{\e[0;31m%}'
local PURPLE=$'%{\e[0;35m%}'
local LIGHT_BLUE=$'%{\e[1;34m%}'
local WHITE=$'%{\e[1;37m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
local CYAN=$'%{\e[0;36m%}'
local BROWN=$'%{\e[0;33m%}'
local BG_BLUE=$'%{\e[0;44m%}'

# less
export PAGER='less'
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'

#エイリアスも補完対象に設定
setopt complete_aliases

# share history
setopt share_history

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## no beep
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

#日本語ファイル名等8ビットを通す
setopt print_eight_bit

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## TAB で順に補完候補を切り替える
setopt auto_menu

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

# 辞書順ではなく数値順でソート
setopt numeric_glob_sort

## cd conf
# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
#cdpath=($HOME)
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd
#LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

## auto complete conf
# 補完候補を ←↓↑→ でも選択出来るようにする
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
#
#_complete
#普通の補完関数
#_approximate
#ミススペルを訂正した上で補完を行う。
#_match
#*などのグロブによってコマンドを補完できる(例えばvi* と打つとviとかvimとか補完候補が表示される)
#_expand
#グロブや変数の展開を行う。もともとあった展開と比べて、細かい制御が可能
#_history
#履歴から補完を行う。_history_complete_wordから使われる
#_prefix
#カーソルの位置で補完を行う 
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

# functions
source $HOME/.zsh_extend/funcs

# vcs_info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '%s-[%b] ~/%S'
zstyle ':vcs_info:*' actionformats '%s-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

## prompt
PROMPT=$'\n'$GREEN'${USER}@${HOST}'$CYAN'(${ARCHI}-${DISTRIBUTE}) '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '
RPROMPT=${BG_BLUE}%1v%2v%f${DEFAULT}

