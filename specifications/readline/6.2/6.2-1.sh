#!/bin/bash

source=http://ftp.gnu.org/gnu/readline/readline-6.2.tar.gz

archive=$(basename $source)

module load compilers/gcc/4.8.0
module load tools/make/3.82
module load misc-libs/ncurses/5.9-1

if test ! -f $archive
then
	wget $source
fi

rm -rf box
mkdir box
cd box
tar -xzf ../$archive
cd $(ls)
./configure --prefix=/software/misc-libs/readline/6.2-1 \
--with-curses

make -j 8
make install -j 8
chgrp clumeq -R /software/misc-libs/readline
chmod g+w -R /software/misc-libs/readline
