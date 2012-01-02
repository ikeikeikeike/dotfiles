#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
===================================
pyfind

run command::

    $ pyfind /etc/mail "Default"

regex::

    $ pyfind /etc/mail "Defa.+"

===================================
:create_date:  2011-12-28T23:53:25
"""
__version__ = '0.1'

import os
import re
import optparse

class Error(EnvironmentError):
    pass

def findtree_gen(pattern):
    """ generator findtree
    """
    find_pattern = re.compile(pattern)
    finder = []
    errors = []

    def findtree(src, symlinks=False, ignore=None, basenamefind=False):
        """ shutil.copytree like method.
        """
        names = os.listdir(src)
        if ignore is not None:
            ignored_names = ignore(src, names)
        else:
            ignored_names = set()

        for name in names:
            if name in ignored_names:
                continue
            srcname = os.path.join(src, name)

            if find_pattern.search(srcname):
                finder.append(srcname)

            try:
                if symlinks and os.path.islink(srcname):
                    linkto = os.readlink(srcname)
                elif os.path.isdir(srcname):
                    findtree(srcname, symlinks, ignore)
            except Error, err:
                errors.extend(err.args[0])
            except EnvironmentError, why:
                errors.append((srcname, pattern, str(why)))

        if errors:
            raise Error, errors

        if finder:
            finder.insert(0, src)

        return finder

    return findtree


if __name__ == '__main__':
    usage = "usage: %prog [options] [args [args ...]]"
    p = optparse.OptionParser(usage=usage, version="%prog " +  __version__)
    # no options
    (opts, args) = p.parse_args()
    if len(args) < 1:
        p.error("set available args.")
    elif len(args) < 2:
        pattern = r"."
    else:
        pattern = r"%s" % args[1]

    src = u"%s" % args[0]

    findtree = findtree_gen(pattern)
    finder = findtree(src)

    # main is output.
    try:
        for f in finder: print f
    except IOError, err:
        pass



