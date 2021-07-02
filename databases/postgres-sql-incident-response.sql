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



-- USERS / CONNECTIONS -------------------------------------------------------------

-- active connections
SELECT pid AS process_id, 
       usename AS username, 
       datname AS database_name, 
       client_addr AS client_address, 
       application_name,
       backend_start,
       state,
       state_change
FROM pg_stat_activity;


-- all database users
SELECT * FROM pg_stat_activity WHERE current_query not like '<%';



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


-- Find missing indexes
SELECT
  relname,
  seq_scan - idx_scan AS too_much_seq,
  CASE
    WHEN seq_scan - coalesce(idx_scan, 0) > 0 THEN 'Missing Index ?'
    ELSE 'OK'
  END,
  pg_relation_size(relname::regclass) AS rel_size, 
  seq_scan, idx_scan
FROM pg_stat_all_tables

WHERE schemaname = 'public' AND pg_relation_size(relname::regclass) > 80000 
ORDER BY too_much_seq DESC;


-- Find missing indexes part II, an index is missing if both the second and third column are big
SELECT relname,
       seq_scan,
       seq_tup_read / seq_scan AS tup_per_scan
FROM pg_stat_user_tables
WHERE seq_scan > 0;


-- Return all non-system tables that are missing primary keys and have no unique indexes
SELECT c.table_schema, c.table_name, c.table_type
FROM information_schema.tables c
WHERE  c.table_schema NOT IN('information_schema', 'pg_catalog') AND c.table_type = 'BASE TABLE' 
AND NOT EXISTS(SELECT i.tablename  
				FROM pg_catalog.pg_indexes i 
			WHERE i.schemaname = c.table_schema 
				AND i.tablename = c.table_name AND indexdef LIKE '%UNIQUE%')
AND
NOT EXISTS (SELECT cu.table_name 
				FROM information_schema.key_column_usage cu
				WHERE cu.table_schema = c.table_schema AND
					cu.table_name = c.table_name)
ORDER BY c.table_schema, c.table_name;


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


-- Transaction IDs ----------------------------------------------------

-- https://blog.crunchydata.com/blog/managing-transaction-id-wraparound-in-postgresql
-- percent_towards_wraparound and percent_towards_emergency_autovac should be acted upon immediately (vacuums) if approaching 100% 
WITH max_age AS ( 
    SELECT 2000000000 as max_old_xid
        , setting AS autovacuum_freeze_max_age 
        FROM pg_catalog.pg_settings 
        WHERE name = 'autovacuum_freeze_max_age' )
, per_database_stats AS ( 
    SELECT datname
        , m.max_old_xid::int
        , m.autovacuum_freeze_max_age::int
        , age(d.datfrozenxid) AS oldest_current_xid 
    FROM pg_catalog.pg_database d 
    JOIN max_age m ON (true) 
    WHERE d.datallowconn ) 
SELECT max(oldest_current_xid) AS oldest_current_xid
    , max(ROUND(100*(oldest_current_xid/max_old_xid::float))) AS percent_towards_wraparound
    , max(ROUND(100*(oldest_current_xid/autovacuum_freeze_max_age::float))) AS percent_towards_emergency_autovac 
FROM per_database_stats