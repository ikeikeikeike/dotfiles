#!/bin/sh

WORK=$HOME/src/vim-kaoriya
cd $WORK
git checkout master
git pull
git submodule update
cd $WORK/vim
git checkout master
git pull
ver=`git tag | tail -n 1`
git checkout -b $ver
git config guilt.patchesdir $WORK/patches
cp -rf $WORK/patches/master $WORK/patches/$ver
guilt init
cd $WORK/vim
guilt push -a
cd $WORK/vim/src
make autoconf
cd $WORK/vim

LIBS="-lmigemo" ./configure \
--prefix=/usr/local \
--with-features=huge \
--enable-gui=gtk2 \
--enable-multibyte \
--enable-perlinterp \
--enable-pythoninterp \
--enable-python3interp \
--enable-tclinterp \
--enable-rubyinterp \
--enable-luainterp \
--with-luajit \
--enable-gpm \
--enable-cscope \
--enable-fontset \
--enable-migemo \
--enable-fail-if-missing

make
sudo make install
make distclean
cd $WORK/vim
git checkout -- src/auto/configure
git checkout master
git branch -D $ver
git branch -D guilt/$ver
cd ../patches
rm -rf $ver
cd ..
git submodule update
cd