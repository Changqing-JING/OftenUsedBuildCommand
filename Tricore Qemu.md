Build tricore qemu
```shell
git clone https://github.com/volumit/qemu.git
de qemu
git submodule update --init --recursive --progress
mkdir build
cd build
CC=gcc-9 CFLAGS=-Wno-error ../configure
make -j $(nproc)
```