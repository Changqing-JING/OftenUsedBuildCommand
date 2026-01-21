Install nvidia driver need compiler
```
sudo apt install gcc g++ make cmake
```

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo apt install ./cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install nvidia-open
sudo apt install cuda-drivers
sudo apt install cuda-toolkit

echo 'export PATH=/usr/local/cuda-13.1/bin:$PATH' >> ~/.bashrc
```