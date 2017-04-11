SELECT		date_trunc('second',now()-query_start) AS duration,pid,query
FROM		pg_stat_activity
WHERE		query!='<IDLE>' AND state!='idle'
ORDER BY	duration DESC
;
