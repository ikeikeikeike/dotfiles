#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
simple simple*2 createtags-python
===================================
github: https://github.com/ikeikeikeike/home/tree/develop/bin

.. code-block:: bash

**Usage**

add packages (default django) ::

    $ createtags-python -p django ipdb pudb IPython celery

not include the virtualenv ::

    $ createtags-python --no-virtualenv

createtags-python script produce more command function.

Help ::

    $ createtags-python --help
    usage: createtags-python [-h] [-a] [-p PACKAGES [PACKAGES ...]]
                             [--no-virtualenv] [-v]
                             [path]

    ctags util for virtualenv.

    positional arguments:
      path                  project path.

    optional arguments:
      -h, --help            show this help message and exit
      -a, --all             all in packages. ignore all options.
      -p PACKAGES [PACKAGES ...], --packages PACKAGES [PACKAGES ...]
                            give packages name. default is a `django` package.
      --no-virtualenv       not include the virtualenv.
      -v, --version         show program's version number and exit

:copyright: Tatsuo Ikeda
:license: None
===================================
:create_date:  2011-12-04T23:23:21
"""
__version__ = '0.2'

import os
import sys
import popen2
import argparse
from distutils.sysconfig import get_python_lib


def stdoutput(out):
    """output"""
    try:
        for o in out: print o
    except IOError:
        pass


def rm_tags(path):
    """delete tag"""
    try:
        os.remove(path)
    except OSError:
        pass


def get_virtualenv_python_lib():
    """like a get_python_lib()"""
    if isinstance(sys.version_info, tuple):
        version = "%s.%s" % (sys.version_info[0], sys.version_info[1])
    else:
        version = "%s.%s" % (sys.version_info.major, sys.version_info.minor)
    return "%s/lib/python%s/site-packages" % (os.environ["VIRTUAL_ENV"], version)


def run_command(command):
    """run and output buffer

    :param str command: command line string.
    """
    cmd = ('%s' % command)
    print('')
    print('run::')
    print('')
    print("   %s" % cmd)
    print('')
    print('')

    stdout, stdin, stderr = popen2.popen3(cmd)
    stdoutput(stdout)
    stdoutput(stdin)
    stdoutput(stderr)


def main(args):
    """ include virtualenv or not include vurtualenv or chice packages.

    :param args: argparse object.
    :rtype: void
    :return: void
    """

    rm_tags('./tags')

    exclude_option = ("--languages=python --python-kinds=-i-v "
            "--exclude=test_* "
            "--exclude=tests.py "
            "--exclude=test.py "
            "--exclude=*/IPython/* "
            "--exclude=*/unittest/* "
            "--exclude=*/testing/* "
            "--exclude=*/testsuite/* "
            "--exclude=*/test/* "
            "--exclude=*/tests/*")
    run_command("ctags -R    %s %s" % (exclude_option, args.path))
    # run_command("ctags -R -a %s %s" % (exclude_option, os.path.join(get_python_lib(), "../")))
    run_command("ctags -R -a --languages=python --python-kinds=-i-v ~/.virtualenvs/__builtin__27/builtins/__builtin__.py")
    run_command("ctags -R -a --languages=python --python-kinds=-i-v ~/.virtualenvs/__builtin__27/builtins/__builtin_exceptions__.py")
    run_command("ctags -R -a --languages=python --python-kinds=-i-v ~/.virtualenvs/__builtin__27/builtins/__future__.py")

    if args.no_virtualenv is False or args.all:
        vpath = get_virtualenv_python_lib()
        if args.all:
            run_command("ctags -R -a %s %s" % (exclude_option, vpath))
        else:
            for package in args.packages:
                run_command("ctags -R -a %s %s%s" % (exclude_option, os.path.join(vpath, package), '*'))
        rm_tags("%s/tags" % vpath)
        os.symlink("%s/tags" % os.getcwd(), "%s/tags" % vpath)


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description="ctags util for virtualenv.")
    parser.add_argument('path', nargs='?', default='.',
            help='project path.')
    parser.add_argument('-a', '--all', action="store_true",
            help='all in packages. ignore all options.')
    parser.add_argument('-p', '--packages', nargs='+', default=['django'],
            help='give packages name. default is a `django` package.')
    parser.add_argument('--no-virtualenv', action='store_true',
            help='not include the virtualenv.')
    parser.add_argument('-v', '--version', action='version', version='%(prog)s ' + __version__)

    args = parser.parse_args()
    main(args)

