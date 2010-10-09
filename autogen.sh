#! /usr/bin/env sh

[ -e configure ] || autoreconf -if

./configure

make
