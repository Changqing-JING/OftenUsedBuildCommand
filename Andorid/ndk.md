Instal NDK
```shell
sudo apt install openjdk-17-jdk wget cmake make

wget https://dl.google.com/android/repository/android-ndk-r27c-linux.zip

unzip android-ndk-*.zip -d /opt

mv /opt/android-ndk-r27c /opt/android-ndk
```

Install Android SDK
```shell
wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip

unzip commandlinetools-linux-*.zip -d /opt/android-sdk

mkdir -p /opt/android-sdk/cmdline-tools/latest

cp -r /opt/android-sdk/cmdline-tools/bin /opt/android-sdk/cmdline-tools/latest/bin
cp -r /opt/android-sdk/cmdline-tools/lib /opt/android-sdk/cmdline-tools/latest/lib

yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses 
```

Install and launch x86-64 emulator
```shell
/opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --install "emulator" "platform-tools" "system-images;android-35;google_apis;x86_64"   --proxy=http --proxy_host=127.0.0.1 --proxy_port=8080

/opt/android-sdk/cmdline-tools/latest/bin/avdmanager create avd -n x86_64_emulator -k "system-images;android-35;google_apis;x86_64" -d "pixel_6"  


/opt/android-sdk/emulator/emulator -avd x86_64_emulator -no-audio  -no-boot-anim -partition-size 2048 -gpu swiftshader_indirect -no-window 
```
Stop emulator
```shell
/opt/android-sdk/platform-tools/adb emu kill
```

Install and launch arm64 emulator
```shell
/opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --install "emulator" "platform-tools"   "system-images;android-35;google_apis;arm64-v8a"   --proxy=http --proxy_host=127.0.0.1 --proxy_port=8080

/opt/android-sdk/cmdline-tools/latest/bin/avdmanager create avd -n arm64_emulator -k "system-images;android-35;google_apis;arm64-v8a" -d "pixel_6"  

/opt/android-sdk/emulator/emulator -avd arm64_emulator -no-audio  -no-boot-anim -partition-size 2048 -gpu swiftshader_indirect -no-window 
```