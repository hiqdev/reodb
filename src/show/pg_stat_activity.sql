SELECT		date_trunc('second',now()-query_start) AS duration,pid,query
FROM		pg_stat_activity
WHERE		query != '<IDLE>'
        AND state != 'idle'
        AND pid != pg_backend_pid()
ORDER BY	duration DESC
;
