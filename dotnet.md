```shell
mkdir dotnet
cd dotnet
git clone https://github.com/dotnet/roslyn.git
git clone https://github.com/dotnet/runtime.git
```

Build frontend compiler
```shell
cd roslyn
./restore.sh
./build.sh
```

Build runtime
```shell
cd runtime
./build.sh
```
