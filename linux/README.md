# Linux

## Transfer Files
Use scp to transfer a file from a remote server to your local using SSH. 
[More Info](https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files/)


```bash
# Substitue for your key, username, IP, and file locations
scp -i ~/.ssh/id_rsa.pem ubuntu@10.0.0.1:/var/log/my-application/application.log application.log
```


## Process Management
```bash
# See what is running on a specific port
sudo lsof -i tcp:9000

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