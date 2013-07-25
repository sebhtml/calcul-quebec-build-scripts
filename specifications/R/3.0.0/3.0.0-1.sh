#!/bin/bash

name=R
version=3.0.0
source=http://cran.rstudio.com/src/base/$name-3/$name-$version.tar.gz
archive=$(basename $source)
release=1

module load compilers/gcc/4.8.0
module load tools/make/3.82
module load misc-libs/readline/6.2-1
module load misc-libs/ncurses/5.9-1
#module load apps/xorg-server/1.12.2-1
#module load apps/xorg-server/1.12.2-1
module load java/jdk1.6.0

#CPUs=$(ls /sys/devices/virtual/cpuid/|wc -l)
CPUs=2

if test ! -f $archive
then
	wget $source
fi

rm -rf box
mkdir box
cd box
tar -xzf ../$archive

cd $(ls)

./configure --prefix=/software/apps/$name/$version-$release
#--with-readline=/software/misc-libs/readline/6.2-1/ 

# https://otrs.clumeq.ca/otrs/index.pl?Action=AgentTicketZoom;TicketID=7488;ArticleID=42072
# the symbol rl_sort_completion_matches is linked as rl_sort_completion_matche
# this is a bug.
sed -i 's>rl_sort_completion_matches = 0;>>g' src/unix/sys-std.c


make -j $CPUs
#make check -j $CPUs
#make pdf -j $CPUs
#make info -j $CPUs
make install -j $CPUs
#make install-pdf -j $CPUs
#make install-info -j $CPUs

chgrp clumeq -R /software/apps/$name/$version-$release
chmod g+w -R /software/apps/$name/$version-$release

