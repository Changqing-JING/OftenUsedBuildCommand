Doc https://nvidia.github.io/TensorRT-LLM/installation/build-from-source-linux.html#link-with-the-tensorrt-llm-c-runtime
```shell
sudo apt-get -y install git git-lfs
git lfs install
git clone https://github.com/NVIDIA/TensorRT-LLM.git
cd TensorRT-LLM
git switch release/1.2
git submodule update --init --recursive
git lfs pull
sudo apt install -y libnccl2 libnccl-dev tensorrt libzmq3-dev
sudo ln -s /usr/include /usr/lib/include
python -m venv venv
source venv/bin/activate
pip3 install nvidia-cutlass
python3 ./scripts/build_wheel.py --extra-cmake-vars "ENABLE_UCX=OFF" --cuda_architectures "89-real"
# note may need to adapt the 89-real according to hardware
```