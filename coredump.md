Enable coredump

```shell
echo "|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E" > /proc/sys/kernel/core_pattern
ulimit -c unlimited
```

disable coredump

```shell
sudo su
echo core >/proc/sys/kernel/core_pattern
```

Debug the coredump

```shell
gdb path/to/my/executable path/to/core
```
