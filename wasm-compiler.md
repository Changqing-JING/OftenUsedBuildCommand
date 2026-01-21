## Build

### Arm64
Linux
```shell
cmake -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_WERROR=1 -DENABLE_FUZZ=1 -DENABLE_SPECTEST=1 -DTEST_VARIANTS=1 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ -DCMAKE_CROSSCOMPILING_EMULATOR=qemu-aarch64 ..
make -j $(nproc) && ctest --verbose
```

QNX
```shell
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/QNXArm64Toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=qcc -DCMAKE_C_COMPILER=qcc -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_WERROR=1 -DENABLE_SPECTEST=1 -DENABLE_DEMO=1 -DTEST_VARIANTS=1 -DDISABLE_SPECTEST_WAST=1 -DENABLE_FUZZ=1
```

Enable gdb server on QNX
Init before test
```shell
scp ./build_qnx_arm/bin/vb_spectest_json root@160.48.199.101:/tmp/vb_spectest_json
ssh root@160.48.199.101 "chmod +x /tmp/vb_spectest_json"
scp ./tests/testcases.json root@160.48.199.101:/tmp
ssh root@160.48.199.101 "qconn"
```

GDB shell
```shell
target qnx 160.48.199.101:8000
symbol-file ~/workspace/wasm-compiler/build_qnx_arm/bin/vb_spectest_json
set confirm off
run /tmp/vb_spectest_json /tmp/testcases.json
quit
```


### Tricore
```shell
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=$TRICORE_GCC_PATH/tricore-elf-gcc -DVB_ENABLE_DEV_FEATURE=OFF -DCMAKE_CXX_COMPILER=$TRICORE_GCC_PATH/tricore-elf-g++ -DENABLE_SPECTEST=1 -DENABLE_DEMO=1 -DTEST_VARIANTS=1 -DDISABLE_SPECTEST_WAST=1 -DDISABLE_SPECTEST_JSON=1 -DENABLE_STANDALONE_TEST=1 ..
make -j  $(nproc) && $TRICORE_QEMU_PATH/qemu-system-tricore -semihosting -display none -M tricore_tsim162 -kernel ./bin/vb_spectest_binary_standalone_0 && $TRICORE_QEMU_PATH/qemu-system-tricore -semihosting -display none -M tricore_tsim162 -kernel ./bin/vb_spectest_binary_standalone_1
```
GCC 11
```shell
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=/home/jcq/workspace/github/tricore/gcc11/tricore-gcc-toolchain/INSTALL/bin/tricore-elf-gcc -DVB_ENABLE_DEV_FEATURE=OFF -DCMAKE_CXX_COMPILER=/home/jcq/workspace/github/tricore/gcc11/tricore-gcc-toolchain/INSTALL/bin/tricore-elf-g++ -DENABLE_SPECTEST=1 -DENABLE_DEMO=1 -DTEST_VARIANTS=1 -DDISABLE_SPECTEST_WAST=1 -DDISABLE_SPECTEST_JSON=1 -DENABLE_STANDALONE_TEST=1 ..
```
#### Tasking
```shell
bazel build //demo:vb_demo --config=Tasking_warning_as_error --platforms=//bazel/platforms:tricore_tasking --action_env=TSK_LICENSE_SERVER=wlic01s1.muc:1890 --action_env=TSK_LICENSE_KEY_SW260800=ff44-e6e6-b2b2-44b3
```

### Windows
#### x86_64
##### active
```shell
cmake -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_WERROR=1 -A x64 -DENABLE_SPECTEST=1 -DENABLE_DEMO=1 -DTEST_VARIANTS=1 -DCMAKE_CXX_FLAGS="-DACTIVE_STACK_OVERFLOW_CHECK=1 -DLINEAR_MEMORY_BOUNDS_CHECKS=1 -DACTIVE_DIV_CHECK=1 -DNO_PASSIVE_PROTECTION_WARNING=1" ..
```

## Test
QNX ARM64
```
scp tests/testcases.json  root@160.48.199.101:/tmp
scp ./build_qnx_arm/bin/vb_spectest_json root@160.48.199.101:/tmp
```
https://www.qnx.com/developers/docs/6.5.0SP1.update/com.qnx.doc.neutrino_utilities/d/dumper.html

## Coverity
x86_64
```shell
cmake .. -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_ADVANCED_APIS=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=Release -DBACKEND=x86_64 && cov-build --dir=./coverity_out cmake --build . --parallel && cov-analyze --coding-standard-config=../autosarcpp14-wasm.config --strip-path=$(pwd)/../src --dir=./coverity_out --disable-default && cov-format-errors --dir ./coverity_out --emacs-style --exclude-files='(wasm-compiler/thirdparty/.*|/usr/.*)'
```

aarch64
```shell
cmake .. -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_ADVANCED_APIS=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=Release -DBACKEND=aarch64 && cov-build --dir=./coverity_out cmake --build . --parallel && cov-analyze --coding-standard-config=../autosarcpp14-wasm.config --strip-path=$(pwd)/../src --dir=./coverity_out --disable-default && cov-format-errors --dir ./coverity_out --emacs-style --exclude-files='(wasm-compiler/thirdparty/.*|/usr/.*)'
```

tricore

```shell
export CCACHE_DISABLE=1 
cmake .. -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_ADVANCED_APIS=ON -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_BUILD_TYPE=Release -DBACKEND=tricore && cov-build --dir=./coverity_out cmake --build . --parallel && cov-analyze --coding-standard-config=../autosarcpp14-wasm.config --strip-path=$(pwd)/../src --dir=./coverity_out --disable-default && cov-format-errors --dir ./coverity_out --emacs-style --exclude-files='(wasm-compiler/thirdparty/.*|/usr/.*)'
```

## Fuzz
Reproduce
Native
```shell
wat2wasm -o test.wasm test.wat && ./build/bin/vb_fuzz --reproduceWithModule ./test.wasm
```

AArch64 qemu
```
wat2wasm -o test.wasm test.wat && qemu-aarch64 -L /usr/aarch64-linux-gnu ./build_linux_arm/bin/vb_fuzz --reproduceWithModule ./test.wasm
```

Run Fuzz
```shell
sudo mkdir -p /dev/shm/wasm-fuzz
sudo chown jcq /dev/shm/wasm-fuzz
./build/bin/vb_fuzz /dev/shm/wasm-fuzz --exit-on-first-error --timeout 100000
```

## FileCheck
```shell
python scripts/test.py
```


## Compare function size
```shell
python ./scripts/warp_dump.py --target x86_64 --module  ~/workspace/wasm-compiler-benchmark/usecases/build_icon_charging-status-25_8.8.4_7fdae4aa865_2025-06-1221_46_48/charging_status_25.wasm > old.txt

python ./scripts/warp_dump.py --target x86_64 --module  ~/workspace/wasm-compiler-benchmark/usecases/build_icon_charging-status-25_8.8.4_7fdae4aa865_2025-06-1221_46_48/charging_status_25.wasm > new.txt
python ./scripts/cmpFunctionSize.py old.txt new.txt
```

## Demo
Tricore
```shell
$TRICORE_QEMU_PATH/qemu-system-tricore -semihosting -display none -M tricore_tsim162 -kernel build/cpp_demo.elf -s -S 
```

## Bench
```shell
cd build_bench
cmake -DCMAKE_BUILD_TYPE=Release -DVB_ENABLE_DEV_FEATURE=OFF -DENABLE_BENCH=1 -DCMAKE_CXX_FLAGS="-DINTERRUPTION_REQUEST=0 -DEAGER_ALLOCATION=1" ..
make -j $(nproc)
cd ..
python scripts/benchmark/run_bench.py -i ../wasm-compiler-benchmark -x ./build/bin/vb_bench
```

Show disassembly of v8
```shell
/home/jcq/workspace/github/v8/v8/out/x64.release/d8  --print-code --no-wasm-lazy-compilation --no-liftoff --single-threaded ./scripts/benchmark/util/d8_harness.js -- ./reg_detect.wasm
```

```shell
/home/jcq/workspace/github/v8/v8/out/x64.debug/d8 --code-comments  --print-code --no-wasm-lazy-compilation --no-liftoff --single-threaded ./scripts/benchmark/util/d8_harness.js -- ./reg_detect.wasm
```