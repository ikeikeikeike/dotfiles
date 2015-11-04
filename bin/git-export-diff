#!/bin/sh

set -e

if [ $# -ne 2 -a $# -ne 3 ]; then
  echo 'Usage:'
  echo '  $ git export-diff <commit> <output_dir>'
  echo '  $ git export-diff <commit> <commit> <output_dir>'
  exit 1
fi

if [ $# -eq 2 ]; then
  COMMIT=$1
  OUT_DIR=$2
fi

if [ $# -eq 3 ]; then
  COMMIT="$1 $2"
  OUT_DIR=$3
fi

TARGETS=`git diff $COMMIT --name-only`

mkdir $OUT_DIR

for target_file in $TARGETS
do
  if [ -e $target_file ]; then
    outdir="${OUT_DIR}/`dirname $target_file`"

    if [ ! -d $outdir ]; then
      mkdir -p $outdir
    fi

    cp $target_file $outdir
  fi
done