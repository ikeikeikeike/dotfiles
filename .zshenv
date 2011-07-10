
#### ARCHI
if [ -x /usr/bin/uname ] || [ -x /bin/uname ]; then
  case "`uname -sr`" in
    FreeBSD*); export ARCHI="freebsd" ;;
    Linux*);   export ARCHI="linux"   ;;
    CYGWIN*);  export ARCHI="cygwin"  ;;
    IRIX*);    export ARCHI="irix"    ;;
    OSF1*);    export ARCHI="osf1"    ;;
    Darwin*);  export ARCHI="osx"     ;;
    *);        export ARCHI="dummy"   ;;
  esac
else
  export ARCHI="dummy"
fi

#### HOST
if [ -x /bin/hostname ]; then
  export HOST=`hostname`
fi;
export host=`echo $HOST | sed -e 's/\..*//'`
