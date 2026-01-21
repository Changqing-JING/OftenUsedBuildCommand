Optional for downloading module with llama-cli
```shell
sudo apt install libssl-dev
```

```shell
git clone https://github.com/ggml-org/llama.cpp.git
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Debug --parallel
```

