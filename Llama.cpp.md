Optional for downloading module with llama-cli
```shell
sudo apt install libssl-dev
```

```shell
git clone https://github.com/ggml-org/llama.cpp.git
cd llama.cpp
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Debug --parallel
```

###### Run module on Windows
```
build-x64-windows-llvm-reldbg\bin\llama-cli.exe -m .\models\gemma-3-1b-it-Q4_K_M.gguf
```


###### Build for qnn
Note: must use `export` explicitly, don't use `cmake -D` to set the options
```shell
export ANDROID_ABI="arm64-v8a"
export CMAKE_TOOLCHAIN_FILE="/opt/android-ndk-r28b/build/cmake/android.toolchain.cmake"
export GGML_HEXAGON="ON"
export GGML_OPENCL="ON"
export GGML_OPENMP="OFF"
export HEXAGON_SDK_ROOT="/opt/hexagon/6.4.0.2"
cmake --preset arm64-android-snapdragon-release -B build-snapdragon
cmake --build build-snapdragon
cmake --install build-snapdragon --prefix pkg-adb/llama.cpp
```

###### Deploy and test on Samsung S25
```shell
adb push pkg-adb/llama.cpp/bin/llama-cli /data/local/tmp
adb shell 'chmod +x /data/local/tmp/llama-completion'
adb shell 'cd /data/local/tmp/ && curl -LO https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q4_0.gguf'
adb push pkg-adb
```

If the adb is very slow, pre-compiled binary can be downloaded from github
```shell
adb shell  'cd /data/local/tmp && curl -LO https://github.com/Changqing-JING/QualcommAILearn/releases/download/init/llama-cpp-lib.tar.gz && tar -xzf llama-cpp-lib.tar.gz'
adb shell  'cd /data/local/tmp && curl -LO https://github.com/Changqing-JING/QualcommAILearn/releases/download/init/llama-completion'
```

Run example
```shell
cd /data/local/tmp
export LD_LIBRARY_PATH=/data/local/tmp/pkg-adb/llama.cpp/lib &&export ADSP_LIBRARY_PATH=/data/local/tmp/pkg-adb/llama.cpp/lib
export GGML_HEXAGON_NDEV=1
./llama-completion -m ./Llama-3.2-1B-Instruct-Q4_0.gguf -ngl 99 --device HTP0 --no-mmap --ctx-size 8192 -no-cnv --perf -p "What's new in C++20?"
```

Perf data
```
mmon_perf_print:    sampling time =     400.20 ms
common_perf_print:    samplers time =     237.57 ms /  1166 tokens
common_perf_print:        load time =     971.88 ms
common_perf_print: prompt eval time =     170.42 ms /     9 tokens (   18.94 ms per token,    52.81 tokens per second)
common_perf_print:        eval time =   76130.10 ms /  1156 runs   (   65.86 ms per token,    15.18 tokens per second)
common_perf_print:       total time =   76849.02 ms /  1165 tokens
common_perf_print: unaccounted time =     148.29 ms /   0.2 %      (total - sampling - prompt eval - eval) / (total)
common_perf_print:    graphs reused =       1151
llama_memory_breakdown_print: | memory breakdown [MiB] | total   free    self   model   context   compute       unaccounted |
llama_memory_breakdown_print: |   - HTP0 (Hexagon)     |  2048 = 2048 + ( 504 =   504 +       0 +       0) + 17592186043912 |
llama_memory_breakdown_print: |   - Host               |                 1280 =   225 +     256 +     798                   |
```

