#!/bin/bash

name=tophat
version=2.0.9
release=1

source=http://$name.cbcb.umd.edu/downloads/$name-2.0.9.tar.gz

archive=$(basename $source)

if test ! -f $archive
then
	wget $source
fi

module load compilers/gcc/4.8.0
module load misc-libs/boost/1.53.0-1
module load apps/samtools/0.1.19-1

rm -rf mock
mkdir mock
cd mock
tar -xzf ../$archive
cd $(ls | head -n1)

./configure \
--with-bam=/software/apps/samtools/0.1.19-1 \
--with-boost=/software/misc-libs/boost/1.53.0-1 \
--prefix=/software/apps/$name/$version-$release

make -j 4

make install

cd ..
cd ..

mkdir -p /clumeq/Modules/modulefiles/apps/$name
cp module /clumeq/Modules/modulefiles/apps/$name/$version-$release

chgrp clumeq -R /clumeq/Modules/modulefiles/apps/$name &> /dev/null
chgrp clumeq -R /software/apps/$name &> /dev/null
chmod g+w -R /clumeq/Modules/modulefiles/apps/$name &> /dev/null
chmod g+w -R /software/apps/$name &> /dev/null
