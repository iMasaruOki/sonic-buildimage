#!/bin/sh

TOP=$PWD

configure() {
git submodule deinit -f --all
make init
make USERNAME=admin PASSWORD=hogehoge configure PLATFORM=broadcom
}

apply_patch() {
: # apply local patch for submodule.
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
