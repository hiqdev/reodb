WITH ps AS (
    SELECT      relname, relpages, reltuples, pg_table_size(relname::regclass) AS size
    FROM        pg_class        cl
    LEFT JOIN   pg_namespace    ns ON ns.oid = cl.relnamespace
    WHERE       nspname NOT IN ('information_schema')
            AND relname NOT LIKE 'pg_toast_%'
            AND relpersistence NOT IN ('t')
            AND relkind NOT IN ('v', 't')
)
    SELECT      'TOTAL' AS relname, sum(relpages) AS relpages, sum(reltuples) AS reltuples,
                pg_size_pretty(sum(size)) AS pretty_size,
                sum(size) AS size
    FROM        ps
UNION
    SELECT      relname, relpages, reltuples, pg_size_pretty(size) AS pretty_size, size
    FROM        ps
    ORDER BY    relpages DESC
;
