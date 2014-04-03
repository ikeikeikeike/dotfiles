#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
pycolors
===================================
github: https://github.com/ikeikeikeike/home/tree/develop/bin

.. code-block:: bash

**Usage**

redirecting standard input ::

    $ sudo port search python | pycolors python 2.7 27

Help ::

    $ pycolors --help
    Usage: pycolors [options] [args [args ...]]


    Options:
      --version   show program's version number and exit
      -h, --help  show this help message and exit
      -2          Force pycolors to assume the terminal supports 256 colours.
      -8          Like -2, but indicates that the terminal supports 88 colours.

:copyright: Tatsuo Ikeda
:license: None
:create_date:  2012-01-12T23:43:58
=========================================
"""
__version__ = '0.3'

import sys
import re
import optparse


class Bcolors(object):
    """ Bcolors
    """
    ENDCOLOR = '\033[0m'
    ENDCOLOR1 = '\033[0;0m'
    SAFECOLORS = ['\033[91m', '\033[92m', '\033[93m', '\033[94m', '\033[95m', ]
    COLORS = [
        '\033[91m', '\033[92m', '\033[93m', '\033[94m', '\033[95m',
        '\033[45m', '\033[46m', '\033[30m', '\033[31m', '\033[32m', '\033[33m',
        '\033[34m', '\033[35m', '\033[36m',
        '\033[1m', '\033[40m', '\033[41m', '\033[42m', '\033[43m', '\033[44m',
    ]

    def __init__(self, number=0):
        self.__colors = self.makecolors(number)
        self._colors = []
        self._color = None
        self.enabled()

    def _get_colors(self):
        return self._colors

    def _set_colors(self, color):
        self._colors.append(color)

    colors = property(_get_colors, _set_colors)

    def _nextcolor(self):
        for i in self.colors:
            yield i

    def makecolors(self, number=0, colors=list()):
        if 0 < number:
            return ["\033[{0}m".format(n) for n in range(1, int(number) + 1)]
        elif colors:
            return colors
        else:
            return self.COLORS

    def disable(self):
        if self._colors:
            self._colors = []

    def enabled(self):
        if not self._colors:
            self._colors = self.__colors

    def nextcolor(self):
        if not self._color:
            self._color = self._nextcolor()
        try:
            return self._color.next()
        except StopIteration:
            self._color = self._nextcolor()
            return self.nextcolor()

    def bc(self, message, color):
        """ embedding colors """
        return "%s%s%s" % (color, message, self.ENDCOLOR)


def main(args, opts):

    if opts.c88:
        number = 88
    elif opts.c256:
        number = 256
    else:
        number = 0
    bcolors = Bcolors(number)
    # print(repr(bcolors._colors))

    ptns = [(re.compile(arg), bcolors.nextcolor()) for arg in args]
    for stdin in sys.stdin:
        cl_stdin = stdin
        for ptn, color in ptns:
            if ptn.search(cl_stdin):
                cl_stdin = cl_stdin.replace(
                    ptn.pattern, bcolors.bc(ptn.pattern, color))
        sys.stdout.write(cl_stdin)


if __name__ == '__main__':
    usage = "usage: %prog [options] [args [args ...]] "
    p = optparse.OptionParser(usage=usage, version="%prog " + __version__)
    p.add_option(
        "-2", action="store_true", dest="c256", default=False,
        help="Force pycolors to assume the terminal supports 256 colours.")
    p.add_option(
        "-8", action="store_true", dest="c88", default=False,
        help="Like -2, but indicates that the terminal supports 88 colours.")
    # no options
    (opts, args) = p.parse_args()
    if len(args) < 1:
        p.error("set available args.")

    main(args, opts)
