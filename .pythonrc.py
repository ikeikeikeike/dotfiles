import os
HISTORYFILE = os.path.expanduser('~/.pythonhistory')
try:
  import rlcompleter, readline
  readline.parse_and_bind("tab: complete")
  #readline.parse_and_bind ("bind ^I rl_complete") # not use, gnu readline
  readline.parse_and_bind("set input-meta on")
  readline.parse_and_bind("set convert-meta off")
  readline.parse_and_bind("set output-meta on")
  try:
    f = open(HISTORYFILE, "a")
    f.close()
    readline.read_history_file(HISTORYFILE)
  except IOError:
    pass
  try:
    import atexit
    atexit.register(lambda: readline.write_history_file(HISTORYFILE))
  except:
    pass
except:
  pass


# import datetime
# WRITEHISTORYFILE = os.path.expanduser('~/.mypython/logs/pythonwritehistory_%s.py' % (
    # datetime.datetime.now().strftime("%Y%m%d_%H%M%S"),
# ))
# f = open(WRITEHISTORYFILE, "a")
# f.close()
# readline.write_history_file(WRITEHISTORYFILE)

