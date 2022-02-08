# Networking

* [TCP dump tool](tcpdump.md)
* [Certificates & TLS (OpenSSL)](certs.md)

### DNS
```bash
# Get IP
dig google.com +short

# Get full trace
dig +trace google.com

# Get A records
nslookup google.com

# Name servers
nslookup -type=ns google.com

# All DNS records
nslookup -type=any google.com
```


### Netstat
```bash

# all active connections from all protocols
netstat -a

# all UDP ports
netstat -au

# TCP ports
netstat -at

# All listening ports
netstat -l

# All listening tcp ports
netstat -lt

# All listening udp ports
netstat -lu

# network statistics of interfaces
sudo netstat -s

# List all listening UNIX ports
sudo netstat -lx
```


### SS
```bash
# list all connections
ss

# listening sockets
ss -l

# show all tcp sockets with corresponding process
ss -tlp

# show all sockets connecting to a particular IP and port
ss -t dst 192.168.1.10:445

# Socket usage summary
ss -s
```