# zmodload zsh/zprof

# ARCHI & distribute
if [ -x /usr/bin/uname ] || [ -x /bin/uname ]; then
  case "`uname -sr`" in
    FreeBSD*); export ARCHI="freebsd" ;;
    Linux*);   export ARCHI="linux"   ;;
    CYGWIN*);  export ARCHI="cygwin"  ;;
    IRIX*);    export ARCHI="irix"    ;;
    OSF1*);    export ARCHI="osf1"    ;;
    Darwin*);  export ARCHI="darwin"  ;;
    *);        export ARCHI="dummy"   ;;
  esac
  case "`uname -v`" in
    *-Ubuntu*); export DISTRIBUTE="ubuntu" ;;
    *);         export DISTRIBUTE="dummy"  ;;
  esac
  case "`cat /etc/redhat-release 2> /dev/null`" in
    *CentOS*); export DISTRIBUTE="centos" ;;
    *Red*);    export DISTRIBUTE="redhat" ;;
    *);        export DISTRIBUTE="dummy" ;;
  esac
else
  export ARCHI="dummy"
  export DISTRIBUTE="dummy"
fi

# ahawwwwwwwww
if [ ! $reattach_to_user_namespace ] && [ $ARCHI = darwin ]; then
  export reattach_to_user_namespace=1
  # echo "reattach-to-user-namespace -l zsh"
  # echo "Note!! Error in Hidden. Error in Hidden."
  # reattach-to-user-namespace -l zsh 2> /dev/null
  # $HOME/bin/reattach-to-user-namespace -l zsh 2> /dev/null
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
export PATH=$HOME/bin:$HOME/sbin:$PATH
export MANPATH=$HOME/share/man:$MANPATH

if [ $ARCHI = darwin ]; then
  # encode
  export LANG=ja_JP.UTF-8
  # Finished adapting your PATH environment variable for use with MacPorts.
  export PATH=/Developer/usr/bin/:/opt/local/apache2/bin:/opt/local/lib/mysql5/bin:$PATH
  export MANPATH=/Developer/usr/share/man:$MANPATH
  # MacPorts Installer addition on 2010-02-14_at_19:14:58: adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/man:$MANPATH
  export DISPLAY=:0.0
  # extends
  
  # dyld: DYLD_ environment variables being ignored because main executable (/usr/bin/sudo) is setuid or setgid
  # export LIBRARY_PATH=/opt/local/lib
  # export LD_LIBRARY_PATH=/opt/local/lib
  # export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib

  export C_INCLUDE_PATH=/opt/local/include
  export CPLUS_INCLUDE_PATH=/opt/local/include:$HOME/include
  export BOOST_ROOT=$HOME/include/boost:/opt/local/include/boost:$BOOST_ROOT
  # default editor
  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
  # @see python_select
  [[ -s $HOME/.pythonbrew/etc/bashrc ]] || export PYTHON_HOME=/opt/local/Library/Frameworks/Python.framework/Versions/Current
  # move $HOME/.zsh_extends/prefuncs
  # [[ -s $HOME/.pythonbrew/etc/bashrc ]] && export PYTHON_HOME=`cat ~/.pythonbrew/etc/current | sed -e 's@PATH_PYTHONBREW_CURRENT="@@g' | sed -e 's@/bin"@@g'`

  # make setting
  export MAKEOPTS="-j3"

  # TODO: bugfix
  unset DYLD_LIBRARY_PATH
  unset LD_LIBRARY_PATH
fi
if [ $ARCHI = linux ]; then
  # encode
  export LANG=en_US.UTF-8
  # default editor
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
export RSENSE_HOME=$HOME/lib/rsense-0.3

### perl ###

if [[ -s $HOME/perl5/perlbrew/bin/perlbrew ]]; then

    source $HOME/perl5/perlbrew/bin/perlbrew

elif [[ -s $HOME/.plenv/bin/plenv ]]; then

    export PLENV_ROOT=$HOME/.plenv
    export PATH=$PLENV_ROOT/bin:$PATH
    eval "$(plenv init -)"

fi

### java ###

export JAVA_HOME="/Library/Internet\ Plug-ins/JavaAppletPlugin.plugin/Contents/Home"
export JAVA=$JAVA_HOME/bin
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias jdb='jdb -J-Dfile.encoding=UTF-8'

### scala ###

export REBEL_HOME=/usr/local/share/jrebel
export PATH=$REBEL_HOME/bin:$PATH
export PLAY_HOME=/usr/local/share/play
export PATH=$PLAY_HOME:$PATH
# alias sbt='JAVA_OPT="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256m -Xmx512M -Xss2M" sbt'

### nodejs ###

if [[ -f ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh
fi

### haskell ###

export CABAL_HOME=~/.cabal
export PATH=$CABAL_HOME/bin:$PATH
export MANPATH=$CABAL_HOME/share:$MANPATH


### golang ###
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"


### Elixir
[[ -s "$HOME/.exenv/bin" ]] && export PATH="$HOME/.exenv/bin:$PATH"; eval "$(exenv init -)"


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

### extra ###

# zsh autojump
export FPATH="$FPATH:/opt/local/share/zsh/site-functions/"
if [ -f /opt/local/etc/profile.d/autojump.zsh ]; then
    . /opt/local/etc/profile.d/autojump.zsh
fi
[[ -s $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh ]] && . $(/usr/local/bin/brew --prefix)/etc/profile.d/autojump.sh

# mysettings
source $HOME/.adds_zshenv 2> /dev/null

export ODBCINI=/etc/odbc.ini
export ODBCSYSINI=/etc
export FREETDSCONF=/etc/freetds.conf
