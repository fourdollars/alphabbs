#! /usr/bin/env sh

set -e

PACKAGE='alphabbs'

if [ ! -e ./configure ]; then
    ./autogen.sh
fi

make dist-bzip2

VERSION="$(./configure --version | head -n1 | cut -d ' ' -f 3)"

ln ${PACKAGE}-${VERSION}.tar.bz2 ${PACKAGE}_${VERSION}.orig.tar.bz2

tar xf ${PACKAGE}_${VERSION}.orig.tar.bz2

cp -a ./debian ${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}

case "$*" in
    ('-S')
        debuild -S -sa
        ;;
    ('-P')
        pdebuild
        ;;
    ('-PS')
        pdebuild --auto-debsign
        ;;
    (*)
        debuild -us -uc -tc
        ;;
esac

cd ..
