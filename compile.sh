#!/bin/bash

nccl_version=2.7.8-1
nccl_install_path=/home/bobwang/work.d/nvspark/library/nccl

dir=`pwd`

function compile() {
  cd $dir
  make clean &&  make -j4 src.build && make pkg.txz.build
  cuda=$(readlink /usr/local/cuda | tr -d -)
  pkg=nccl_${nccl_version}+${cuda}_x86_64
  mkdir -p $nccl_install_path
  rm -fr $nccl_install_path/$pkg*
  tar -xf build/pkg/txz/$pkg.txz -C $nccl_install_path
}

if [[ "$@" = *all* ]]; then
  for cuda in cuda10-1 cuda10-2 cuda-11.0
  do
    echo $cuda
    cd /usr/local
    sudo unlink cuda
    sudo ln -s $cuda cuda
    compile
  done
else
  compile
fi
