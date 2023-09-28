#!/bin/sh

for i in `\ls -a`
do
  if [ $i = . ] ||
     [ $i = .. ] ||
     [ $i = README ] ||
     [ $i = install.sh ] ||
     [ $i = uninstall.sh ] ||
     [ $i = fusuma ] ||
     [ $i = xremap ] ||
     [ $i = .xkeysnail ] ||
     [ $i = .pycodestyle ] ||
     [ $i = .init.vim ] ||
     [ $i = .git ] ||
     [ $i = .gitignore ]; then
    continue
  fi
  sleep 0.1
  echo "\ln -s `pwd`/$i $HOME/$i"
  \ln -s `pwd`/$i $HOME/$i
done

mkdir -p ~/.config/nvim
ln -s `pwd`/.init.vim ~/.config/nvim/init.vim
ln -s `pwd`/.vim/plugin ~/.config/nvim/plugin
ln -s `pwd`/.vim/ftplugin ~/.config/nvim/ftplugin
ln -s `pwd`/.pycodestyle ~/.config/pycodestyle
ln -s `pwd`/xremap ~/.config/xremap

git submodule init
git submodule update
git submodule foreach git pull origin master
