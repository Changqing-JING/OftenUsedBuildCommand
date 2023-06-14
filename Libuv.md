```shell
git clone https://github.com/libuv/libuv.git
```

### On Ubuntu
#### Local Install
```shell
cd libuv
mkdir build
cd build
cmake ..
cmake --build . --parallel
sudo make install
```
#### Cross compile for arm64
```shell
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ -DCMAKE_INSTALL_PREFIX=install_path ..
cmake --build . --parallel
make install
```
### On Macos
```shell
cd libuv
mkdir build
cd build
cmake ..
cmake --build . --parallel
make install
```
### On windows
#### For x86_64 Windows
```bat
cd libuv
mkdir build_win
cd build_win
cmake -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_INSTALL_PREFIX=install_path  -A x64 ..
cmake --build .
cmake --install . --config Debug
#For debug build, copy uv_a.pdb also, otherwise MSVC will report Warning LNK4099
copy Debug\uv_a.pdb install_path\lib\uv_a.pdb
```

#### libuv windows x86_64 clang:
```bat
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=D:\install_path  -A x64 -T clangcl ..
```

#### For ARM64 Windows
```bat
cd libuv
mkdir build_win_arm
cd build_win_arm
cmake -DCMAKE_BUILD_TYPE=DEBUG -DCMAKE_INSTALL_PREFIX=install_path  -A ARM64 ..
cmake --build .
cmake --install . --config Debug
```
add environment vairalbe key: libuv_DIR, value: install_path

### Cross Compile for QNX on Linux
```shell
cd libuv
mkdir build_qnx
cmake -DCMAKE_INSTALL_PREFIX=install_path -DCMAKE_SYSTEM_NAME=QNX -DCMAKE_CXX_FLAGS="-D_QNX_SOURCE=1" ..
cmake --build . --parallel
make install
```