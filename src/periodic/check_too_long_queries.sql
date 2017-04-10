SELECT      'REDALERT too long queries', query_start, query
FROM        pg_stat_activity
WHERE       state!='idle'
    AND     query_start+'1minute'<now()
;
