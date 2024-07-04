SELECT      'REDALERT too long queries',
            date_trunc('second', now() - query_start) AS duration,
            date_trunc('second', query_start::timestamp) AS started,
            query
FROM        pg_stat_activity
WHERE       state != 'idle'
        AND query NOT LIKE 'autovacuum: VACUUM % (to prevent wraparound)'
        AND query NOT LIKE 'START_REPLICATION SLOT'
        AND query_start + '2minute' < now()
        AND query NOT IN (SELECT query FROM allowed_long_query)
ORDER BY    duration DESC
;
