```shell
mkdir build
cd build
```

Build Arm64 Ubuntu22

```shell
# lld can't be used here
cmake  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt" -DCMAKE_BUILD_TYPE=Debug  -DCMAKE_C_COMPILER=clang-15 -DCMAKE_CXX_COMPILER=clang++-15   -DCOMPILER_RT_DEBUG=1 -G Ninja ../llvm
```

Build on mac
```
cmake  -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_BUILD_TYPE=Debug  -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -G Ninja ../llvm
```

Run test of clang-tidy
```shell
./build/bin/llvm-lit -vv clang-tools-extra/test/clang-tidy/checkers/misc/const-correctness*.cpp
```