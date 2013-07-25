#!/bin/bash

source=ftp://invisible-island.net/ncurses/ncurses-5.9.tgz

archive=$(basename $source)

module load compilers/gcc/4.8.0
module load tools/make/3.82


if test ! -f $archive
then
	wget $source
fi

rm -rf box
mkdir box
cd box
tar -xzf ../$archive
cd $(ls)
./configure --prefix=/software/misc-libs/ncurses/5.9-1  --with-shared
make -j 8
make install -j 8
chgrp clumeq -R /software/misc-libs/ncurses/
chmod g+w -R /software/misc-libs/ncurses
