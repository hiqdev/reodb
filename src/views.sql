-- REF
CREATE OR REPLACE VIEW zref AS
    SELECT * FROM ref
;
CREATE OR REPLACE VIEW gref AS
    SELECT      zt.*,
                gt._id AS g_id,
                gt.name AS gname,
                gt.name||','||zt.name AS g2name
    FROM        zref    zt
    JOIN        zref    gt ON gt.obj_id = zt._id
;
CREATE OR REPLACE VIEW ref_h AS
    SELECT      obj_id,_id,no,ref_full_name(obj_id) AS name,r.label
    FROM        ref r
    ORDER BY    name
;

CREATE OR REPLACE VIEW class_h AS
    SELECT * FROM ref_h WHERE name like 'class%';
;

CREATE OR REPLACE VIEW type_h AS
    SELECT * FROM ref_h WHERE name like 'type%';
;

CREATE OR REPLACE VIEW state_h AS
    SELECT * FROM ref_h WHERE name like 'state%';
;

CREATE OR REPLACE VIEW ref_full_name AS
    WITH RECURSIVE cte AS (
        SELECT          z.obj_id, z._id, z.name, z.label, z.no, 0 as level, z._id as parent_id
        FROM            ref z
        LEFT OUTER JOIN ref o ON o._id = z.obj_id

        UNION

        SELECT          f.obj_id, f._id, z.name || ',' || f.name, f.label, f.no, f.level + 1, z._id as parent_id
        FROM            ref z
        INNER JOIN cte  f ON f.parent_id = z.obj_id AND f.parent_id != 0
    )
    SELECT  *
    FROM    cte
;

-- OBJ
CREATE OR REPLACE VIEW obj_h AS
    SELECT      o.obj_id, o.class_id, o.create_time, o.update_time,
                r.name AS class, o.name, o.label, o.descr
    FROM        obj     o
    LEFT JOIN   zref    r ON r.obj_id = o.class_id
;

-- PROP
CREATE OR REPLACE VIEW prop_h AS
    SELECT      p.obj_id,p.no,p.class_id,class_full_name(p.class_id) AS class,p.name,ref_full_name(p.type_id) AS type,
                to_sign(p.is_in_table)||to_sign(p.can_be_null)||to_sign(p.is_required)||to_sign(p.is_repeated) AS TNSR,
                o.label,''''||p.def||'''' AS def
    FROM        prop    p
    LEFT JOIN   obj     o ON o.obj_id=p.obj_id
    ORDER BY    class,no
;

-- VALUE
CREATE OR REPLACE VIEW value_h AS
    SELECT      v.id, v.obj_id, v.prop_id,
                class_full_name(o.class_id) AS class,
                obj_name(v.obj_id)          AS name,
                prop_full_name(v.prop_id)   AS prop,
                v.no, v.value
    FROM        value   v
    LEFT JOIN   obj     o ON o.obj_id = v.obj_id
;

-- PARAM
CREATE OR REPLACE VIEW paramz AS
    SELECT      v.id,v.obj_id,v.prop_id,p.name,v.value
    FROM        value   v
    JOIN        prop    p ON p.obj_id=v.prop_id
    WHERE       p.class_id=class_id('param')
;

-- STATUS
CREATE OR REPLACE VIEW statusz AS
    SELECT      s.*,coalesce(z.name||',','')||coalesce(y.name||',','')||x.name||','||t.name AS type
    FROM        status      s
    JOIN        ref     t ON t.obj_id=s.type_id
    JOIN        ref     x ON x.obj_id=t._id
    LEFT JOIN   ref     y ON y.obj_id=x._id AND y.obj_id!=0
    LEFT JOIN   ref     z ON z.obj_id=y._id AND z.obj_id!=0
;
CREATE OR REPLACE VIEW status_h AS
    SELECT      s.*,coalesce(o.name||',','')||coalesce(p.name||',','')||coalesce(q.name||',','')||r.name||','||t.name AS type
    FROM        status      s
    JOIN        ref     t ON t.obj_id=s.type_id
    LEFT JOIN   ref     r ON r.obj_id=t._id
    LEFT JOIN   ref     q ON q.obj_id=r._id AND q.obj_id!=0
    LEFT JOIN   ref     p ON p.obj_id=q._id AND p.obj_id!=0
    LEFT JOIN   ref     o ON o.obj_id=p._id AND o.obj_id!=0
;
CREATE OR REPLACE VIEW errors AS
    SELECT      s.object_id,cjoin(r.name) AS errors
    FROM        status      s
    JOIN        ref     r ON r.obj_id=s.type_id
    JOIN        ref     u ON u.obj_id=r._id AND ref_id('error') IN (u.obj_id,u._id)
    GROUP BY    s.object_id
;

--- TAG
CREATE OR REPLACE VIEW tag_h AS
    SELECT      x.*, o.name AS object, t.name AS tag
    FROM        tag         x
    LEFT JOIN   obj         o ON o.obj_id = x.obj_id
    LEFT JOIN   ref         t ON t.obj_id = x.tag_id
;

--- TIE
CREATE OR REPLACE VIEW tie_h AS
    SELECT      x.id,x.src_id,x.dst_id,x.tag_id,
                obj_full_name(x.src_id) AS src,
                t.name || ':' || o.name AS tag,
                obj_full_name(x.dst_id) AS dst
    FROM        tie         x
    LEFT JOIN   obj         o ON o.obj_id = x.tag_id
    LEFT JOIN   ref         t ON t.obj_id = o.class_id
;

