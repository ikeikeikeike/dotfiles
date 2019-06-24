export PATH=/usr/local/opt/coreutils/libexec/gnubin:/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:$PATH:/bin:/sbin:/usr/bin:/usr/sbin
export MANPATH=$MANPATH:/usr/local/man:/usr/local/share/man:/usr/share/man
export PATH=/opt/local/sbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export MANPATH=/usr/local/man:/usr/local/share/man:/usr/share/man:$MANPATH

if [ -f $HOME/.zsh_extend/aliases ]; then
  source $HOME/.zsh_extend/aliases
fi

if [ -f $HOME/.adds_aliases ]; then
  source $HOME/.adds_aliases
fi

if [ -f $HOME/.archirc ]; then
  source $HOME/.archirc
fi

if [ -f $HOME/.zsh_extend/colors ]; then
  source $HOME/.zsh_extend/colors
fi

if [ -f $HOME/.zsh_extend/opts ]; then
  source $HOME/.zsh_extend/opts
fi

if [ -f $HOME/.zsh_extend/style ]; then
  source $HOME/.zsh_extend/style
fi

if [ -f $HOME/.zsh_extend/logging ]; then
  source $HOME/.zsh_extend/logging
fi

if [ -f $HOME/.zsh_extend/funcs ]; then
  source $HOME/.zsh_extend/funcs
fi

if [ -f $HOME/.zsh_extend/prefuncs ]; then
  source $HOME/.zsh_extend/prefuncs
fi

if [ -f $HOME/.zsh_extend/prompt ]; then
  source $HOME/.zsh_extend/prompt
fi

if [ -f $HOME/.zsh_extend/plugins ]; then
  source $HOME/.zsh_extend/plugins
fi

if [ -f /usr/local/bin/vault ]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/local/bin/vault vault
fi

if [ -f $HOME/.postzshrc ]; then
  source $HOME/.postzshrc
fi


# for debug
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
