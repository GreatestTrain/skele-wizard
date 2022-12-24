#!/bin/bash

mkdir -p $1/{etc,var,sources} $1/usr/{bin,lib,sbin} &&

for i in {bin,lib,sbin}; do
  ln -rs $LFS/usr/$i $LFS/$i
done &&

case $(uname -m) in
  x86_64) ln -rs $LFS/usr/lib $LFS/lib64;;
esac &&

echo "Filesystem initialized."
