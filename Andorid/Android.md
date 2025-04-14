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

Debug with vscode
lldbclient.py --setup-forwarding vscode-lldb --vscode-launch-file .vscode/launch.json --vscode-launch-props '{}' -r /vendor/bin/binderserver

```shell

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

```shell
adb push ./out/target/product/emu64x/system/app/SampleSystemApp/SampleSystemApp.apk /tmp
unzip SampleSystemApp.apk
dex2oat --dex-file=./classes.dex --oat-file=./classes.oat
adb pull /tmp/classes.oat ~/classes.oat
nm -C --defined-only ~/classes.oat
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

### Check android version

```shell
build/soong/soong_ui.bash --dumpvar-mode PLATFORM_VERSION
```

## Dump display layout

```shell
dumpsys SurfaceFlinger --list
adb shell dumpsys SurfaceFlinger
adb shell dmpsys activity
```

By default non root user can't cd to /sys/fs/bpf due to selinux policy

```shell
[53288.407529] type=1400 audit(1740706693.364:11): avc:  denied  { search } for  comm="sh" name="/" dev="bpf" ino=1 scontext=u:r:shell:s0 tcontext=u:object_r:fs_bpf:s0 tclass=dir permissive=0
```

Binder BPF tracepoints

```shell
emu64x:/sys/kernel/tracing/events/binder # ls
binder_alloc_lru_end     binder_return                             binder_transaction_update_buffer_release
binder_alloc_lru_start   binder_set_priority                       binder_txn_latency_free
binder_alloc_page_end    binder_transaction                        binder_unlock
binder_alloc_page_start  binder_transaction_alloc_buf              binder_unmap_kernel_end
binder_command           binder_transaction_buffer_release         binder_unmap_kernel_start
binder_free_lru_end      binder_transaction_failed_buffer_release  binder_unmap_user_end
binder_free_lru_start    binder_transaction_fd_recv                binder_unmap_user_start
binder_ioctl             binder_transaction_fd_send                binder_update_page_range
binder_ioctl_done        binder_transaction_node_to_ref            binder_wait_for_work
binder_lock              binder_transaction_received               binder_write_done
binder_locked            binder_transaction_ref_to_node            enable
binder_read_done         binder_transaction_ref_to_ref             filter
```

Generate compile commands

```shell
export SOONG_GEN_COMPDB=1
export SOONG_GEN_COMPDB_DEBUG=1
make nothing
```
