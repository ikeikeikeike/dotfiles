
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

# alia
alias top='htop'
alias emacs='open -a /Applications/MacPorts/Emacs.app'
#alias emacs_sudo='sudo open -a /Applications/MacPorts/Emacs.app'
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/Vim "$@"'
alias mvi='env LANG=ja_JP.UTF-8 /Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/MacVim "$@"'
alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/MacVim "$@"'
alias py=python
alias screen='screen -U'
alias ls='ls -FGh'
alias vi='vim'
alias less='less -MX'
alias grep='grep --color=always '
alias cp='cp -iv'
alias mv='mv -iv'
alias mysql='mysql5'
alias gd='source $HOME/.zsh_extend/gd/gd.sh'
#alias updatedb='$HOME/.zsh_extend/updatedb/updatedb.sh &'
alias updatedb=' sudo LC_ALL=C gupdatedb '
alias locate='glocate -i '
alias winscp='open /Users/ikeda/Library/Application\ Support/MikuInstaller/prefix/default/drive_c/Program\ Files/WinSCP/WinSCP.exe'

# rsync
alias rsync_gigacast_dev='source $HOME/script/shell/rsync_gigacast_dev'
alias rsync_gigacast_v14_dev='source $HOME/script/shell/rsync_gigacast_v14_dev'
alias rsync_gigacast_plcdn='source $HOME/script/shell/rsync_gigacast_plcdn'
alias rsync_gigacast_aidia='source $HOME/script/shell/rsync_gigacast_aidia'
alias rsync_gigacast_gaitame='source $HOME/script/shell/rsync_gigacast_gaitame'
alias rsync_gigacast_jikiden='source $HOME/script/shell/rsync_gigacast_jikiden'
alias rsync_gigacast_local_dev='source $HOME/script/shell/rsync_gigacast_local_dev'

#alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'

# for crontab
alias crontab="EDITOR=/usr/local/bin/vi crontab"

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

# disp git or hg branch name
function output_branch {
  _git_output=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
  _hg_output=`hg branch 2> /dev/null`

  if [ "$_git_output" ]; then
    git_output="git:$_git_output"
  fi

  if [ "$_hg_output" ]; then
    hg_output="hg:$_hg_output"
  fi

  if [ $_git_output ] || [ $_hg_output ]; then
    echo "[$git_output$hg_output]"
  fi
}

## prompt
PROMPT=$'\n'$GREEN'${USER}@${HOST}'$fg_cyan'(${ARCHI})'$fg_brown'$(output_branch) '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '

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

#################################################################
#
#
#################################################################

# functionの設定
function history-all { history -E 1 }

# cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls && ls -alt;
}

# settei wo kaiteinai
#function chpwd(){
#	_reg_pwd_screennum
#}

# ssh screen name
function ssh_screen(){
    server=?${$#}
    screen -t ${@}${server} ssh ${@}
}
function ssh_tmux(){
    server=?${$#}
    tmux new-window -n ${@}${server} "ssh ${@}"
}

# tmux screen 判別
if [ x$TERM = xscreen ]; then
    if [ -e $TMUX ]; then
      	alias ssh=ssh_screen
    else
      	alias ssh=ssh_tmux
    fi
fi

#source ~/.zsh_extend/cdd
source $HOME/.zsh_extend/emacs/isemacs.sh
#source $HOME/.zsh_extend/gd/gd.sh


# cdhist
#source $HOME/.zsh_extend/cdhist/cdhist.sh


# history
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    # 追加したくないコマンドを列挙する
    # この場合、以下のいずれかを満たすコマンドラインがヒストリに追加されなくなる。
    # * 4文字以下である
    # * コマンド名の部分が l, ls, la, ll のいずれかである
    # * コマンド名の部分が c, cd のいずれかである
    # * コマンド名の部分が m, man のいずれかである

    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (sl)
#	&& ${cmd} != (gd)
        && ${cmd} != (m|man)
    ]]
}

export_grep_color(){
    x=$GREP_COLOR;
    export GREP_COLOR=$1;
    grep --color=always $2;
    export GREP_COLOR=$x
}
#alias grep=' export_grep_color "01;31" $1' # red
alias grep1=' export_grep_color "01;32" $1' # green
alias grep2=' export_grep_color "01;33" $1' # yellow
alias grep3=' export_grep_color "01;34" $1' # blue
alias grep4=' export_grep_color "01;35" $1' # purple
alias grep5=' export_grep_color "01;36" $1' # 水色
alias grep6=' export_grep_color "01;37" $1' # white

# 解凍
function extract (){
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   echo "tar xvjf $1"   && tar xvjf $1    ;;
          *.tar.gz)    echo "tar xvzf $1"   && tar xvzf $1    ;;
          *.tar.xz)    echo "tar xvJf $1"   && tar xvJf $1    ;;
          *.bz2)       echo "bunzip2 $1"    && bunzip2 $1     ;;
          *.rar)       echo "unrar x $1"    && unrar x $1     ;;
          *.gz)        echo "gunzip $1"     && gunzip $1      ;;
          *.tar)       echo "tar xvf $1"    && tar xvf $1     ;;
          *.tbz2)      echo "tar xvjf $1"   && tar xvjf $1    ;;
          *.tgz)       echo "tar xvzf $1"   && tar xvzf $1    ;;
          *.zip)       echo "unzip $1"      && unzip $1       ;;
          *.Z)         echo "uncompress $1" && uncompress $1  ;;
          *.7z)        echo "7z x $1"       && 7z x $1        ;;
          *.lzma)      echo "lzma -dv $1"   && lzma -dv $1    ;;
          *.xz)        echo "xz -dv $1"     && xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# growlnotify exevute  30 second later
local COMMAND=""
local COMMAND_TIME=""
precmd() {
    if [ "$COMMAND_TIME" -ne "0" ] ; then
        local d=`date +%s`
        d=`expr $d - $COMMAND_TIME`
        if [ "$d" -ge "30" ] ; then
             COMMAND="$COMMAND "
             growlnotify -t "${${(s: :)COMMAND}[1]}" -m "$COMMAND"
        fi
    fi
    COMMAND="0"
    COMMAND_TIME="0"
}

preexec () {
    COMMAND="${1}"
    COMMAND_TIME=`date +%s`
}

