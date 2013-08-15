#!/bin/bash

source=http://sourceforge.net/projects/tigervnc/files/tigervnc/1.3.0/tigervnc-1.3.0.tar.bz2

archive=$(basename $source)

if test ! -f $archive
then
	wget $source
fi

module load tools/cmake/2.8.10.2
module load java/jdk1.6.0


