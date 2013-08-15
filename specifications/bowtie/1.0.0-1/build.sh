#!/bin/bash

name=bowtie
version=1.0.0
release=1

source=http://sourceforge.net/projects/$name-bio/files/$name/$version/$name-$version-src.zip

archive=$(basename $source)

if test ! -f $archive
then
	wget $source
fi

module load compilers/gcc/4.8.0

rm -rf mock
mkdir mock
cd mock
unzip ../$archive
cd $(ls | head -n1)

prefix=/software/apps/$name/$version-$release

./configure \
--prefix=$prefix

make -j 4

mkdir $prefix/bin -p
cp bowtie $prefix/bin
cp bowtie-build $prefix/bin
cp bowtie-inspect $prefix/bin

cd ..
cd ..

mkdir -p /clumeq/Modules/modulefiles/apps/$name
cp module /clumeq/Modules/modulefiles/apps/$name/$version-$release

chgrp clumeq -R /clumeq/Modules/modulefiles/apps/$name &> /dev/null
chgrp clumeq -R /software/apps/$name &> /dev/null
chmod g+w -R /clumeq/Modules/modulefiles/apps/$name &> /dev/null
chmod g+w -R /software/apps/$name &> /dev/null
