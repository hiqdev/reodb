SELECT      relname, relpages, reltuples, relfilenode,
            pg_size_pretty(pg_table_size(ns.nspname||'.'||relname)) AS size
FROM        pg_class        cl
LEFT JOIN   pg_namespace    ns ON ns.oid = cl.relnamespace
WHERE       nspname NOT IN ('information_schema')
        AND relname NOT LIKE 'pg_toast_%'
        AND relpersistence NOT IN ('t')
        AND relkind = 'r'
ORDER BY    relpages DESC
;
