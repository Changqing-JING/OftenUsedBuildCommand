## Build cstest
Install deps
```shell
sudo apt-get install libcyaml-dev libyaml-dev libcmocka-dev
```


Add to cmake
```shell
-DCAPSTONE_BUILD_CSTEST=1
```

## Update capstone when LLVM td changed
```shell
cd ~/workspace/github/capstone/suite/auto-sync
pip install .
```

update the `{LLVM_ROOT}` in `suite/auto-sync/src/autosync/path_vars.json`

## Run test
```shell
cmake --build ./build/linux-x64 
./build/linux-x64/suite/cstest/Debug/cstest tests/MC/TriCore > build/log.txt
./build/linux-x64/suite/cstest/Debug/cstest tests/details/tricore.yaml 
```