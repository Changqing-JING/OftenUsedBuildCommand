create a build config file `$HOME/mozconfigs/optimized` according to this doc
https://firefox-source-docs.mozilla.org/js/build.html#optimized-builds

```shell
git clone https://github.com/mozilla/gecko-dev.git
cd gecko-dev
export MOZCONFIG=$HOME/mozconfigs/optimized
./mach build
echo "export PATH=$(pwd)/obj-opt-x86_64-pc-linux-gnu/dist/bin:\$PATH" >> ~/.profile
source ~/.profile
```