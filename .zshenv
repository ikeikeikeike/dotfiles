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
  case "`cat /etc/redhat-release 2> /dev/null` " in
    *CentOS*); export DISTRIBUTE="centos" ;;
    *RedHat*); export DISTRIBUTE="redhat" ;;
    *);        export DISTRIBUTE="dummy" ;;
  esac
else
  export ARCHI="dummy"
  export DISTRIBUTE="dummy"
fi

# HOST
if [ -x /bin/hostname ]; then
  export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`


if [ $ARCHI = darwin ]; then
  # encode
  export LANG=ja_JP.UTF-8
  # MacPorts Installer addition on 2010-02-14_at_19:14:58: adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/man:$MANPATH
  export DISPLAY=:0.0
  # Finished adapting your PATH environment variable for use with MacPorts.
  export PATH=/Developer/usr/bin/:/opt/local/apache2/bin:/opt/local/lib/mysql5/bin:$PATH
  export MANPATH=/Developer/usr/share/man:$MANPATH
  # extends
  export LIBRARY_PATH=/opt/local/lib
  export LD_LIBRARY_PATH=/opt/local/lib
  export C_INCLUDE_PATH=/opt/local/include
  export CPLUS_INCLUDE_PATH=/opt/local/include
  export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib
  # default editor
  export EDITOR=/Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/Vim
  # @see python_select
  export PYTHON_HOME=/opt/local/Library/Frameworks/Python.framework/Versions/Current
fi
if [ $ARCHI = linux ]; then
  # encode
  export LANG=en_US.UTF-8
  # default editor
  export EDITOR="vim"
fi

# extra
export MANPATH=/usr/share/man:/usr/X11/man:$MANPATH

# extra
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:$MANPATH

# extra
export PATH=$HOME/bin:$PATH

# emacs view setting
if [ "$SHELL" = "/bin/bash" ];then
    export TERM=xterm-color
else
    export TERM=screen
fi

# less utf8
export LESSCHARSET=utf-8

# ruby
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# java
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# scala
export REBEL_HOME=/usr/local/share/jrebel
export PATH=$REBEL_HOME/bin:$PATH

### python ###
export PATH=$PYTHON_HOME/bin:$PATH
export MANPATH=$PYTHON_HOME/share/man:$MANPATH

# python settings
export PYTHONIOENCODING=UTF-8

# Import virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
# virtualenvwrapper
if [ -f `\which virtualenvwrapper.sh` ]; then
  source virtualenvwrapper.sh
fi

## extra virtualenv
# require
export PIP_REQUIRE_VIRTUALENV=true
# require distribure
export VIRTUALENV_USE_DISTRIBUTE=true
# cached download package
export PIP_DOWNLOAD_CACHE=$HOME/.pip_cache
# package in virtualenv sandbox.
export PIP_RESPECT_VIRTUALENV=true
#export PYTHONSTARTUP=$HOME/.pythonrc.py

