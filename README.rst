
Install
::

  install.sh


Python
::

  .startup/python27

vim 7.3
::

  # installed vim 7.3
  sh ~/.startup/vim73
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  vim -c "BundleInstall" # Error Note: git config --global http.sslVerify false
  mkdir -p ~/.vim_plugins/vim_session
  cd ~/.vim/bundle/vimproc/ && make -f make_gcc.mak
  wget 'https://raw.github.com/taku-o/downloads/master/DirDiff/DirDiff_mb.vim'
  mv DirDiff_mb.vim ~/.vim/bundle/DirDiff.vim/plugin/DirDiff.vim


Uninstall
::

  uninstall.sh

