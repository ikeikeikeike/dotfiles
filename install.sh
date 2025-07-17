#!/bin/sh

for i in `\ls -a`
do
  if [ $i = . ] ||
     [ $i = .. ] ||
     [ $i = README ] ||
     [ $i = install.sh ] ||
     [ $i = uninstall.sh ] ||
     [ $i = fusuma ] ||
     [ $i = .pycodestyle ] ||
     [ $i = .init.vim ] ||
     [ $i = .config ] ||
     [ $i = .git ] ||
     [ $i = .gitignore ]; then
    continue
  fi
  sleep 0.1
  echo "\ln -s `pwd`/$i $HOME/$i"
  \ln -s `pwd`/$i $HOME/$i
done

# Create config directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/lua

# Neovim configuration
ln -s `pwd`/.init.vim ~/.config/nvim/init.vim
ln -s `pwd`/.vim/plugin ~/.config/nvim/plugin
ln -s `pwd`/.vim/ftplugin ~/.config/nvim/ftplugin
ln -s `pwd`/.config/nvim/lua/lazy-config.lua ~/.config/nvim/lua/lazy-config.lua

# Other configurations
ln -s `pwd`/.pycodestyle ~/.config/pycodestyle
ln -s `pwd`/fusuma ~/.config/fusuma

# Clean up old dein cache if exists
if [ -d ~/.cache/dein ]; then
  echo "Removing old dein cache..."
  rm -rf ~/.cache/dein
fi

git submodule init
git submodule update
git submodule foreach git pull origin master
