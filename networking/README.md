# Networking

* [TCP dump tool](tcpdump.md)
* [Certificates (OpenSSL)](certs.md)

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
