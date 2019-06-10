
# use the same Emacs keybind
bindkey -e

export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH


# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000000
SAVEHIST=10000000

# Report show detail a processing if passed over 5 seconds.
REPORTTIME=5

export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    . /opt/local/etc/profile.d/autojump.zsh
fi

# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# auto complete compile
# autoload -U compinit && compinit
# fpath=(/opt/local/share/zsh/5.2/functions ${fpath})
autoload -Uz compinit && compinit -u

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


setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt hist_beep                 # Beep when accessing nonexistent history.
setopt append_history            # If this is set, zsh sessions will append their history list to the history file
setopt complete_aliases          # Prevents aliases on the command line from being internally substituted before completion is attempted.
setopt hist_expand
setopt transient_rprompt
setopt prompt_subst
setopt nobeep
setopt nolistbeep
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt print_eight_bit
setopt histignorealldups histsavenodups
# setopt histignorespace
setopt auto_pushd
setopt autopushd
setopt pushd_ignore_dups
setopt mark_dirs
setopt auto_menu
setopt equals
setopt auto_menu
setopt magic_equal_subst
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt numeric_glob_sort
#setopt rm_star_silent
#setopt rm_star_wait
#setopt short_loops
#setopt single_line_zle
# setopt xtrace
setopt print_exit_value
#setopt correct_all
limit coredumpsize 10240000
unsetopt promptcr
DISABLE_AUTO_TITLE=true
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd

if [ -f ~/.dir_colors ]; then
    eval $(dircolors -b ~/.dir_colors)
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

## auto complete conf
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
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
# source ~/.zsh_extend/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### TODO: Next auto-fu.zsh  ###
#
# confrict zsh-syntax-highlighting
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


