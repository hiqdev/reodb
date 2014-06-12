\timing off

--- SEQUENCES
SELECT 'SEQUENCE' AS object, relname FROM pg_class WHERE relname NOT LIKE 'pg_%' AND relkind='S' ORDER BY relname;

--- TABLES
SELECT 'TABLE' AS object, relname FROM pg_class WHERE relname NOT LIKE 'pg_%' AND relkind='r' ORDER BY relname;

--- FIELDS
SELECT      'FIELD' AS obj, c.relname || '.' || a.attname AS column,
            t.typname AS type,
            CASE WHEN a.attnotnull THEN 'NOT NULL' ELSE 'NULL' END AS is_null,
            d.adsrc AS default_value
FROM        pg_class        c
JOIN        pg_attribute    a ON a.attrelid=c.oid AND NOT a.attisdropped
JOIN        pg_type         t ON t.oid=a.atttypid AND t.typname NOT IN ('oid','cid','tid','xid')
LEFT JOIN   pg_attrdef      d ON d.adrelid=c.oid AND d.adnum=a.attnum
JOIN        pg_namespace    s ON s.oid=c.relnamespace AND s.nspname='public'
WHERE       c.relkind='r'
ORDER BY    c.relname,a.attname;

--- PRIMARY KEYS
SELECT      'PRIMARY KEY' AS object, c.conname, c2.relname AS table_name
FROM        pg_constraint   c
LEFT JOIN   pg_class    c2 ON c2.oid=c.conrelid
WHERE       contype='p'
ORDER BY    c.conname;

--- CHECKS
SELECT      'CHECK' AS object, c.conname AS name, c2.relname AS table_name
FROM        pg_constraint   c
LEFT JOIN   pg_class    c2 ON c2.oid=c.conrelid
WHERE       contype='c'
ORDER BY    c.conname;

--- FOREIGN KEYS
SELECT      'FOREIGN KEY' AS object, c.conname AS name, c2.relname AS table_name,
            ' ON DELETE ' || CASE c.confdeltype
                WHEN 'c' THEN 'CASCADE'
                WHEN 'r' THEN 'RESTRICT'
                WHEN 'a' THEN 'NO ACTION'
                WHEN 'n' THEN 'SET NULL'
                WHEN 'd' THEN 'SET DEFAULT'
                ELSE '!!UNKNOWN!!'
            END ||
            ' ON UPDATE ' || CASE c.confupdtype
                WHEN 'c' THEN 'CASCADE'
                WHEN 'r' THEN 'RESTRICT'
                WHEN 'a' THEN 'NO ACTION'
                WHEN 'n' THEN 'SET NULL'
                WHEN 'd' THEN 'SET DEFAULT'
                ELSE '!!UNKNOWN!!'
            END AS describe
FROM        pg_constraint   c
LEFT JOIN   pg_class    c2 ON c2.oid=c.conrelid
WHERE       contype='f'
ORDER BY    c.conname;

--- INDEXES
SELECT      'INDEX' AS object, rpad(c.relname,70,' ') AS index_name, c2.relname AS table_name
FROM        pg_class    c
LEFT JOIN   pg_index    i ON i.indexrelid=c.oid
LEFT JOIN   pg_class    c2 ON c2.oid=i.indrelid
WHERE       c.relname NOT LIKE 'pg_%' AND c.relkind='i'
ORDER BY    c2.relname, c.relname;

--- UNIQUE INDEXES
SELECT      'UNIQUE INDEX' AS object, rpad(c.conname,70,' ') AS index_name, c2.relname AS table_name
FROM        pg_constraint   c
LEFT JOIN   pg_class    c2 ON c2.oid=c.conrelid
WHERE       contype='u'
ORDER BY    c.conname;

--- FUNCTIONS
SELECT      'FUNCTION' AS obj,p.proname AS function_name,rpad(t.typname,20,' ') AS return_type,
            CASE WHEN p.proisstrict=TRUE THEN 'STRICT' ELSE 'CALLED ON NULL INPUT' END AS is_strict,
            CASE p.provolatile
                WHEN 'i' THEN 'IMMUTABLE'
                WHEN 's' THEN 'STABLE'
                WHEN 'v' THEN 'VOLATILE'
                ELSE '!!UNKNOWN!!'
            END AS depends,
            md5(regexp_replace(p.prosrc,E'\\s+','','g')) AS body_md5,
            (SELECT cjoin(pg_typename(unnest)) FROM (SELECT unnest(p.proargtypes::integer[])) AS a) AS params
FROM        pg_proc     p
JOIN        pg_type     t ON t.oid=p.prorettype
WHERE       p.pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public')
ORDER BY    p.proname, p.proargtypes, t.typname;

--- TRIGGERS
SELECT      'TRIGGER' AS object, tgname, tgtype,
            c.relname AS table, p.proname AS called_function
FROM        pg_trigger  t
JOIN        pg_class    c ON c.oid=t.tgrelid
JOIN        pg_proc     p ON p.oid=tgfoid
WHERE       p.pronamespace=(SELECT oid FROM pg_namespace WHERE nspname='public')
ORDER BY    c.relname, t.tgname;

--- VIEWS
SELECT      'VIEW' AS object, relname, md5(regexp_replace(pg_get_viewdef(oid),E'\\s+','','g')) AS body
FROM        pg_class    c
WHERE       relname NOT LIKE 'pg_%' AND relkind='v'
ORDER BY    relname;

--- REFS
SELECT      'REF' AS obj,
            '0' AS no,ref_full_name(obj_id) AS full_name,t.label,md5(dump_all_values(t.obj_id)) AS values
FROM        ref t
LEFT JOIN   obj o USING (obj_id)
ORDER BY    full_name;

--- PROPS
SELECT      'PROP' AS obj,
            p.no,class_full_name(p.class_id) AS class,p.name AS prop,ref_full_name(type_id) AS type,
            to_sign(is_in_table)||to_sign(can_be_null)||to_sign(is_required)||to_sign(is_repeated) AS TNRR,o.label,dump_value(def) AS def
FROM        prop    p
LEFT JOIN   obj     o ON o.obj_id=p.obj_id
JOIN        ref     c ON c.obj_id=p.class_id AND c.name NOT IN ('param')
ORDER BY    class,no,prop;

--- SOFTS
SELECT      'SOFT' AS obj,f.name,f.no,y.name||','||t.name AS type,z.name AS state
FROM        soft    f
JOIN        ref     t ON t.obj_id=f.type_id
JOIN        ref     y ON y.obj_id=t._id
JOIN        ref     z ON z.obj_id=f.state_id
ORDER BY    f.name,f.no
;

