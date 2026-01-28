## Instal NDK
### x86_64 Ubuntu
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

### arm64 Ubuntu
**Google doesn't provide official build of arm64 linux NDK and Android SDK**

```shell
sudo apt install -y unzip libpcre2-16-0 libpulse0 libxcb-cursor0 libxkbcommon-x11-0 xvfb libx11-6 libxext6 libxrender1

wget https://github.com/lzhiyong/termux-ndk/releases/download/android-sdk/android-sdk-aarch64.7z
wget https://github.com/lzhiyong/termux-ndk/releases/download/android-ndk/android-ndk-r29-aarch64.7z
wget -O /tmp/emulator.zip https://github.com/Changqing-JING/android-emulator-aarch64-linux/releases/download/v2.12.0-19097-g85fa07f04ef/sdk-repo-linux_aarch64-emulator-standalone-0.zip

sudo unzip -o /tmp/emulator.zip -d /opt/android-sdk/


 # Extract and install SDK
7z x android-sdk-aarch64.7z -o/tmp/android-sdk-extract
sudo rm -rf /opt/android-sdk
sudo mv /tmp/android-sdk-extract/android-sdk /opt/android-sdk

# Extract and install NDK
7z x android-ndk-r29-aarch64.7z -o/tmp/android-ndk-extract
sudo rm -rf /opt/android-ndk
sudo mv /tmp/android-ndk-extract/android-ndk-r29 /opt/android-ndk

# Add to ~/.bashrc
cat >> ~/.bashrc << 'EOF'
export ANDROID_HOME=/opt/android-sdk
export ANDROID_NDK_HOME=/opt/android-ndk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME
EOF
```



```shell
/opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --install "platform-tools"   
```



