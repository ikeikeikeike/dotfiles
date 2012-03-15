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
  echo "reattach-to-user-namespace -l zsh"
  echo "Note!! Error in Hidden. Error in Hidden."
  # reattach-to-user-namespace -l zsh 2> /dev/null
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
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH

# extra
export PATH=$HOME/bin:$PATH
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
  export LIBRARY_PATH=/opt/local/lib
  export LD_LIBRARY_PATH=/opt/local/lib
  export C_INCLUDE_PATH=/opt/local/include
  export CPLUS_INCLUDE_PATH=/opt/local/include:$HOME/include
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
  export BOOST_ROOT=$HOME/include/boost:/opt/local/include/boost:$BOOST_ROOT
  # default editor
  export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
  # @see python_select
  [[ -s $HOME/.pythonbrew/etc/bashrc ]] || export PYTHON_HOME=/opt/local/Library/Frameworks/Python.framework/Versions/Current
  # move $HOME/.zsh_extends/prefuncs
  # [[ -s $HOME/.pythonbrew/etc/bashrc ]] && export PYTHON_HOME=`cat ~/.pythonbrew/etc/current | sed -e 's@PATH_PYTHONBREW_CURRENT="@@g' | sed -e 's@/bin"@@g'`
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
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case -R '
export LESSOPEN='| src-hilite-lesspipe.sh %s'

# gsutil
export PATH=$PATH:$HOME/lib/gsutil

# ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
export RSENSE_HOME=$HOME/lib/rsense-0.3

# java
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# scala
export REBEL_HOME=/usr/local/share/jrebel
export PATH=$REBEL_HOME/bin:$PATH
export PLAY_HOME=/opt/local/share/java/play-1.2.3
export PATH=$PLAY_HOME:$PATH

# perl
[[ -s $HOME/perl5/perlbrew/bin/perlbrew ]] && source $HOME/perl5/perlbrew/bin/perlbrew

# node /opt/local/bin

### python ###
# if pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
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

# mysettings
source $HOME/.adds_zshenv 2> /dev/null
