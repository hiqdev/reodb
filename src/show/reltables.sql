SELECT		relname,relpages,reltuples
FROM		pg_class
WHERE		relname NOT LIKE 'pg_%' AND relkind='r'
ORDER BY	relpages DESC
;
