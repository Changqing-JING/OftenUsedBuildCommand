```shell
mkdir android-kernel && cd android-kernel
# repo init -u https://android.googlesource.com/kernel/manifest -b common-android-mainline
repo init -b common-android15-6.6
repo sync
tools/bazel run -c dbg  //common:kernel_x86_64_dist
tools/bazel run -c dbg  //common-modules/virtual-device:virtual_device_x86_64_dist
tools/bazel run -c dbg //common:kernel_x86_64_compile_commands
```

```shell
cd ~/workspace/github/Android/kernel/prebuilts
mkdir back

mv ./6.6/x86_64/* back/
cp ~/workspace/github/android-kernel/out/kernel_x86_64/dist/* ./6.6/x86_64/kernel-6.6
cp ./6.6/x86_64/bzImage ./6.6/x86_64/kernel-6.6

mkdir ~/workspace/github/Android/kernel/prebuilts/common-modules/virtual-device/6.6/x86-64-back
mv ~/workspace/github/Android/kernel/prebuilts/common-modules/virtual-device/6.6/x86-64/* ~/workspace/github/Android/kernel/prebuilts/common-modules/virtual-device/6.6/x86-64-back


cp ~/workspace/github/android-kernel/out/virtual_device_x86_64/dist/* ~/workspace/github/Android/kernel/prebuilts/common-modules/virtual-device/6.6/x86-64
```

```shell
m && emulator -writable-system -show-kernel -debug init -qemu -append "nokaslr" -s

```

Decompress kernel vmlinuz

1. list sections of vmlinuz

```shell
binwalk ./kernel-6.6

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
17092         0x42C4          LZ4 compressed data, legacy
2833079       0x2B3AB7        PGP RSA encrypted session key - keyid: 837E 741F9610 RSA (Encrypt or Sign) 1024b
10667732      0xA2C6D4        Base64 standard index table
13409813      0xCC9E15        xz compressed data
13917960      0xD45F08        SHA256 hash constants, little endian
17069028      0x10473E4       AES S-Box
17069284      0x10474E4       AES Inverse S-Box
17776145      0x10F3E11       LZ4 compressed data, legacy
17814549      0x10FD415       gzip compressed data, last modified: 2071-10-14 10:24:01 (bogus date)
20456513      0x1382441       LZ4 compressed data, legacy
20457206      0x13826F6       LZ4 compressed data, legacy

```

2. extract

```shell
dd if=./kernel-6.6 bs=1 skip=17092 | lz4 -d > vmlinux
```
