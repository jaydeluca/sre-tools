# Java

Identifying a deadlocked thread:
```bash
# Find java PID
ps aux grep java

# Pass in PID to see individual threads, look for long running
top -n 1 -H -p PID

# Take thread id and look at the jstack
jstack -F threadID

# It can be useful to dump the jstack contents into a file for further analysis
jstack -F threadID > threaddump.txt
```
