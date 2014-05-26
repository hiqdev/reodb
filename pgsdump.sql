--- TABLES
SELECT 'TABLE' AS object, relname FROM pg_class WHERE relname NOT LIKE 'pg_%' AND relkind='r' ORDER BY relname;

--- VIEWS
SELECT      'VIEW' AS object, relname, md5(pg_get_viewdef(oid)) AS body
FROM        pg_class    c
WHERE       relname NOT LIKE 'pg_%' AND relkind='v'
ORDER BY    relname;

--- INDEXES
SELECT      'INDEX' AS object, c.relname AS index_name, c2.relname AS table_name
FROM        pg_class    c
LEFT JOIN   pg_index    i ON i.indexrelid=c.oid
LEFT JOIN   pg_class    c2 ON c2.oid=i.indrelid
WHERE       c.relname NOT LIKE 'pg_%' AND c.relkind='i'
ORDER BY    c2.relname, c.relname;

--- SERIALS
SELECT 'SEQUENCE' AS object, relname FROM pg_class WHERE relname NOT LIKE 'pg_%' AND relkind='S' ORDER BY relname;

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

--- UNIQUE INDEXES
SELECT      'UNIQUE INDEX' AS object, c.conname, c2.relname AS table_name
FROM        pg_constraint   c
LEFT JOIN   pg_class    c2 ON c2.oid=c.conrelid
WHERE       contype='u'
ORDER BY    c.conname;

--- FUNCTIONS
SELECT      'FUNCTION' AS obj,p.proname AS function_name,
            (SELECT cjoin(pg_typename(unnest)) FROM (SELECT unnest(p.proargtypes::integer[])) AS a) AS params,
            t.typname AS return_type,
            CASE WHEN p.proisstrict=TRUE THEN 'STRICT' ELSE 'CALLED ON NULL INPUT' END AS is_strict,
            CASE p.provolatile
                WHEN 'i' THEN 'IMMUTABLE'
                WHEN 's' THEN 'STABLE'
                WHEN 'v' THEN 'VOLATILE'
                ELSE '!!UNKNOWN!!'
            END AS depends,
            md5(p.prosrc) AS body_md5
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
ORDER BY    t.tgname, c.relname;

--- FIELDS
SELECT      'FIELD' AS obj, c.relname || '.' || a.attname AS column,
            t.typname AS type,
            CASE WHEN a.attnotnull THEN 'NOT NULL' ELSE 'NULL' END AS is_null,
            d.adsrc AS default_value
FROM        pg_class    c
LEFT JOIN   pg_attribute    a ON a.attrelid=c.oid AND a.attisdropped='f'
LEFT JOIN   pg_type     t ON t.oid=a.atttypid
LEFT JOIN   pg_attrdef  d ON d.adrelid=c.oid AND d.adnum=a.attnum
WHERE       c.relkind='r' AND c.relnamespace=(SELECT oid FROM pg_namespace WHERE nspname='public')
ORDER BY    c.relname,a.attname;

--- REFS
SELECT      'DATA:ref' AS obj,
            no,ref_full_name(obj_id) AS full_name,t.label,md5(dump_all_values(t.obj_id)) AS values
FROM        ref t
LEFT JOIN   obj o USING (obj_id)
ORDER BY    full_name;

--- PROPS
SELECT      'DATA:prop' AS obj,
            no,class_full_name(p.class_id) AS class,name AS prop,ref_full_name(type_id) AS type,
            to_sign(is_in_table)||to_sign(can_be_null)||to_sign(is_required)||to_sign(is_repeated) AS TNRR,label,dump_value(def) AS def
FROM        prop    p
LEFT JOIN   obj o USING (obj_id)
ORDER BY    class,no,prop;

