# for debug
# zmodload zsh/zprof && zprof

# Archi & Distribution
if [ -x /usr/bin/uname ] || [ -x /bin/uname ]; then
  case "`uname -sr`" in
    FreeBSD*);    export ARCHI="freebsd" ;;
    Linux*);      export ARCHI="linux"   ;;
    CYGWIN*);     export ARCHI="cygwin"  ;;
    IRIX*);       export ARCHI="irix"    ;;
    OSF1*);       export ARCHI="osf1"    ;;
    Darwin*);     export ARCHI="darwin"  ;;
    *);           export ARCHI="dummy"   ;;
  esac
  if [ -f /etc/redhat-release ]; then
    case "`cat /etc/redhat-release`" in
      *CentOS*);  export DISTRIBUTE="centos" ;;
      *Red*);     export DISTRIBUTE="redhat" ;;
      *);         export DISTRIBUTE="dummy" ;;
    esac
  else
    case "`uname -v`" in
      *-Ubuntu*); export DISTRIBUTE="ubuntu" ;;
      *);         export DISTRIBUTE="dummy"  ;;
    esac
  fi
else
  export ARCHI="dummy"
  export DISTRIBUTE="dummy"
fi

if [ ! $reattach_to_user_namespace ] && [ $ARCHI = darwin ]; then
  export reattach_to_user_namespace=1
fi

# HOST
if [ -x /bin/hostname ]; then
  export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`

######## path
#
#
#
typeset -gx -U PATH
typeset -gx -U FPATH
#
#
#

if [ $ARCHI = darwin ]; then
  export LANG=ja_JP.UTF-8
  export LC_ALL=ja_JP.UTF-8

  export MANPATH=/Developer/usr/share/man:$MANPATH
  export MANPATH=/opt/local/man:$MANPATH
  export PATH=/Developer/usr/bin/:/opt/local/lib/mysql5/bin:$PATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export PATH=/usr/local/luajit/bin/:$PATH
  export BOOST_ROOT=$HOME/include/boost:/opt/local/include/boost:$BOOST_ROOT
  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

  export MANPATH=/usr/share/man:/usr/X11/man:$MANPATH
  export PATH=$PATH:$HOME/bin:$HOME/sbin
  export MANPATH=$MANPATH:$HOME/share/man
  export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:$PATH:/bin:/sbin:/usr/bin:/usr/sbin
  export MANPATH=$MANPATH:/usr/local/man:/usr/local/share/man:/usr/share/man
  export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
  export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  export PATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
  export PATH=/usr/local/opt/gettext/bin:$PATH

  export DISPLAY=:0.0
  export MAKEOPTS="-j4"

  export C_INCLUDE_PATH=/opt/local/include:$C_INCLUDE_PATH
  export CPLUS_INCLUDE_PATH=/opt/local/include:$HOME/include:$CPLUS_INCLUDE_PATH
  unset DYLD_LIBRARY_PATH
  unset LD_LIBRARY_PATH
fi
if [ $ARCHI = linux ]; then
  export LANG=en_US.UTF-8
  export EDITOR="vim"
  export MAKEOPTS="-j12"
fi
if [ $DISTRIBUTE = centos ]; then
  export LC_CTYPE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
fi

export PATH=$HOME/.local/bin:$HOME/bin:$HOME/sbin:/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=$HOME/share/man:/usr/local/man:/usr/local/share/man:/usr/X11/man:/usr/share/man:$MANPATH


# begin cofigures
#
#
# use the same Emacs keybind
bindkey -e
limit coredumpsize 10240000

# Report show detail a processing if passed over 5 seconds.
REPORTTIME=5

# autoload
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# less
export LESSCHARSET=utf-8
export PAGER='less'
export LESS='--tabs=4 -q --no-init --LONG-PROMPT --ignore-case -R '
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# Docker
# export DOCKER_HOST=tcp://localhost:4243

# gsutil
export PATH=$PATH:$HOME/lib/gsutil


### zsh

export FPATH=~/.zsh-completions_ext:$FPATH


### PHP ###

if [[ -s "$HOME/.phpenv/bin/phpenv" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
fi


### ruby ###

if [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
    # This loads rbenv
    export RBENV_ROOT=$HOME/.rbenv
    export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"
    export RUBY_EXE=`rbenv which ruby`
elif [[ -s "/usr/local/bin/rbenv" ]]; then
    export RBENV_ROOT=/usr/local/opt/rbenv
fi

### perl ###

if [[ -s $HOME/perl5/perlbrew/bin/perlbrew ]]; then

    source $HOME/perl5/perlbrew/bin/perlbrew

elif [[ -s $HOME/.plenv/bin/plenv ]]; then

    export PLENV_ROOT=$HOME/.plenv
    export PATH=$PLENV_ROOT/bin:$PATH
    eval "$(plenv init -)"

fi


### java ###

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export PATH=${JAVA_HOME}/bin:${PATH}
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias jdb='jdb -J-Dfile.encoding=UTF-8'

if [[ -s "/usr/libexec/java_home" ]]; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export JAVA=$JAVA_HOME/bin
    export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk
    alias javac='javac -J-Dfile.encoding=UTF-8'
    alias java='java -Dfile.encoding=UTF-8'
    alias jdb='jdb -J-Dfile.encoding=UTF-8'
fi

### scala ###

# export REBEL_HOME=/usr/local/share/jrebel
# export PATH=$REBEL_HOME/bin:$PATH
# export PLAY_HOME=/usr/local/share/play
# export PATH=$PLAY_HOME:$PATH
# alias sbt='JAVA_OPT="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2048M -Xmx2048M -Xmx1024M -Xss128M" sbt'
export SBT_OPTS="-Xmx1024m -Xms512m -Xss128m -Dfile.encoding=UTF8"
# export SBT_OPTS="-Xmx4096m -Xms2048m -Xss256m -Dfile.encoding=UTF8"

## #nodejs ###

# if [[ -f ~/.nvm/nvm.sh ]]; then
#   source ~/.nvm/nvm.sh
# fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_OPTIONS="--max-old-space-size=1024 --max_old_space_size=1024"

### haskell ###

export CABAL_HOME=~/.cabal
export PATH=$CABAL_HOME/bin:$PATH
export MANPATH=$CABAL_HOME/share:$MANPATH


### golang ###
#
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
    source "$HOME/.gvm/scripts/gvm"
fi

### Elixir
if [[ -s "$HOME/.exenv/bin" ]]; then
    export PATH="$HOME/.exenv/bin:$PATH"; eval "$(exenv init -)"
fi


### Dart Flutter

export PATH=$PATH:/usr/lib/dart/bin
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/sdk/flutter/bin


### Rust

if [[ -s "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi


### python ###

# if pythonbrew < not use
#[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

# path
export PATH=$PYTHON_HOME/bin:$PATH
export MANPATH=$PYTHON_HOME/share/man:$MANPATH

# python settings
export PYTHONIOENCODING=UTF-8

# Import virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# virtualenvwrapper
source `which virtualenvwrapper.sh` 2> /dev/null

## extra virtualenv
# require
export PIP_REQUIRE_VIRTUALENV=false
# require distribure
export VIRTUALENV_USE_DISTRIBUTE=true
# cached download package
export PIP_DOWNLOAD_CACHE=$HOME/.pip_cache
# package in virtualenv sandbox.
export PIP_RESPECT_VIRTUALENV=true
# Tell pip to create its virtualenvs in $WORKON_HOME.
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PYTHONSTARTUP=$HOME/.pythonrc.py
export VIRTUAL_ENV_PYTHON_LIB=$VIRTUAL_ENV/lib

# if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
#   source "${VIRTUAL_ENV}/bin/activate"
# fi

### kubernetest k8s

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

### extra ###

# zsh autojump
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    export FPATH="/opt/local/share/zsh/site-functions:$FPATH"
    . /opt/local/etc/profile.d/autojump.zsh
fi
if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
    export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
    . /opt/local/etc/profile.d/autojump.sh
fi
if [ -f /usr/share/autojump/autojump.zsh ]; then
    export FPATH="/usr/local/share/zsh/site-functions:$FPATH"
    . /usr/share/autojump/autojump.zsh
fi
if [[ -s /usr/local/bin/brew ]]; then
    if [[ -s $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh ]]; then
        . $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh
    fi
fi
if [[ -s /root/.autojump/etc/profile.d/autojump.sh ]]; then
    source /root/.autojump/etc/profile.d/autojump.sh
fi

# mysettings
source $HOME/.adds_zshenv 2> /dev/null

export ODBCINI=/etc/odbc.ini
export ODBCSYSINI=/etc
export FREETDSCONF=/etc/freetds.conf

if [ -x "$(command -v direnv)" ]; then
    eval "$(direnv hook zsh)"
fi

export ASDF_DIR="$HOME/.asdf"
[ -s "$ASDF_DIR/asdf.sh" ]     && \. "$ASDF_DIR/asdf.sh"  # This loads
[ -s "$ASDF_DIR/completions" ] && fpath=(${ASDF_DIR}/completions $fpath)  # append completions to fpath

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# zplug: # git clone https://github.com/zplug/zplug $ZPLUG_HOME
export ZPLUG_HOME=~/.zplug

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000000
SAVEHIST=10000000


# end
#
#
#
#
