## Build AOSP on Ubuntu 24.04

```shell
repo sync -c -j8
source build/envsetup.sh
lunch sdk_phone64_x86_64-trunk_staging-userdebug
build_build_var_cache
sudo sysctl -w kernel.apparmor_restrict_unprivileged_unconfined=0
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
m
emulator -writable-system
```

Open shell by adb

```shell
source build/envsetup.sh && lunch sdk_phone64_x86_64-trunk_staging-userdebug
adb shell
```

### Copy executable file to emulator

```shell
adb root
adb remount
adb reboot
adb root && adb remount
adb push ./out/target/product/emu64x/system/bin/bpfprintfuser /system/bin
```

Note: first time remount call doesn't really remount, it just disable the dm-verify

```
$ adb remount
Successfully disabled verity
virtual bool android::fiemap::ImageManagerBinder::MapImageDevice(const std::string &, const std::chrono::milliseconds &, std::string *) binder returned: Failed to map
[libfs_mgr] could not map scratch image
Failed to allocate scratch on /data, fallback to use free space on super
Using overlayfs for /system
Using overlayfs for /vendor
Using overlayfs for /product
Using overlayfs for /system_dlkm
Using overlayfs for /system_ext
Verity disabled; overlayfs enabled.
Now reboot your device for settings to take effect

```

## Docs

[JNI](https://deriklpw.github.io/2018/09/03/Framework_jni_1/)
[BCC Reference](https://android.googlesource.com/platform/external/bcc/+/refs/heads/android10-c2f2-s1-release/docs/reference_guide.md)

## Debug with LLDB

```shell
lldbclient.py --port 5038 -r /system/bin/hello
settings set target.x86-disassembly-flavor intel
```

## show log of BPF loader

```shell
adb logcat | grep bpf
```

## Enable bpf tracing

```shell
echo 1 > /sys/kernel/tracing/tracing_on
```

## Install App

```shell
adb install -r ../../../out/target/product/emu64x/system/app/SampleSystemApp/SampleSystemApp.apk
```

## registerNativeMethods

```shell
~/workspace/github/Android/out/target/product/emu64x/system/lib64$ readelf -s -W --demangle ./libandroid_runtime.so | grep registerNativeMethods
  3252: 00000000000e9280     5 FUNC    GLOBAL DEFAULT   16 android::AndroidRuntime::registerNativeMethods(_JNIEnv*, char const*, JNINativeMethod const*, int)

```

## Get function address with dwarf

```shell
~/workspace/github/Android/out/target/product/emu64x/symbols/system/lib64$ nm -C --defined-only ./libhwui.so | grep android::CanvasJNI::drawTextString

0000000000203580 t android::CanvasJNI::drawTextString(_JNIEnv*, _jobject*, long, _jstring*, int, int, float, float, int, long) [clone .__uniq.217368827436880524487899401922132398377]

```

### Get input device name

```shell
cat /sys/class/input/event7/device/name
```
