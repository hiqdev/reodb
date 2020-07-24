SELECT      c.name, count(*)
FROM        obj         o
JOIN        zref        c ON c.obj_id = o.class_id
GROUP BY    c.name
ORDER BY    count DESC
;
