# Java

## JVM Parameters for Garbage Collection
|   Option  |   Notes   |
|   --      |   --      |
|   `XX:+UseG1GC`   |   Choose G1GC as the collection strategy. Is the default for Java 9+    |
|   `-XX:+UseParallelGC`    |   This method uses parallel threads to speed up GC work, although it still stops the application threads like serial GC. It is best suited for high-throughput-centric applications where long pauses are acceptable  |
|   `-XX:MaxGCPauseMillis=<n>`    |   Limits the maximum pause time and reclaims the heap space; default for this depends on the GC, e.g., default value for G1 is 200 |
|   `-XX:GCTimeRatio=<n>` |   Sets the target ratio of GC time to the application time 1/ (1+nnn); n= 9 sets the ratio of 0.1 of total time for GC work |
|   `-Xms=<m>` & `-Xmx=<m>`  |  The (Xms)minimum and (Xmx)maximum heap size that your application can use; large heap size means longer GC pauses |
|   `-XX:ParallelGCThreads=<n>` |   Defines the number of threads to be used in parallel stages of GC   |
|   `-XX:ConcGCThreads=<n>` |   Configures the number of threads that concurrent GC is allowed to use; increasing the number of concurrent threads will speed up GC work    |
|   `-XX:InitiatingHeapOccupancyPercent=<n>`    |   Specifies the percentage of the heap occupation to trigger concurrent GC cycle; has a default value of 45   |




## Troubleshooting
Retrieve stack trace of a long running thread on a linux server:
```bash
# Find java PID
ps aux | grep java

# Pass in PID to see individual threads, look for long running
top -n 1 -H -p PID

# Take thread id and look at the jstack
jstack -F threadID

# It can be useful to dump the jstack contents into a file for further analysis
jstack -F threadID > threaddump.txt
```
