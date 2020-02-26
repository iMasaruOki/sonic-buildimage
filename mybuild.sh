#!/bin/sh

TOP=$PWD

configure() {
git submodule deinit -f --all
make init
make USERNAME=admin PASSWORD=hogehoge configure PLATFORM=broadcom
}

apply_patch() {
FILES=`ls *.diff`
if [ "x$FILES" != "x" ]; then
  for f in $FILES; do
    DIR=`basename $f .diff`
    cd src/$DIR
    patch -p1 < $TOP/$f
    cd -
  done
fi
}

clean() {
make clean
rm -f -d target/debs/stretch/dpkg_lock
rm -f -d target/python-wheels/pip_lock
}

build() {
make USERNAME=admin PASSWORD=hogehoge target/sonic-broadcom.bin
}

ARG="$@"
if [ "x$ARG" = "xall" ]; then
  ARG="configure;apply_patch;clean;build"
fi
if [ "x$ARG" = "x" ]; then
  USAGE=1
fi
if [ "x$ARG" = "xhelp" ]; then
  USAGE=1
fi
if [ "x$USAGE" = "x1" ]; then
  echo "Usage: $0 <stage>"
  echo " stage: configure, apply_patch, clean, build"
  echo "        all: run above all stage."
  echo " To run multiple stage, separate with ;."
  echo "  e.g. $0 \"configure;build\""
  exit 1
fi

eval $ARG
