#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# simple simple*2 createtags-ruby
# ===================================
# github: https://github.com/ikeikeikeike/home/tree/develop/bin

# .. code-block:: bash

# **Usage**

# add virtualenv packages (default django) ::

    # $ createtags-ruby -p fluentd mongo

# add standard packages ::

    # $ createtags-ruby -s SocketServer commands

# not include the virtualenv ::

    # $ createtags-ruby --no-virtualenv

# createtags-ruby script produce more command function.

# Help ::

    # $ createtags-ruby --help
    # usage: createtags-ruby [-h] [-a] [-p PACKAGES [PACKAGES ...]]
                             # [-s STANDARD_PACKAGES [STANDARD_PACKAGES ...]]
                             # [--no-virtualenv] [--allow-testcode] [-v]
                             # [path]

    # ctags util for virtualenv.

    # positional arguments:
      # path                  project path.

    # optional arguments:
      # -h, --help            show this help message and exit
      # -a, --all             all in virtualenv packages. ignore all options.
      # -p PACKAGES [PACKAGES ...], --packages PACKAGES [PACKAGES ...]
                            # give packages name. default is a `django` package.
      # -s STANDARD_PACKAGES [STANDARD_PACKAGES ...], --standard-packages STANDARD_PACKAGES [STANDARD_PACKAGES ...]
                            # give packages name. for the standard library.
      # --no-virtualenv       not include the virtualenv.
      # --allow-testcode      include the test code.
      # -v, --version         show program's version number and exit

# :copyright: Tatsuo Ikeda
# :license: None
# ===================================
# :create_date:  2011-12-04T23:23:21


p 1
