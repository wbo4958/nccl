#!/bin/bash

nccl_version=2.7.8-1

function compile() {
  make -j4 src.build && make pkg.txz.build
  cuda=$(readlink /usr/local/cuda | tr -d -)
  pkg=nccl_${nccl_version}+${cuda}_x86_64
  mkdir -p /home/bobwang/tools/nccl
  rm -fr /home/bobwang/tools/nccl/$pkg*
  tar -xf build/pkg/txz/$pkg.txz -C /home/bobwang/tools/nccl
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
