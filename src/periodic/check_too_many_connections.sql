SELECT      'REDALERT too many connections', count(*)
FROM        pg_stat_activity
HAVING      count(*) > 120
;
