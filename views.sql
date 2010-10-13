
CREATE OR REPLACE VIEW obj_h AS
	SELECT		o.obj_id,r.name AS class,object_name(o.obj_id) AS name,label,descr,
			create_time,update_time
	FROM		obj	o
	LEFT JOIN	ref	r ON r.obj_id=o.class_id
;

CREATE OR REPLACE VIEW ref_h AS
	SELECT		obj_id,_id,no,ref_full_name(obj_id) AS name,o.label
	FROM		ref	r
	LEFT JOIN	obj	o  USING (obj_id)
	ORDER BY	name
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

CREATE OR REPLACE VIEW prop_h AS
	SELECT		obj_id,no,class_full_name(p.class_id) AS class,name,ref_full_name(type_id) AS type,
			to_sign(is_t)||to_sign(is_n)||to_sign(is_s)||to_sign(is_r) AS TNSR,label,''''||def||'''' AS def
	FROM		prop	p
	LEFT JOIN	obj	o USING (obj_id)
	ORDER BY	class,no
;

CREATE OR REPLACE VIEW value_h AS
	SELECT		id,obj_id,prop_id,
			class_full_name(class_id)	AS class,
			object_name(obj_id)		AS name,
			prop_full_name(prop_id)		AS prop,
			no,value
	FROM		value	v
	LEFT JOIN	obj	o USING (obj_id)
	ORDER BY	class,name,prop,no
;

-- BLACKLIST
CREATE OR REPLACE VIEW blacklist_h AS
	SELECT		b.obj_id,t.name AS class,object_full_name(b.user_id) AS user,b.name,to_sign(b.for_myself) AS for_myself,o.label
	FROM		blacklist	b
	JOIN		obj		o ON o.obj_id=b.obj_id
	LEFT JOIN	ref		t ON t.obj_id=b.class_id
;

