SELECT		relname,relpages,reltuples
FROM		pg_class
WHERE		relname NOT LIKE 'pg_%'
ORDER BY	relpages DESC;

