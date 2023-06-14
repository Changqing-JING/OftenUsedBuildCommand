# Install AVRO-CPP
## On Ubuntu
```shell
wget http://archive.apache.org/dist/avro/avro-1.10.2/cpp/avro-cpp-1.10.2.tar.gz
tar -zxvf avro-cpp-1.10.2.tar.gz
cd avro-cpp-1.10.2
./build.sh install
cd build
sudo make install
sudo ldconfig /usr/local/lib
```

## On Macos
```
brew install avro-cpp
```
## On windows
### Build snappy
This step requests some basic knowledge of Visual Studio, about how to set project "Platform Toolset" and how to add "New Solution Platform" in "Configuration Manager"
```shell
git clone https://github.com/spektom/snappy-visual-cpp.git
```
1. Open snappy-visual-cpp/snappy.sln in Visual Studio
2. The Default "Platform Toolset" of project snappy is Windows XP, change it to Visual Studio 2019 (v142)/Visual Studio 2022 (v143)
3. Build for x64
4. Create a new config AMR64, "Copy Settings From" x64
5. Build for ARM64
6. Add C:\snappy-visual-cpp\x64\Debug to PATH
### Clone Avor-CPP
```shell
git clone https://github.com/apache/avro.git
cd avro
git checkout release-1.10.2
cd lang/c++f
mkdir build
mkdir build_arm
```
### Build for x86_64
```bat
cd build
cmake  -DCMAKE_BUILD_TYPE=Debug -DSNAPPY_INCLUDE_DIR="C:\snappy-visual-cpp" -DBoost_USE_STATIC_LIBS=OFF -DSNAPPY_LIBRARIES="C:\snappy-visual-cpp\x64\Debug\snappy64.lib" ..
cmake --build .  --target avrocpp_s avrocpp_s avrogencpp
cmake -DCMAKE_INSTALL_PREFIX="D:\avro_x86" -P cmake_install.cmake 
```
Add D:\avro_x86\lib to PATH
### Build for arm64
```
set BOOST_ROOT=D:\boost_msvc_arm_dll
cmake -A ARM64 -DSNAPPY_INCLUDE_DIR="C:\snappy-visual-cpp" -DBoost_USE_STATIC_LIBS=OFF -DSNAPPY_LIBRARIES="C:\snappy-visual-cpp\ARM64\Debug\snappy64.lib" ..
cmake --build .  --target avrocpp avrocpp_s
```
open build_arm64/cmake_install.cmake
Remove line 88-98, which tries to install avrogencpp.exe. Because arm64 version avrogencpp.exe is not needed.

```bat
cmake -DBUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX="D:/avro_arm" -P cmake_install.cmake 
```
Note: for release build:
```bat
cmake --build . --config Release --target avrocpp avrocpp_s
```
### Set environment variable
add environment variable Avro_DIR=D:\avro_x86