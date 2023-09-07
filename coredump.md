Enable coredump

```
|/usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E
```

disable coredump

```shell
sudo su
echo core >/proc/sys/kernel/core_pattern
```
