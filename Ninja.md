## Install Ninja on ARM64 windows
```shell
git clone https://github.com/ninja-build/ninja.git
cd ninja
mkdir build
cd build
cmake -G "Visual Studio 17 2022" -A ARM64 -Bbuild-cmake ..
cmake --build build-cmake
```
Add ${workspace_abs_path}\build\build-cmake\Debug to PATH

## Install meson on ARM64 windows
Meson is a CPU independent python package
```
python -m pip install meson
```

```batch
"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" arm64
mkdir build
cd build
set CFLAGS="/std:c11"
set CXXFLAGS="/Zc:preprocessor"
meson setup ..
ninja test
```

```shell
mkdir build
cd build
CFLAGS="-march=armv8-a+simd" CXXFLAGS="-march=armv8-a+simd" meson setup ..
ninja test -k 100000 > simde_test_failed_on_windows_arm64.txt
```