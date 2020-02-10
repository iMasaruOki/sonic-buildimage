#!/bin/sh

TOP=$PWD

configure() {
git submodule deinit -f --all
make init
make USERNAME=admin PASSWORD=hogehoge configure PLATFORM=broadcom
cd src/sonic-utilities
git checkout master
cd -
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
if [ "x$ARG" = "x" ]; then
  ARG="configure;apply_patch;clean;build"
fi

eval $ARG
