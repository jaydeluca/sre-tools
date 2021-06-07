# TCPdump

## Install
| Distro  | Installation Command  |
| --      | --                    |
| CENT OS & Redhat  | `sudo yum install tcpdump`  |
| Fedora  | `dnf install tcpdump` |
| Ubuntu, Debian, Linux Mint  | `apt-get install tcpdump` |



## Useful commands
|   Command | Description |
| --        | --          |
| `tcpdump -D`  | Show available interfaces |
| `tcpdump -i any`  | Capture from all interfaces |
| `tcpdump -i eth0`  | Capture from a specific interface (Ex: Eth0) |
| `tcpdump -i eth0 -A` | Print in ASCII |
| `tcpdump -i eth0 -c 10 -w tcpdump.pcap tcp` | Capture TCP packets only  |
| `tcpdump -i eth0 port 80` | Capture from a defined port |
| `tcpdump host 192.168.1.100`  | Capture from a specific host  |
| `tcpdump net 10.1.1.0/16` | Capture from specific subnet  |
| `tcpdump src 10.1.1.100`  | Capture from specific source address  |
| `tcpdump dst 10.1.1.100`  | Capture from a specific destination address |
| `tcpdump http`  | Filter traffic based on a service |
| `tcpdump port 80` | Filter traffic based on a port  |