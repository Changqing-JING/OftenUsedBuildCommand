### Build GDB in debug mode
```shell
git clone https://sourceware.org/git/binutils-gdb.git
cd binutils-gdb
CPPFLAGS=-DDEBUG CFLAGS="-g -O0" ./configure
make -j $(nproc)
```


## Build tricore GDB
```shell
https://github.com/volumit/gdb-tricore.git
cd gdb-tricore
CC=gcc-9 CFLAGS="-Wno-error -g -Og" ./configure --target=tricore-unknown-elf x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu --disable-python
make -j $(nproc)
```