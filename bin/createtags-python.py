#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
simple simple*2 createtags-python
===================================
github: https://github.com/ikeikeikeike/home/tree/develop/bin

.. code-block:: bash

**Usage**

add virtualenv packages (default django) ::

    $ createtags-python -p django ipdb pudb IPython celery

add standard packages ::

    $ createtags-python -s SocketServer commands

not include the virtualenv ::

    $ createtags-python --no-virtualenv

createtags-python script produce more command function.

Help ::

    $ createtags-python --help
    usage: createtags-python [-h] [-a] [-p PACKAGES [PACKAGES ...]]
                             [-s STANDARD_PACKAGES [STANDARD_PACKAGES ...]]
                             [-l STANDARD_LIB [STANDARD_LIB ...]] [-b BASE_PREFIX]
                             [--no-virtualenv] [--allow-testcode] [-v]
                             [path]

    ctags util for virtualenv.

    positional arguments:
      path                  project path.

    optional arguments:
      -h, --help            show this help message and exit
      -a, --all             all in virtualenv packages. ignore all options.
      -p PACKAGES [PACKAGES ...], --packages PACKAGES [PACKAGES ...]
                            give packages name. default is a `django` package.
      -s STANDARD_PACKAGES [STANDARD_PACKAGES ...], --standard-packages STANDARD_PACKAGES [STANDARD_PACKAGES ...]
                            give packages name. for the standard library.
      -l STANDARD_LIB [STANDARD_LIB ...], --standard-lib STANDARD_LIB [STANDARD_LIB ...]
                            give packages name. for the standard library.
      -b BASE_PREFIX, --base-prefix BASE_PREFIX
                            package prefix.
      --no-virtualenv       not include the virtualenv.
      --allow-testcode      include the test code.
      -v, --version         show program's version number and exit


:copyright: Tatsuo Ikeda
:license: None
===================================
:create_date:  2011-12-04T23:23:21
"""
__version__ = '0.3'

import os
import sys
try:
    import commands
    getoutput = commands.getoutput
except ImportError:
    import subprocess
    getoutput = subprocess.getoutput
import argparse
from distutils.sysconfig import get_python_lib

def rmtag(path):
    try:
        os.remove(path)
    except OSError as e:
        print(e)

def symlink(src, dst):
    try:
        os.symlink(src, dst)
    except OSError as e:
        print(e)

def getvepath():
    if isinstance(sys.version_info, tuple):
        version = "%s.%s" % (sys.version_info[0], sys.version_info[1])
    else:
        version = "%s.%s" % (sys.version_info.major, sys.version_info.minor)
    return "%s/lib/python%s/site-packages" % (os.environ["VIRTUAL_ENV"], version)

def aftercmd(exclude):
    runcmd("ctags -R -a %s ~/.virtualenvs/__builtin__27/builtins/__builtin__.py" % exclude)
    runcmd("ctags -R -a %s ~/.virtualenvs/__builtin__27/builtins/__builtin_exceptions__.py" % exclude)
    runcmd("ctags -R -a %s ~/.virtualenvs/__builtin__27/builtins/__future__.py" % exclude)
    # runcmd("ctags -R -a %s %s" % (exclude_option, os.path.join(get_python_lib(), "../")))

def runcmd(cmd, warning=True):
    print("run::\n   %s" % cmd)
    output = getoutput(cmd)

    print(output)
    if output and warning is False:
        raise IOError(output)

def main(args):
    rmtag('./tags')

    # options
    exclude_option = "--languages=python --python-kinds=-i-v "
    if not args.allow_testcode:
            exclude_option += (
                    "--exclude=test_* "
                    "--exclude=tests.py "
                    "--exclude=test.py "
                    "--exclude=*/IPython/* "
                    "--exclude=*/unittest/* "
                    "--exclude=*/testing/* "
                    "--exclude=*/testsuite/* "
                    "--exclude=*/test/* "
                    "--exclude=*/tests/*")
    runcmd("ctags -R    %s %s" % (exclude_option, args.path))
    aftercmd(exclude_option)

    # virtualenv
    if args.no_virtualenv is False or args.all:
        vpath = getvepath()
        if args.all:
            runcmd("ctags -R -a %s %s" % (exclude_option, vpath))
        else:
            for package in args.packages:
                runcmd("ctags -R -a %s %s%s" % (exclude_option, os.path.join(vpath, package), '*'))
        rmtag("%s/tags" % vpath)
        symlink("%s/tags" % os.getcwd(), "%s/tags" % vpath)

    # standard package
    if args.standard_packages:
        path = get_python_lib(prefix=args.base_prefix)
        for package in args.standard_packages:
            runcmd("ctags -R -a %s %s%s" % (exclude_option, os.path.join(path, package), '*'))
        rmtag("%s/tags" % path)
        symlink("%s/tags" % os.getcwd(), "%s/tags" % path)

    # standard library
    if args.standard_lib:
        path = get_python_lib(standard_lib=True, prefix=args.base_prefix)
        for package in args.standard_lib:
            runcmd("ctags -R -a %s %s%s" % (exclude_option, os.path.join(path, package), '*'))
        rmtag("%s/tags" % path)
        symlink("%s/tags" % os.getcwd(), "%s/tags" % path)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="ctags util for virtualenv.")
    parser.add_argument("path", nargs="?", default='.', help="project path.")
    parser.add_argument("-a", "--all", action="store_true", help="all in virtualenv packages. ignore all options.")
    parser.add_argument("-p", "--packages", nargs='+', default=["django"], help="give packages name. default is a `django` package.")
    parser.add_argument("-s", "--standard-packages", nargs="+", default=[], help="give packages name. for the standard library.")
    parser.add_argument("-l", "--standard-lib", nargs='+', default=[], help="give packages name. for the standard library.")
    parser.add_argument("-b", "--base-prefix", default="/usr", help="package prefix.")
    parser.add_argument("--no-virtualenv", action="store_true", help="not include the virtualenv.")
    parser.add_argument("--allow-testcode", action="store_true", help="include the test code.")
    parser.add_argument("-v", "--version", action="version", version="%(prog)s " + __version__)

    args = parser.parse_args()
    main(args)
