## Install GTest
### Ubuntu
#### Local install
```shell
sudo apt install libgtest-dev
cd /usr/src/gtest
sudo cmake CMakeLists.txt
sudo make
cd lib
sudo cp *.a /usr/lib
```
#### Cross compile for ARM64
```shell
git clone https://github.com/google/googletest.git
cd googletest
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ -DCMAKE_INSTALL_PREFIX=install_path ..
cmake --build . --parallel
cmake --install .
```
### Macos
```shell
brew install googletest
```
### Windows
Install from source
```shell
git clone https://github.com/google/googletest.git
```
#### For x86_64 Windows
```bat
cd googletest
mkdir build_win
cd build_win
cmake -DCMAKE_INSTALL_PREFIX=install_path -Dgtest_force_shared_crt=ON  -A x64 ..
cmake --build .
cmake --install . --config Debug
```

#### gtest windows x86_64 clang:
```bat
cmake -DCMAKE_INSTALL_PREFIX=D:\install_path -DCMAKE_BUILD_TYPE=Debug -Dgtest_force_shared_crt=ON  -A x64 -T clang-cl ..
```

#### For ARM64 Windows
```bat
cd googletest
mkdir build_win_arm
cd build_win_arm
cmake -DCMAKE_INSTALL_PREFIX=install_path -Dgtest_force_shared_crt=ON  -A ARM64 ..
cmake --build .
cmake --install . --config Debug
```
add environment vairalbe key: GTEST_ROOT, value: install_path

### Release build on Windows
If the Generator is Ninja, use "DCMAKE_BUILD_TYPE=DEBUG"
If the Genertor is Visual Studio, DCMAKE_BUILD_TYPE will be ignored. Instead, it need to use --config Release during build. For example:
```shell
cmake --build . --config Release
```