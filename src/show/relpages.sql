SELECT      relname, relpages, reltuples,
            pg_size_pretty(pg_table_size(relname::regclass)) AS size
FROM        pg_class        cl
LEFT JOIN   pg_namespace    ns ON ns.oid = cl.relnamespace
WHERE       nspname NOT IN ('information_schema')
        AND relname NOT LIKE 'pg_toast_%'
        AND relpersistence NOT IN ('t')
        AND relkind NOT IN ('v', 't')
ORDER BY    relpages DESC
;
