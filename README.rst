
ログインシェルはbashでtmux,screen起動後はzshに切り替えて使用しています。

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
  vim -c "BundleInstall" # Error Note: git config --global http.sslVerify false; mkdir -p ~/.vim_plugins/vim_session


Uninstall
::

  uninstall.sh

