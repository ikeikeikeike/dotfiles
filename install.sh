#!/bin/sh

for i in `\ls -a`
do
  if [ $i = . ] ||
     [ $i = .. ] ||
     [ $i = README ] ||
     [ $i = install.sh ] ||
     [ $i = uninstall.sh ] ||
     [ $i = .git ] ||
     [ $i = .gitconfig ] ||
     [ $i = .gitignore ]; then
    continue
    echo 1
  fi
  \ln -s `pwd`/$i $HOME/$i
done
