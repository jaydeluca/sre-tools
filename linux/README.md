# Linux

## Process Management
```bash
# Query contents of systemd journal (see why a service didn't start up) 
journalctl -xe
journalctl -xe -u nginx


# kill a process
sudo kill -9 {pid)
```


## CPU
```bash
# check cpu, ignore idle processes
top -i

# not always included out of the box, but nice
htop
```

## File System
```bash
# checking filesystem space usage
du -h / --max-depth=1


# identify disk space usage (not available on all distros)
ncdu -x /
```

## Search

```bash
# grep current directory
grep -r 'myString' .
```