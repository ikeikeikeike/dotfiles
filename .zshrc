
# Emacsと同じキー操作を行う
bindkey -e

export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000

# 5秒以上かかった処理は詳細表示
REPORTTIME=5

export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    . /opt/local/etc/profile.d/autojump.zsh
fi

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# auto complete compile
autoload -U compinit
compinit

# extra auto complete
#fpath=($fpath $HOME/.zsh_extend/autocomplete)
#autoload -Uz compinit
#compinit

# alias
source $HOME/.zsh_extend/aliases
source $HOME/.adds_aliases 2> /dev/null

# archifile
if [ -f $HOME/.archirc ]; then
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

## エイリアスも補完対象に設定
setopt complete_aliases

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# share history
setopt share_history

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# 履歴をインクリメンタルに追加
setopt inc_append_history

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## コピペの時rpromptを非表示する
setopt transient_rprompt

## 色を使う
setopt prompt_subst

## no beep
setopt nobeep
setopt nolistbeep

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

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# 重複履歴を保存しない
setopt histignorealldups histsavenodups

# 先頭にSPACEを入れると履歴を残さない
# setopt histignorespace

## cd 時に自動で push
setopt auto_pushd
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

## zsh auto title concrift with nginx
DISABLE_AUTO_TITLE=true

## スペルチェック
setopt correct

# 辞書順ではなく数値順でソート
setopt numeric_glob_sort

# rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
#setopt rm_star_silent

# rm_star_silent の逆で、10 秒間反応しなくなり、頭を冷ます時間が与えられる
#setopt rm_star_wait

# for, repeat, select, if, function などで簡略文法が使えるようになる
#setopt short_loops

# デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt single_line_zle

# コマンドラインがどのように展開され実行されたかを表示するようになる debug時にね
# setopt xtrace

# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value


# コマンドライン全てのスペルチェックをする
#setopt correct_all

## cd conf
# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
#cdpath=($HOME)
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#LS_COLORSを設定しておく
if [ -f ~/.dir_colors ]; then
    eval $(dircolors -b ~/.dir_colors)
    #ファイル補完候補に色を付ける
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

## auto complete conf
# 補完候補を ←↓↑→ でも選択出来るようにする
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
#
# _complete
# 普通の補完関数
# _approximate
# ミススペルを訂正した上で補完を行う。
# _match
# *などのグロブによってコマンドを補完できる(例えばvi* と打つとviとかvimとか補完候補が表示される)
# _expand
# グロブや変数の展開を行う。もともとあった展開と比べて、細かい制御が可能
# _history
# 履歴から補完を行う。_history_complete_wordから使われる
# _prefix
# カーソルの位置で補完を行う
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

# コマンドにsudoを付けてもきちんと補完出来るようにする。Ubuntuだと/etc/zsh/zshrcで設定されている。
zstyle ':completion:*:sudo:*' command-path /opt/local/bin /opt/local/sbin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin /Users/ikeda/.cabal/bin /opt/local/share/java/play-1.2.3 /usr/local/share/jrebel/bin /opt/local/bin /opt/local/sbin /Developer/usr/bin/ /opt/local/apache2/bin /opt/local/lib/mysql5/bin /Users/ikeda/bin /Users/ikeda/sbin /Users/ikeda/bin /usr/bin /bin /usr/sbin /sbin /usr/local/bin /usr/X11/bin /Library/Frameworks/Python.framework/Versions/2.7/bin /Users/ikeda/bin /Users/ikeda/lib/gsutil /Users/ikeda/.rvm/bin $HOME/bin $HOME/sbin


#####  functions   #####


# functions
source $HOME/.zsh_extend/funcs

# pre functions
source $HOME/.zsh_extend/prefuncs


### Prompt ###
#
#
# Left prompt
PROMPT=$'\n'$GREEN'${USER}@${HOST}'$CYAN'(${ARCHI}-${DISTRIBUTE}) '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '

# Right prompt  # RPROMPT=%1v%2v%f${DEFAULT}
RPROMPT=${CYAN}%1v%2v%f${DEFAULT}

# For MySQL
export MYSQL_PS1="(\u@\h:\p) [\d] \v - \r:\m\P \n\c> "


##### Pre attaches ###
#
#

# tmux log format is script cmd.
if [ "${TMUX}" != "" ] ; then
  tmux pipe-pane 'cat >> ~/.tmux/`date +%Y-%m-%d`_#S:#I.#P.log'
fi

# if [ "$TERM" = "xterm-color" ]; then
  # preexec() {
    # # see [zsh-workers:13180]
    # # http://www.zsh.org/mla/workers/2000/msg03993.html
    # emulate -L zsh
    # local -a cmd; cmd=(${(z)2})
    # echo -n "^[k$cmd[1]:t^[\\"
  # }
# fi

# post zshrc
if [ -f $HOME/.postzshrc ]; then
  source $HOME/.postzshrc
fi


### Cmmand line stack ###
#
# C-q bind.
#
# http://d.hatena.ne.jp/kei_q/20110308/1299594629
# http://qiita.com/items/1f2c7793944b1f6cc346
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack


### Like a Fish shell coloring. ###
#
# https://github.com/zsh-users/zsh-syntax-highlighting
# Source the script at the end of ~/.zshrc:
#
source ~/.zsh_extend/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### TODO: Next auto-fu.zsh  ###
#
# zsh-syntax-highlightingと競合する
#


### zsh-history-substring-search
#
# https://github.com/zsh-users/zsh-history-substring-search
# This is a clean-room implementation of the Fish shell's
#
# source ~/.zsh_extend/zsh-history-substring-search/zsh-history-substring-search.zsh

# if type zprof > /dev/null 2>&1; then
  # zprof | less
# fi
