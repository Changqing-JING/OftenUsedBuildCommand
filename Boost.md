
## In ubuntu:
Note: This project requests boost>=1.74
Check Boost version of apt
```shellcheckout zlib first
```bat
git clone https://github.com/madler/zlib.git
```
### Windows Local build
Download boost release source and unzip https://www.boost.org/users/download/
```bat
curl -O -J https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.zip
```
apt -s install libboost-all-dev
```
If the boost version of apt is >=1.74, run
```shell
sudo apt install libboost-all-dev
```
otherwise please install from source
```shell
sudo apt install zlib1g-dev
wget https://boostorg.jfrog.io/artifactory/main/release/1.76.0/source/boost_1_76_0.tar.gz
tar -zxvf boost_1_76_0.tar.gz
cd boost_1_76_0
./bootstrap.sh --prefix=/usr --with-python=python3
./b2 stage -j$(nproc) threading=multi link=shared
sudo ./b2 install threading=multi link=shared 
```

## On MacOS

```shell
brew install boost
```
## In windows:
Note install instructions will use a demo path as install prefix. The can be replace with other path.
### 1. Download Boost 1.78 and unzip it. (Boost>=1.78 is compatible with Visual Studio 2022)
    https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.zip

### 2. Build boost for x86_64
Note: Event though boost can be built both dynamic and static linked. In this project, Boost can only be build as dll and dynamic link runtime. Because avro only support dynamic linked boost and Qt6 arm64 only support dynamic link runtime.

Download boost release source and unzip https://www.boost.org/users/download/
```bat
curl -O -J https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.zip
```

```bat
git clone https://github.com/madler/zlib.git
cd boost_1_78_0
bootstrap.bat
#Build x86_64
#Build Default
b2 toolset=msvc link=shared architecture=x86 address-model=64 variant=debug --prefix=D:\boost_msvc_dll install
#Build boost_iostreams with zlib, which is required by avro
b2 toolset=msvc link=shared architecture=x86 address-model=64 variant=debug --with-iostreams --build-type=complete -s ZLIB_SOURCE="C:\zlib" -s ZLIB_INCLUDE="C:\zlib" --prefix=D:\boost_msvc_dll install
```
### Build boost for arm64
```bat
b2 toolset=msvc link=shared architecture=arm address-model=64 variant=debug --prefix=D:\boost_msvc_arm_dll install
b2 toolset=msvc link=shared architecture=arm address-model=64 variant=debug --with-iostreams --build-type=complete -s ZLIB_SOURCE="C:\zlib" -s ZLIB_INCLUDE="C:\zlib" --prefix=D:\boost_msvc_arm_dll install
```
Note: use variant=release to build releas version.

#### Set envrionment variable
set Environment Variable BOOST_ROOT=D:\boost_1_78_0_msvc_dll
Add D:\boost_msvc_dll\lib to PATH