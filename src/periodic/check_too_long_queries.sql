SELECT      'REDALERT too long queries',
            date_trunc('second', query_start::timestamp) AS started,
            date_trunc('second', now() - query_start) AS duration,
            query
FROM        pg_stat_activity
WHERE       state != 'idle'
    AND     query_start + '2minute' < now()
    AND     query NOT IN (SELECT query FROM allowed_long_query)
ORDER BY	duration DESC
;
