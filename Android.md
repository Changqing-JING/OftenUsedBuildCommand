## Build AOSP on Ubuntu 24.04

```shell
repo sync -c -j8
source build/envsetup.sh
lunch sdk_phone64_x86_64-trunk_staging-userdebug
build_build_var_cache
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
m
emulator
```

Open shell by adb

```shell
source build/envsetup.sh && lunch sdk_phone64_x86_64-trunk_staging-userdebug
adb shell
```
