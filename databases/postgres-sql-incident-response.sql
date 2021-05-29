-- Queries to help diagnose problems during incidents.


-- Find and Kill ----------------------------------------------------

-- Check for long running queries, update interval as needed
SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes';


-- Kill queries: substitute PID of query
SELECT pg_cancel_backend(__pid__);

-- this one should be a last resort, can cause db to restart
SELECT pg_terminate_backend(__pid__);



-- USERS -------------------------------------------------------------

-- all database users
SELECT * FROM pg_stat_activity WHERE current_query not like '<%';

-- all databases and their sizes
SELECT * FROM pg_user;



-- Table / Indexes ----------------------------------------------------

-- all databases and their sizes
SELECT * FROM pg_user;

-- all tables and their size, with/without indexes
SELECT datname, pg_size_pretty(pg_database_size(datname))
FROM pg_database
order by pg_database_size(datname) desc;

-- cache hit rates (should not be less than 0.99)
SELECT 
    sum(heap_blks_read) as heap_read, 
    sum(heap_blks_hit)  as heap_hit, 
    (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) as ratio
FROM pg_statio_user_tables;

-- table index usage rates (should not be less than 0.99)
SELECT relname, 100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used, n_live_tup rows_in_table
FROM pg_stat_user_tables 
ORDER BY n_live_tup DESC;

-- how many indexes are in cache
SELECT 
    sum(idx_blks_read) as idx_read, 
    sum(idx_blks_hit)  as idx_hit, 
    (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) as ratio
FROM pg_statio_user_indexes;



-- Locks ---------------------------------------------------------------

-- see what processes are blocking SQL statements (these only find row-level locks, not object-level locks).
SELECT a.datname,
         l.relation::regclass,
         l.transactionid,
         l.mode,
         l.GRANTED,
         a.usename,
         a.query,
         a.query_start,
         age(now(), a.query_start) AS "age",
         a.pid
FROM pg_stat_activity a
JOIN pg_locks l ON l.pid = a.pid
ORDER BY a.query_start;

-- blocked queries
select pid, 
       usename, 
       pg_blocking_pids(pid) as blocked_by, 
       query as blocked_query
from pg_stat_activity
where cardinality(pg_blocking_pids(pid)) > 0;