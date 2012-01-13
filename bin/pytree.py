#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
pytree
=================================================================================
github: https://github.com/ikeikeikeike/home/tree/develop/bin

run command::

    $ pytree /etc/mail

redirect standard input::

    $ pyfind /etc/mail "Default" | pytree

Derivative Works by http://d.hatena.ne.jp/doloopwhile/20100701/1277997793
pyfind: https://gist.github.com/1533155
=================================================================================
:create_date:  2011-12-29T02:00:07
:link: http://d.hatena.ne.jp/doloopwhile/20100701/1277997793
:link: https://gist.github.com/1533155
"""
from __future__ import division, print_function, unicode_literals

import re
import os
import sys
import codecs
from os.path import *
from operator import methodcaller

def add_prefix_to_strs(prefix, strs):
    return [prefix + s for s in strs]

def tree_lines_(path, is_last=True):
    # path = abspath(path)

    if is_last:
        branch_str = "`--"
        indent_str = "   "
    else:
        branch_str = "|--"
        indent_str = "|  "

    lines = [branch_str + basename(path)]
    if isdir(path):
        entries = nexts(path)
        entries.sort(key=methodcaller("lower"))
        for i, entry in enumerate(entries):
            is_last_entry = i == len(entries) - 1
            entry_lines = tree_lines_(join(path, entry), is_last_entry)
            entry_lines = add_prefix_to_strs(indent_str, entry_lines)
            lines.extend(entry_lines)
    return lines

def tree_lines(path):
    # path = abspath(path)

    lines = []
    lines.append(path)
    lines.append("|")
    entries = nexts(path)
    entries.sort(key=methodcaller("lower"))
    for i, entry in enumerate(entries):
        is_last_entry = i == len(entries) - 1
        entry_lines = tree_lines_(join(path, entry), is_last_entry)
        lines.extend(entry_lines)
    return lines

def print_lines(lines):
    for line in lines:
        print(line)

def nexts_gen(stdinlines=False):

    if stdinlines:
        lines = [unicode(c.rstrip(), 'utf8') for c in sys.stdin]
    else:
        lines = []

    def _basesearch(path):
        ptn = re.compile(path)
        return [l for l in lines if ptn.search(l)]

    def _indexlist(lists, indx):
        s = set()
        for l in lists:
            try:
                s.add(l.split('/')[indx])
            except IndexError:
                pass
        return list(s)

    def nexts(path):
        if stdinlines is False:
            return os.listdir(path)
        else:
            clpath = path.rstrip('/')
            return _indexlist(_basesearch(clpath), len(clpath.split('/')))

    return nexts

def main(root):
    print()
    print_lines(tree_lines(root))

if "__main__" == __name__:

    if 2 <= len(sys.argv):
        if isdir(sys.argv[1]):
            root = sys.argv[1]
        else:
            root = dirname(sys.argv[1])
        nexts = nexts_gen(False)
    else:
        root = sys.stdin.readline().rstrip()
        nexts = nexts_gen(True)

    main(unicode(root, 'utf8'))


