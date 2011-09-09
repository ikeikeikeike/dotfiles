export LANG=ja_JP.UTF-8

##
##

# MacPorts Installer addition on 2010-02-14_at_19:14:58: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH

# extra
export PATH=/Developer/usr/bin/:/opt/local/apache2/bin:/opt/local/lib/mysql5/bin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/X11/man:/Developer/usr/share/man:$MANPATH

# extra
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# extra
export PATH=$HOME/bin:$PATH

# extends
export LIBRARY_PATH=/opt/local/lib
export LD_LIBRARY_PATH=/opt/local/lib
export C_INCLUDE_PATH=/opt/local/include
export CPLUS_INCLUDE_PATH=/opt/local/include
export DYLD_FALLBACK_LIBRARY_PATH=/opt/local/lib

# default editor
#export EDITOR="vim"
export EDITOR=/Applications/MacVim-7_3-53/MacVim.app/Contents/MacOS/Vim

# Finished adapting your PATH environment variable for use with MacPorts.

export DISPLAY=:0.0

# emacs view setting
if [ "$SHELL" = "/bin/bash" ];then
    export TERM=xterm-color
else
    export TERM=screen
fi

# less utf8
export LESSCHARSET=utf-8

# ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# java
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# scala
export REBEL_HOME=/usr/local/share/jrebel
export PATH=$REBEL_HOME/bin:$PATH

### python ###

# @see python_select
PYTHON_HOME=/opt/local/Library/Frameworks/Python.framework/Versions/Current
export PATH=$PYTHON_HOME/bin:$PATH
export MANPATH=$PYTHON_HOME/share/man:$MANPATH

# python settings
export PYTHONIOENCODING=UTF-8

# Import virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
#if [ -f /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin/virtualenvwrapper_bashrc ]; then
# source virtualenvwrapper_bashrc
#fi
if [ -f /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin/virtualenvwrapper.sh ]; then
    source virtualenvwrapper.sh
fi

# extra virtualenv
export PIP_REQUIRE_VIRTUALENV=true
export VIRTUALENV_USE_DISTRIBUTE=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip_cache
#export PYTHONSTARTUP=$HOME/.pythonrc.py






