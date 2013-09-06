#!/bin/bash
# Packager: Sébastien Boisvert

name=osc-mpiexec
version=0.84
release=1

source=https://www.osc.edu/~djohnson/mpiexec/mpiexec-$version.tgz
file=$(basename $source)

root=/
#root=$(pwd)/scratch

prefix=$root/software/mpi/$name/$version-$release

module load compilers/intel/2013
module load mpi/mvapich2/1.9_intel

# this one is only in my $HOME...
#module load tools/torque/4.1.0

if test ! -f $file
then
    wget $source
fi

rm -rf Sandbox
mkdir Sandbox
cd Sandbox
cat ../$file | gunzip | tar -x

# InfiniBand
#--with-default-comm=ch3:mrail \

# This software can not be built in a separate directory, this is buggy.
#mkdir Build
ln -s $(ls) Build

#--with-default-comm=pmi \

torque=/opt/torque

# this is just because we don't have a module for torque !
export LIBRARY_PATH=$torque/lib:$LIBRARY_PATH

cd Build
../$(echo $file|sed 's/.tgz//g')/configure \
--prefix=$prefix \
--with-default-comm=mpich2-pmi \
--with-pbs=$torque \

make -j 4

make install

cd ..
cd ..


mkdir -p $root/clumeq/Modules/modulefiles/mpi/$name
cp module $root/clumeq/Modules/modulefiles/mpi/$name/$version-$release

chgrp clumeq -R $root/clumeq/Modules/modulefiles/apps/$name &> /dev/null
chgrp clumeq -R $root/software/apps/$name &> /dev/null
chmod g+w -R $root/clumeq/Modules/modulefiles/apps/$name &> /dev/null
chmod g+w -R $root/software/apps/$name &> /dev/null



