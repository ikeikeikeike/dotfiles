# macports
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#export DISPLAY=:0.0

export LANG=ja_JP.UTF-8
export MANPATH=/usr/local/man:/usr/share/man
#export SHELL=/usr/local/bin/zsh 
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000

# alias
alias emacs='open -a Emacs.app'
alias screen='screen -U'
alias ls='ls -Gfh'
alias vi='vim'
alias less='less -M'
alias grep='grep --color'
alias cp='cp -iv'
alias mv='mv -iv'
alias mysql='mysql5'
# for crontab
alias crontab="EDITOR=/usr/local/bin/vi crontab"

## prompt
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$'\n'$GREEN'${USER}@${HOSTNAME} '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '

## color
#local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
#local GREEN=$'%{^[[1;32m%}'$
#local YELLOW=$'%{^[[1;33m%}'$
#local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$

# less
export PAGER='less'
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'

# sources
source ~/.zsh_extend/cdd

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

# settei wo kaiteinai
#function chpwd(){
#	_reg_pwd_screennum
#}

# auto complete compile
autoload -U compinit
compinit

# ssh screen name
function ssh_screen(){
	#eval 
	server=?${$#}
	screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
	alias ssh=ssh_screen
fi

## cd conf
# カレントディレクトリ中にサブディレクトリが無い場合に cd が検索するディレクトリのリスト
cdpath=($HOME)
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd
#LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls;
}

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


