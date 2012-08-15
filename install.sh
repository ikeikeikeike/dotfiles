#!/bin/sh

for i in `\ls -a`
do
  if [ $i = . ] ||
     [ $i = .. ] ||
     [ $i = README ] ||
     [ $i = install.sh ] ||
     [ $i = uninstall.sh ] ||
     [ $i = .git ] ||
     [ $i = .gitignore ]; then
    continue
  fi
  sleep 0.1
  echo "\ln -s `pwd`/$i $HOME/$i"
  \ln -s `pwd`/$i $HOME/$i
done

git submodule init
git submodule update
git submodule foreach git pull origin master
