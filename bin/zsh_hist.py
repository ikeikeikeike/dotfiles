#!/usr/bin/env python
from collections import Counter, defaultdict
import sys

try:
    #FILENAME = "/Users/{hoge}/.zhistory"
    FILENAME = sys.argv[1]
except:
    print "USAGE: zsh_history_sort.py <your_history_file>"
    sys.exit(1)


class Stat(object):
    def __init__(self):
        self.counter = Counter()
        self.children = defaultdict(Stat)

stat = Stat()

fi = file(FILENAME)
for line in fi:
    line = line.strip()
    if ";" in line:
        line = line.split(";")[1]
    words = line.split()
    s = stat
    for (i, w) in enumerate(words):
        if i > 1:
            break
        s.counter[w] += 1
        s = s.children[w]


def show(stat, indent=0):
    INDENT = "  " * indent
    for name, count in stat.counter.most_common():
        if count < 10:
            break
        print "%s%s: %d" % (INDENT, name, count)
        show(stat.children[name], indent + 1)

show(stat)
