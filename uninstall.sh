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
  elif [ -L $HOME/$i ]; then
    sleep 0.1
    echo "\unlink $HOME/$i"
    \rm $HOME/$i
  fi
done
