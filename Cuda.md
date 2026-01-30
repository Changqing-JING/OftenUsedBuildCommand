Install nvidia driver need compiler
```shell
sudo apt install -y gcc g++ make cmake
```

```shell
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo apt install ./cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install -y nvidia-open
sudo apt install -y cuda-drivers
sudo apt install -y cuda-toolkit

echo 'export PATH=/usr/local/cuda-13.1/bin:$PATH' >> ~/.bashrc
```