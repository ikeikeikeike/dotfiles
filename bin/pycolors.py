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

    $ pycolors -h
    Usage: pycolors [options] [args [args ...]]

    Options:
      --version   show program's version number and exit
      -h, --help  show this help message and exit

:copyright: Tatsuo Ikeda
:license: None
:create_date:  2012-01-12T23:43:58
=========================================
"""
__version__ = '0.1'

import sys
import re
import optparse

class Bcolors(object):
    """ Bcolors
    """

    #: header
    HEADER = 'header'
    #: blue
    OKBLUE = 'okblue'
    #: green
    OKGREEN = 'okgreen'
    #: warning
    WARNING = 'warning'
    #: fail
    FAIL = 'fail'
    #: endc
    ENDC = 'endc'

    #: header color
    HEADER_COLOR = '\033[95m'
    #: blue color
    OKBLUE_COLOR = '\033[94m'
    #: green color
    OKGREEN_COLOR = '\033[92m'
    #: warning color
    WARNING_COLOR = '\033[93m'
    #: fail color
    FAIL_COLOR = '\033[91m'
    #: end color
    ENDC_COLOR = '\033[0m'

    Default = '\033[0m'

    Black = '\033[30m'
    Red = '\033[31m'
    Green = '\033[32m'
    Yellow = '\033[33m'
    Blue = '\033[34m'
    Magenta = '\033[35m'
    Cyan = '\033[36m'
    White = '\033[37m'

    Reset = '\033[0;0m'
    Bold = '\033[1m'
    Reverse = '\033[2m'

    Blackbg = '\033[40m'
    Redbg = '\033[41m'
    Greenbg = '\033[42m'
    Yellowbg = '\033[43m'
    Bluebg = '\033[44m'
    Magentabg = '\033[45m'
    Cyanbg = '\033[46m'
    Whitebg = '\033[47m'

    def __init__(self):
        # dict
        self._colors = dict()
        # yield
        self._color_keys = None
        # enabled colors
        self.enabled()

    def _get_colors(self):
        return self._colors

    def _set_colors(self, dct):
        self._colors.update(dct)

    colors = property(_get_colors, _set_colors)

    def disable(self):
        if self._colors:
            self._colors = dict()

    def enabled(self):
        if not self._colors:
            self._colors = {
                self.HEADER: self.HEADER_COLOR,
                self.OKBLUE: self.OKBLUE_COLOR,
                self.OKGREEN: self.OKGREEN_COLOR,
                self.WARNING: self.WARNING_COLOR,
                self.FAIL: self.FAIL_COLOR,
                self.ENDC: self.ENDC_COLOR
                }

    def _next_color(self):
        for i in self.colors.keys():
            if i != self.ENDC:
                yield i

    def next_color(self):
        if not self._color_keys:
            self._color_keys = self._next_color()
        try:
            return self._color_keys.next()
        except StopIteration:
            self._color_keys = self._next_color()
            return self.next_color()

    def bc(self, message, coltype=OKGREEN):
        """ embedding colors """
        return "%s%s%s" % (self.colors[coltype], message, self.colors[self.ENDC])

def main(args):

    bcolors = Bcolors()
    ptns = [(re.compile(arg), bcolors.next_color()) for arg in args]

    for stdin in sys.stdin:
        cl_stdin = stdin
        for ptn, color in ptns:
            if ptn.search(cl_stdin):
                cl_stdin = cl_stdin.replace(
                        ptn.pattern, bcolors.bc(ptn.pattern, color)
                        )
        sys.stdout.write(cl_stdin)

if __name__ == '__main__':
    usage = "usage: %prog [options] [args [args ...]]"
    p = optparse.OptionParser(usage=usage, version="%prog " +  __version__)
    # no options
    (opts, args) = p.parse_args()
    if len(args) < 1:
        p.error("set available args.")

    main(args)

