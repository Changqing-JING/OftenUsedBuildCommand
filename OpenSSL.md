## Build OpenSSL on Windows:

### Install Deps
1. Install perl, https://strawberryperl.com/, it's a windows perl with a lot of required dependencies
2. Install nasm https://www.nasm.us/

### Build OpenSSL for host
```bat
git clone https://github.com/openssl/openssl.git
git submodule update --init --recursive --progress
perl Configure VC-WIN64A --debug --prefix=D:\install_dir  --openssldir=D:\install_dir

nmake
#or use jom for parallel build https://wiki.qt.io/Jom
# set CL=/FS
# jom
nmake instal
```

### Windows ARM64 cross Build
```bat
nmake clean
"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsamd64_arm64.bat"
perl Configure VC-WIN64-ARM --debug --prefix=D:\openssl_arm  --openssldir=D:\openssl_arm
```