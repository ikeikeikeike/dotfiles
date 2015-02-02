# .gdbinit file for debugging Mozilla

# set prompt \033[1m(gdb) \033[0m
# set extended-prompt \w - \f\n(gdb) 

set history filename ~/.gdb_history
set history save on
set history size 1024

set print pretty
set print symbol-filename on
set print array on
set print array-indexes on

# Show the concrete types behind nsIFoo
set print object on

# Don't stop for the SIG32/33/etc signals that Flash produces
handle SIG32 noprint nostop pass
handle SIG33 noprint nostop pass
handle SIGPIPE noprint nostop pass

define g
    python
    import subprocess as p
    cmd = ["go", "env", "GOROOT"]
    gdb_cmd = "source %s/src/pkg/runtime/runtime-gdb.py" % p.check_output(cmd)[:-1]
    gdb.execute(gdb_cmd)
end
