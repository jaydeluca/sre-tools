# Linux Commands

```bash
# Query contents of systemd journal (see why a service didn't start up) 
journalctl -xe
journalctl -xe -u nginx


# checking filesystem space usage
du -h / --max-depth=1


# identify disk space usage (not available on all distros)
ncdu -x /


# kill
sudo kill -9 {pid)


# grep current directory
grep -r 'myString' .
```