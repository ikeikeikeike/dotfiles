# zmodload zsh/zprof

# ARCHI & distribute
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
  if [ -x /etc/redhat-release ]; then
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

############# path
# extra
export MANPATH=/usr/share/man:/usr/X11/man:$MANPATH

# extra
export PATH=$PATH:$HOME/bin:$HOME/sbin
export MANPATH=$MANPATH:$HOME/share/man


if [ $ARCHI = darwin ]; then
  export LANG=ja_JP.UTF-8
  export LC_ALL=ja_JP.UTF-8

  # Finished adapting your PATH environment variable for use with MacPorts.
  export PATH=/Developer/usr/bin:/opt/local/apache2/bin:/opt/local/lib/mysql5/bin:/opt/local/lib/mysql57/bin:$PATH
  export MANPATH=/Developer/usr/share/man:$MANPATH
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/man:$MANPATH
  export DISPLAY=:0.0
  # extends

  # dyld: DYLD_ environment variables being ignored because main executable (/usr/bin/sudo) is setuid or setgid
  # export LIBRARY_PATH=/opt/local/lib
  # export LD_LIBRARY_PATH=/opt/local/lib
  # export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib

  export PATH="/usr/local/luajit/bin/:$PATH"
  export C_INCLUDE_PATH=/opt/local/include
  export CPLUS_INCLUDE_PATH=/opt/local/include:$HOME/include
  export BOOST_ROOT=$HOME/include/boost:/opt/local/include/boost:$BOOST_ROOT
  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
  [[ -s $HOME/.pythonbrew/etc/bashrc ]] || export PYTHON_HOME=/opt/local/Library/Frameworks/Python.framework/Versions/Current

  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

  # make setting
  export MAKEOPTS="-j3"

  unset DYLD_LIBRARY_PATH
  unset LD_LIBRARY_PATH
fi
if [ $ARCHI = linux ]; then
  export LANG=en_US.UTF-8
  export EDITOR="vim"
fi

# emacs view setting
# if [ "$SHELL" = "/bin/bash" ];then
    # export TERM=xterm-256color
    # # export TERM=xterm-color
# else
    # export TERM=screen
    # # export TERM=xterm-256color
# fi

# less
export LESSCHARSET=utf-8
export PAGER='less'
export LESS='--tabs=4 -q --no-init --LONG-PROMPT --ignore-case -R '
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# Docker
export DOCKER_HOST=tcp://localhost:4243

# gsutil
export PATH=$PATH:$HOME/lib/gsutil

### zsh
fpath=(~/.zsh-completions $fpath)
fpath=(~/.zsh-completions_ext $fpath)

### PHP ###

if [[ -s "$HOME/.phpenv/bin/phpenv" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
    # eval "$(rbenv init - zsh)"
    # exec $SHELL -l
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

elif [[ -s "$HOME/.rvm/scripts/rvm" ]]; then

    # This loads RVM into a shell session.
    # source $HOME/.rvm/scripts/rvm

elif [[ -s /usr/share/ruby-rvm/scripts/rvm ]]; then

    # This loads RVM into a shell session.

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

# export JAVA_HOME=`/usr/libexec/java_home -v 11.0`
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
# export SBT_OPTS="-Xmx2048m -Xms1024m -Xss128m -Dfile.encoding=UTF8"
export SBT_OPTS="-Xmx4096m -Xms2048m -Xss256m -Dfile.encoding=UTF8"

## #nodejs ###

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
fi

### haskell ###

export CABAL_HOME=~/.cabal
export PATH=$CABAL_HOME/bin:$PATH
export MANPATH=$CABAL_HOME/share:$MANPATH


### golang ###
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
    source "$HOME/.gvm/scripts/gvm"
fi

eval "$(direnv hook zsh)" 2> /dev/null

### Elixir
if [[ -s "$HOME/.exenv/bin" ]]; then
    export PATH="$HOME/.exenv/bin:$PATH"; eval "$(exenv init -)"
fi


if [[ -s ~/.nvm/nvm.sh ]]; then
      source ~/.nvm/nvm.sh
fi



if [[ -s ~/.nvm/nvm.sh ]]; then
      source ~/.nvm/nvm.sh
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
#if [ -f `\which virtualenvwrapper.sh 2> /dev/null` ]; then
  source virtualenvwrapper.sh 2> /dev/null
#fi

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

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

### flutter

export PATH="$PATH:/usr/local/flutter/bin"

### extra ###

# zsh autojump
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
    . /opt/local/etc/profile.d/autojump.zsh
fi
if [ -f /opt/local/etc/profile.d/autojump.sh ]; then
    . /opt/local/etc/profile.d/autojump.sh
fi
if [ -f /usr/share/autojump/autojump.zsh ]; then
    export FPATH="$FPATH:/usr/local/share/zsh/site-functions/"
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

export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"

if [ -x "$(command -v direnv)" ]; then
    eval "$(direnv hook zsh)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
