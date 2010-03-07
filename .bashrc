# emacs
alias emacs='open -a Emacs.app' 

# no
set nobeep

# historyサイズ
HISTSIZE=100000
SAVEHIST=100000

# 日付を付与
HISTTIMEFORMAT='%Y%m%d %T ';
export HISTTIMEFORMAT

# 重複履歴を無視
export HISTCONTROL=ignoredups

# lsカラーを設定
export LSCOLORS=exGxcxdxcxegedabagacad

# ログは ~/.ssh/agent.log に残される。
export SSH_AGENT_LOG=$HOME/.ssh/agent.log

export LANG=ja_JP.UTF-8
export MANPATH=/usr/local/man:/usr/share/man

# alias
alias screen='screen -U'
alias ls='ls -GFh'
alias vi='vim'
alias less='less -M'
alias grep='grep --color'
alias cp='cp -iv'
alias mv='mv -iv'
alias mysql='mysql5'
# crontab用
alias crontab="EDITOR=/usr/local/bin/vi crontab"

## less関係
# manコマンドのときlessを使う
export PAGER=less
# lessのステータス行
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'


