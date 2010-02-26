-- $Header: /home/sol/usr/cvs/reodb/functions.sql,v 1.3 2007/08/31 11:16:18 sol Exp $

-- REPLACE
CREATE TYPE replace_data AS (keys text,vals text,sets text);
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value integer) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE $1.keys||','||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE $1.vals||','||$3 END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value boolean) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE $1.keys||','||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE $1.vals||','||$3::text END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value text) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE $1.keys||','||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE $1.vals||','||quote_literal($3) END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value timestamp) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE $1.keys||','||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE $1.vals||','||quote_literal($3::text) END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

-- DIFF
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text) RETURNS text AS $$
	SELECT CASE WHEN length($1)>0 THEN $1 ELSE $2 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text) RETURNS text AS $$
	SELECT	CASE WHEN length($1)>0 THEN $1 ELSE
		CASE WHEN length($2)>0 THEN $2 ELSE $3
	END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text) RETURNS text AS $$
	SELECT	CASE WHEN length($1)>0 THEN $1 ELSE
		CASE WHEN length($2)>0 THEN $2 ELSE
		CASE WHEN length($3)>0 THEN $3 ELSE $4
	END END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text,a_5 text) RETURNS text AS $$
	SELECT	CASE WHEN length($1)>0 THEN $1 ELSE
		CASE WHEN length($2)>0 THEN $2 ELSE
		CASE WHEN length($3)>0 THEN $3 ELSE
		CASE WHEN length($4)>0 THEN $4 ELSE $5
	END END END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonzero (a_1 integer,a_2 integer) RETURNS integer AS $$
	SELECT CASE WHEN $1>0 THEN $1 ELSE $2 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_strpos (haystack text,needle text,previous integer) RETURNS integer AS $$
	SELECT CASE WHEN strpos($1,$2)>0 THEN $3+last_strpos(substr($1,strpos($1,$2)+1),$2,strpos($1,$2)) ELSE $3 END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION last_strpos (haystack text,needle text) RETURNS integer AS $$
	SELECT CASE WHEN strpos($1,$2)>0 THEN last_strpos(substr($1,strpos($1,$2)+1),$2,strpos($1,$2)) ELSE 0 END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ucf (text) RETURNS text AS $$
	SELECT upper(substr($1,1,1))||substr($1,2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_html (text) RETURNS text AS $$
        SELECT replace(replace(replace($1,'>','&gt;'),'<','&lt;'),E'\n','<br>');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION genpass (length integer) RETURNS text AS $$
	SELECT substr(encode(decode(md5(random()::text),'hex'),'base64'),1,$1);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION genpass () RETURNS text AS $$
	SELECT substr(encode(decode(md5(random()::text),'hex'),'base64'),1,10);
$$ LANGUAGE sql VOLATILE STRICT;

--CREATE OR REPLACE FUNCTION last_strpos (haystack text,needle char) RETURNS integer AS
--	'/www/rcp3/src/sql/last_strpos','last_strpos'
--LANGUAGE c IMMUTABLE STRICT;

----------------------------
-- TO BOOL
----------------------------
CREATE OR REPLACE FUNCTION to_bool (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN 'TRUE' ELSE 'FALSE' END;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- GET OBJECT CLASS/STATE
----------------------------
CREATE OR REPLACE FUNCTION get_obj_class_id (a_obj_id integer) RETURNS integer AS $$
	SELECT class_id FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_class (a_obj_id integer) RETURNS text AS $$
	SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_state_id (a_obj_id integer) RETURNS integer AS $$
DECLARE
	res integer;
BEGIN
	EXECUTE 'SELECT state_id FROM '|| (
		SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=a_obj_id)
	) ||' WHERE obj_id='||a_obj_id INTO res;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_state (a_obj_id integer) RETURNS text AS $$
DECLARE
	res text;
BEGIN
	EXECUTE 'SELECT name FROM ref WHERE obj_id=(SELECT state_id FROM '|| (
		SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=a_obj_id)
	) ||' WHERE obj_id='||a_obj_id||')' INTO res;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

----------------------------
-- GET/SET OBJECT LABEL/DESCR
----------------------------
CREATE OR REPLACE FUNCTION get_obj_label (a_obj_id integer) RETURNS text AS $$
	SELECT label FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_descr (a_obj_id integer) RETURNS text AS $$
	SELECT descr FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_obj_label (a_obj_id integer,a_label text) RETURNS void AS $$
	UPDATE obj SET label=coalesce($2,'') WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_obj_label (a_obj_id integer,a_label text,a_descr text) RETURNS void AS $$
	UPDATE obj SET label=coalesce($2,''),descr=coalesce($3,'') WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_obj_descr (a_obj_id integer,a_descr text) RETURNS void AS $$
	UPDATE obj SET descr=coalesce($2,'') WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

----------------------------
-- GET/SET OBJECT CREATE/UPDATE TIME
----------------------------
CREATE OR REPLACE FUNCTION get_obj_create_time (a_obj_id integer) RETURNS timestamp AS $$
	SELECT create_time FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_update_time (a_obj_id integer) RETURNS timestamp AS $$
	SELECT update_time FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_obj_create_time (a_obj_id integer,a_create_time timestamp) RETURNS void AS $$
	UPDATE obj SET create_time=$2 WHERE obj_id = $1;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_obj_update_time (a_obj_id integer,a_update_time timestamp) RETURNS void AS $$
	UPDATE obj SET update_time=$2 WHERE obj_id = $1;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- REF
----------------------------
CREATE OR REPLACE FUNCTION top_ref_id (a_ref text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$1 AND _id=0;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (a_ref text,a_id integer) RETURNS integer AS $$
DECLARE
	pos integer := strpos(a_ref,',');
BEGIN
	RETURN CASE WHEN pos=0
		THEN ref_id(a_id,a_ref)
		ELSE ref_id(substr(a_ref,pos+1),ref_id(a_id,substr(a_ref,0,pos)))
	END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (text) RETURNS integer AS $$
	SELECT ref_id($1,0);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (integer,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id($1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (text,text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$3 AND _id=ref_id($1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent_id integer,a_1 text,a_2 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=$1 AND name IN ($2,$3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_1 text,a_2 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1) AND name IN ($2,$3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_1 text,a_2 text,a_3 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1) AND name IN ($2,$3,$4);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_1 text,a_2 text,a_3 text,a_4 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1) AND name IN ($2,$3,$4,$5);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_name (integer) RETURNS text AS $$
	SELECT name FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_full_name (integer) RETURNS text AS $$
	SELECT CASE WHEN _id=0 THEN name ELSE ref_full_name(_id)||','||name END
	FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_full_name (integer,integer) RETURNS text AS $$
	SELECT CASE WHEN _id=0 OR _id=$2 THEN name ELSE ref_full_name(_id)||','||name END
	FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_ref (a_no integer,a_ref text,a_label text,a_descr text) RETURNS integer AS $$
DECLARE
	the_id	integer := ref_id(a_ref);
	pos	integer;
BEGIN
	IF the_id IS NULL THEN
		the_id	:= nextval('id');
		pos	:= last_strpos(a_ref,',');
		INSERT INTO ref (obj_id,_id,name,no) VALUES (the_id,ref_id(substr(a_ref,0,pos)),substr(a_ref,pos+1),a_no);
	ELSE
		UPDATE ref SET no=a_no WHERE obj_id=the_id;
	END IF;
	IF a_label IS NOT NULL THEN
		PERFORM set_obj_label(the_id,a_label);
	END IF;
	IF a_descr IS NOT NULL THEN
		PERFORM set_obj_descr(the_id,a_descr);
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_ref (a_no integer,a_ref text,a_label text) RETURNS integer AS $$
	SELECT set_ref($1,$2,$3,NULL);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_ref (a_ref text,a_label text) RETURNS integer AS $$
	SELECT set_ref(0,$1,$2,NULL);
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- CLASS
----------------------------
-- XXX NOTICE: top_ref_id('class') = 1
CREATE OR REPLACE FUNCTION class_id (text) RETURNS integer AS $$
	SELECT CASE WHEN $1='class' THEN 1 ELSE ref_id($1,1) END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION class_id (text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('class',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION class_id (text,text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$3 AND _id=ref_id('class',$1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION class_id (text,text,text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$4 AND _id=class_id($1,$2,$3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION class_full_name (integer) RETURNS text AS $$
	SELECT ref_full_name($1,1);
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- SCALAR
----------------------------
CREATE OR REPLACE FUNCTION scalar_id (text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('scalar'));
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- TYPE
----------------------------
CREATE OR REPLACE FUNCTION type_id (a_ref text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('type'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_id (a_parent text,a_ref text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('type',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_id (a_grandparent text,a_parent text,a_ref text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$3 AND _id=ref_id('type',$1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_ids (a_parent text,a_1 text,a_2 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=type_id($1) AND name IN ($2,$3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_ids (a_parent text,a_1 text,a_2 text,a_3 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=type_id($1) AND name IN ($2,$3,$4);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_ids (a_parent text,a_1 text,a_2 text,a_3 text,a_4 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=type_id($1) AND name IN ($2,$3,$4,$5);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT ref_full_name($1,top_ref_id('type'));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- STATE
----------------------------
CREATE OR REPLACE FUNCTION state_id (text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('state'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_id (text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('state',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_full_name (integer) RETURNS text AS $$
	SELECT ref_full_name($1,top_ref_id('state'));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- STATUS
----------------------------
CREATE OR REPLACE FUNCTION status_id (text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('status'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION status_id (text,text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('status',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION status_full_name (integer) RETURNS text AS $$
	SELECT ref_full_name($1,top_ref_id('status'));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- PROP
----------------------------
CREATE OR REPLACE FUNCTION prop_id (a_prop text) RETURNS integer AS $$
DECLARE
	pos integer;
BEGIN
	pos := position(':' in a_prop);
	RETURN	obj_id FROM prop
	WHERE	name = substr(a_prop,pos+1) AND
		CASE	WHEN pos=0 THEN TRUE
			ELSE class_id=class_id(substr(a_prop,0,pos))
		END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_id (integer,text) RETURNS integer AS $$
	SELECT obj_id FROM prop WHERE name = $2 AND class_id = $1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_id (text,text) RETURNS integer AS $$
	SELECT obj_id FROM prop WHERE name = $2 AND class_id = class_id($1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_name (integer) RETURNS text AS $$
	SELECT name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_prop (integer) RETURNS text AS $$
	SELECT ref_name(class_id)||':'||name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION prop_full_name (integer) RETURNS text AS $$
	SELECT class_full_name(class_id)||':'||name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION replace_prop (
	a_obj_id	integer,	-- $1
	a_class_id	integer,	-- $2
	a_name		text,		-- $3
	a_type_id	integer,	-- $4
	a_no		integer,	-- $5
	a_def		text,		-- $6
	a_is_t		boolean,	-- $7
	a_is_n		boolean,	-- $8
	a_is_s		boolean,	-- $9
	a_is_r		boolean,	-- $10
	a_label		text		-- $11
) RETURNS integer AS $$
DECLARE
	the_id	integer := coalesce(a_obj_id,nextval('id'));
	prep	replace_data;
BEGIN
	prep := ('obj_id',the_id::text,NULL);
	prep := prepare_replace(prep,'class_id',	a_class_id);
	prep := prepare_replace(prep,'name',		a_name);
	prep := prepare_replace(prep,'type_id',		a_type_id);
	prep := prepare_replace(prep,'no',		a_no);
	prep := prepare_replace(prep,'def',		a_def);
	prep := prepare_replace(prep,'is_t',		a_is_t);
	prep := prepare_replace(prep,'is_n',		a_is_n);
	prep := prepare_replace(prep,'is_s',		a_is_s);
	prep := prepare_replace(prep,'is_r',		a_is_r);
	IF NOT EXISTS (SELECT 1 FROM prop WHERE obj_id=the_id) THEN
		EXECUTE 'INSERT INTO prop ('||prep.keys||') VALUES ('||prep.vals||')';
	ELSE
		EXECUTE 'UPDATE prop SET '||prep.sets||' WHERE obj_id='||the_id;
	END IF;
	IF a_label IS NOT NULL THEN
		PERFORM set_obj_label(the_id,a_label);
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_prop (
	a_no		integer,	-- $1
	a_prop		text,		-- $2
	a_type_id	integer,	-- $3
	a_label		text,		-- $4
	a_def		text,		-- $5
	a_is_t		boolean,	-- $6
	a_is_n		boolean,	-- $7
	a_is_s		boolean,	-- $8
	a_is_r		boolean		-- $9
) RETURNS integer AS $$
	SELECT replace_prop(prop_id($2),class_id(substr($2,0,strpos($2,':'))),substr($2,strpos($2,':')+1),$3,$1,$5,$6,$7,$8,$9,$4);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_prop (a_no integer,a_prop text,a_type_id integer,a_label text,a_def text) RETURNS integer AS $$
	SELECT set_prop($1,$2,$3,$4,$5,null,null,null,null);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_prop (a_no integer,a_prop text,a_type_id integer,a_label text) RETURNS integer AS $$
	SELECT set_prop($1,$2,$3,$4,null,null,null,null,null);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_prop (a_prop text,a_type_id integer,a_label text) RETURNS integer AS $$
	SELECT set_prop(null,$1,$2,$3,null,null,null,null,null);
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- IS SET VALUE
----------------------------
CREATE OR REPLACE FUNCTION is_set_value (integer,integer) RETURNS boolean AS $$
	SELECT EXISTS (SELECT 1 FROM value WHERE obj_id = $1 AND prop_id = $2);
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- GET VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_value (integer,integer) RETURNS text AS $$
	SELECT coalesce(
		(SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 ORDER BY no DESC LIMIT 1),
		(SELECT def FROM prop WHERE obj_id = $2)
	)
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_non_def (integer,integer) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 ORDER BY no DESC LIMIT 1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_values (integer,integer) RETURNS SETOF text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 ORDER BY no ASC;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (integer,text) RETURNS text AS $$
	SELECT coalesce(
		(SELECT value FROM value WHERE obj_id = $1 AND prop_id = prop_id($2) ORDER BY no DESC LIMIT 1),
		(SELECT def FROM prop WHERE obj_id = prop_id($2))
	)
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_non_def (integer,text) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = prop_id($2) ORDER BY no DESC LIMIT 1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (integer,text,text) RETURNS text AS $$
	SELECT coalesce(
		(SELECT value FROM value WHERE obj_id = $1 AND prop_id = prop_id($2,$3) ORDER BY no DESC LIMIT 1),
		(SELECT def FROM prop WHERE obj_id = prop_id($2,$3))
	);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_non_def (integer,text,text) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = prop_id($2,$3) ORDER BY no DESC LIMIT 1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_by_no (integer,integer,integer) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 AND no = $3;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- GET TEXT VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_text_value (a_obj_id integer,a_prop_id integer) RETURNS text AS $$
	SELECT coalesce(get_value($1,$2),'');
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_text_value (a_obj_id integer,a_prop text) RETURNS text AS $$
	SELECT coalesce(get_value($1,$2),'');
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_text_value (a_obj_id integer,a_prop text,a_default text) RETURNS text AS $$
	SELECT coalesce(get_value($1,$2),$3);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_text_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS text AS $$
	SELECT coalesce(get_value_by_no($1,$2,$3),'');
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

----------------------------
-- GET INTEGER VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_integer_value (a_obj_id integer,a_prop_id integer) RETURNS integer AS $$
	SELECT coalesce(get_value($1,$2)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_integer_value (a_obj_id integer,a_prop text) RETURNS integer AS $$
	SELECT coalesce(get_value($1,$2)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_integer_value (a_obj_id integer,a_class text,a_prop text) RETURNS integer AS $$
	SELECT coalesce(get_value($1,$2,$3)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_integer_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS integer AS $$
	SELECT coalesce(get_value_by_no($1,$2,$3)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

----------------------------
-- GET DOUBLE VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_double_value (a_obj_id integer,a_prop_id integer) RETURNS double precision AS $$
	SELECT coalesce(get_value($1,$2)::double precision, 0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_double_value (a_obj_id integer,a_prop text) RETURNS double precision AS $$
	SELECT coalesce(get_value($1,$2)::double precision, 0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_double_value (a_obj_id integer,a_class text,a_prop text) RETURNS double precision AS $$
	SELECT coalesce(get_value($1,$2,$3)::double precision, 0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_double_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS double precision AS $$
	SELECT coalesce(get_value_by_no($1,$2,$3)::double precision, 0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

----------------------------
-- SET VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop_id integer,a_value text) RETURNS void AS $$
DECLARE
	the_id	integer;
	the_def	text;
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) AND EXISTS (SELECT 1 FROM prop WHERE obj_id=a_prop_id) THEN
		SELECT INTO the_id id FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id ORDER BY no ASC LIMIT 1;
		SELECT INTO the_def def FROM prop WHERE obj_id=a_prop_id;
		IF the_def=a_value THEN
			IF the_id IS NOT NULL THEN
				DELETE FROM value WHERE id=the_id;
			END IF;
		ELSIF the_id IS NOT NULL THEN
			UPDATE value SET value=a_value WHERE id=the_id;
		ELSE
			INSERT INTO value (obj_id,prop_id,value) VALUES (a_obj_id,a_prop_id,a_value);
		END IF;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	PERFORM set_value(a_obj_id,prop_id(a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop text,a_value integer) RETURNS void AS $$
BEGIN
	PERFORM set_value(a_obj_id,prop_id(a_prop),a_value::text);
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_class text,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	PERFORM set_value(a_obj_id,prop_id(a_class,a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE;
CREATE OR REPLACE FUNCTION set_value_if_not (a_obj_id integer,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM value WHERE obj_id=a_obj_id AND prop_id=prop_id(a_prop)) THEN
		PERFORM set_value(a_obj_id,a_prop,a_value);
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer,a_value text) RETURNS void AS $$
DECLARE
	the_id	integer;
	the_def	text;
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id AND no=a_no;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) AND EXISTS (SELECT 1 FROM prop WHERE obj_id=a_prop_id) THEN
		SELECT INTO the_id id FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id AND no=a_no;
		SELECT INTO the_def def FROM prop WHERE obj_id=a_prop_id;
		IF the_def=a_value THEN
			IF the_id IS NOT NULL THEN
				DELETE FROM value WHERE id=the_id;
			END IF;
		ELSIF the_id IS NOT NULL THEN
			UPDATE value SET value=a_value WHERE id=the_id;
		ELSE
			INSERT INTO value (obj_id,prop_id,no,value) VALUES (a_obj_id,a_prop_id,a_no,a_value);
		END IF;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_values (a_obj_id integer,a_prop_id integer,a_values text) RETURNS void AS $$
BEGIN
	PERFORM delete_value(a_obj_id,a_prop_id),add_values(a_obj_id,a_prop_id,a_values);
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_values (a_obj_id integer,a_prop text,a_values text) RETURNS void AS $$
BEGIN
	PERFORM set_values(a_obj_id,prop_id(a_prop),a_values);
END;
$$ LANGUAGE plpgsql VOLATILE;

----------------------------
-- DELETE VALUE
----------------------------
CREATE OR REPLACE FUNCTION delete_value (a_obj_id integer,a_prop_id integer) RETURNS void AS $$
	DELETE FROM value WHERE obj_id = $1 AND prop_id = $2;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION delete_value (a_obj_id integer,a_prop text) RETURNS void AS $$
	DELETE FROM value WHERE obj_id = $1 AND prop_id = prop_id($2);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION delete_value (a_obj_id integer,a_class text,a_prop text) RETURNS void AS $$
	DELETE FROM value WHERE obj_id = $1 AND prop_id = prop_id($2,$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION delete_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS void AS $$
	DELETE FROM value WHERE obj_id = $1 AND prop_id = $2 AND no = $3;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- ADD/INSERT VALUE
----------------------------
CREATE OR REPLACE FUNCTION add_value (integer,integer,text) RETURNS void AS $$
	INSERT INTO value (obj_id,prop_id,value,
		no
	) VALUES ($1,$2,$3,
		(SELECT coalesce(max(no),0)+1 FROM value WHERE obj_id = $1 AND prop_id = $2)
	);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_value (a_obj_id integer,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	PERFORM add_value(a_obj_id,prop_id(a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_values (a_obj_id integer,a_prop_id integer,a_values text) RETURNS void AS $$
DECLARE
	the_pos		integer;
	the_value	text;
BEGIN
	the_pos := strpos(a_values,',');
	IF the_pos > 0 THEN
		PERFORM add_values(a_obj_id,a_prop_id,substr(a_values,the_pos+1));
		the_value	:= btrim(substr(a_values,0,the_pos));
	ELSE
		the_value	:= btrim(a_values);
	END IF;
	IF length(the_value) > 0 THEN
		PERFORM add_value(a_obj_id,a_prop_id,the_value);
	END IF;
END
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_values (a_obj_id integer,a_prop text,a_values text) RETURNS void AS $$
BEGIN
	PERFORM add_values(a_obj_id,prop_id(a_prop),a_values);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION insert_value (integer,integer,text) RETURNS void AS $$
	UPDATE value SET no=no+1 WHERE obj_id = $1 AND prop_id = $2;
	INSERT INTO value (obj_id,prop_id,value,no) VALUES ($1,$2,$3,0);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION insert_value (a_obj_id integer,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	PERFORM insert_value(a_obj_id,prop_id(a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

----------------------------
-- IN VALUES
----------------------------
CREATE OR REPLACE FUNCTION in_values (a_obj_id integer,a_prop_id integer,a_value text) RETURNS boolean AS $$
	SELECT CASE WHEN EXISTS (SELECT 1 FROM value WHERE obj_id=$1 AND prop_id=$2 AND value=$3)
	THEN TRUE ELSE FALSE END;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION in_values (a_obj_id integer,a_prop text,a_value text) RETURNS boolean AS $$
	SELECT CASE WHEN EXISTS (SELECT 1 FROM value WHERE obj_id=$1 AND prop_id=prop_id($2) AND value=$3)
	THEN TRUE ELSE FALSE END;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- HIERARCHY VALUES
----------------------------
CREATE OR REPLACE FUNCTION find_obj_in_hierarchy (a_obj_id integer,a_prop_id integer,a_path text) RETURNS integer AS $$
DECLARE
	field		text;
	class		text;
	next_path	text;
	pos		integer := 0;
	n_obj_id	integer;
BEGIN
	IF is_set_value(a_obj_id,a_prop_id) THEN
		RETURN a_obj_id;
	ELSE
		IF length(a_path)>0 THEN
			pos := strpos(a_path,',');
			IF pos=0 THEN
				field := a_path;
			ELSE
				field := substr(a_path,0,pos);
			END IF;
			class := get_obj_class(a_obj_id);
			EXECUTE 'SELECT '||field||' FROM '||class||' WHERE obj_id='||a_obj_id INTO n_obj_id;
		END IF;
		IF pos>0 THEN
			next_path := substr(a_path,pos+1);
			IF next_path='...' THEN
				next_path := a_path;
			END IF;
			RETURN find_obj_in_hierarchy(n_obj_id,a_prop_id,next_path);
		ELSE
			IF is_set_value(n_obj_id,a_prop_id) THEN
				RETURN n_obj_id;
			ELSE
				RETURN client_id('bullet');
			END IF;
		END IF;
	END IF;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_value (a_obj_id integer,a_prop_id integer,a_path text) RETURNS text AS $$
	SELECT get_value(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer,a_prop_id integer,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_value (a_obj_id integer,a_prop text,a_path text) RETURNS text AS $$
	SELECT get_value(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer,a_prop text,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer,a_prop_id integer,a_path text) RETURNS SETOF text AS $$
	SELECT get_values(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer,a_prop text,a_path text) RETURNS SETOF text AS $$
	SELECT get_values(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- TAG
----------------------------
CREATE OR REPLACE FUNCTION tag_id (a_type text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('tag'));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_tag (a_obj_id integer,a_tag_id integer) RETURNS void AS $$
	INSERT INTO tag (obj_id,tag_id) VALUES ($1,$2);
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- OBJECT
----------------------------
CREATE OR REPLACE FUNCTION object_name (integer) RETURNS text AS $$
DECLARE
	class	text;
	name	text;
BEGIN
	SELECT INTO class,name r.name,get_value(obj_id,'class','object_name')
	FROM ref r WHERE obj_id = (SELECT class_id FROM obj WHERE obj_id=$1);
	IF name IS NOT NULL THEN
		EXECUTE 'SELECT '||name||' FROM '||class||' WHERE obj_id='||$1 INTO name;
	END IF;
	RETURN name;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION object_full_name (integer) RETURNS text AS $$
	SELECT class_full_name(class_id)||':'||object_name($1) FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION object_id (a_object text) RETURNS integer AS $$
DECLARE
	pos	integer := strpos(a_object,':');
	res	integer;
BEGIN
	IF pos>0 THEN
		EXECUTE 'SELECT '||substr(a_object,0,pos)||'_id('''||substr(a_object,pos+1)||''')' INTO res;
	END IF;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

----------------------------
-- TO DATE/TIME
----------------------------
CREATE OR REPLACE FUNCTION to_datetime_std (timestamp) RETURNS text AS $$
	SELECT to_char($1,'DD.MM.YYYY HH24:MI:SS');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_datetime_iso (timestamp) RETURNS text AS $$
	SELECT to_char($1,'YYYY-MM-DD HH24:MI:SS');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_date_std (timestamp) RETURNS text AS $$
	SELECT to_char($1,'DD.MM.YYYY');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_date_iso (timestamp) RETURNS text AS $$
	SELECT to_char($1,'YYYY-MM-DD');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_date_my (timestamp) RETURNS text AS $$
	SELECT to_char($1,'MM YYYY');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_time (timestamp) RETURNS text AS $$
	SELECT to_char($1,'HH24:MI');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION seconds2time (integer) RETURNS text AS $$
	SELECT to_char('1s'::interval*$1,CASE WHEN $1>3599 THEN 'HH24:' ELSE '' END||'MI:SS');
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- TO SECOND/MINUTE/HOUR/DAY/MONTH/YEAR
----------------------------
CREATE OR REPLACE FUNCTION to_second () RETURNS timestamp AS $$
	SELECT date_trunc('second',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_second (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('second',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_minute () RETURNS timestamp AS $$
	SELECT date_trunc('minute',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_minute (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('minute',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_hour () RETURNS timestamp AS $$
	SELECT date_trunc('hour',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_hour (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('hour',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_day () RETURNS timestamp AS $$
	SELECT date_trunc('day',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_day (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('day',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION tomorrow () RETURNS timestamp AS $$
	SELECT date_trunc('day',now()::timestamp+'1day'::interval);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION tomorrow (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('day',coalesce($1,now())::timestamp+'1day'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION yesterday () RETURNS timestamp AS $$
	SELECT date_trunc('day',now()::timestamp-'1day'::interval);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION yesterday (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('day',coalesce($1,now())::timestamp-'1day'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_week () RETURNS timestamp AS $$
	SELECT date_trunc('week',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_week (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('week',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_month () RETURNS timestamp AS $$
	SELECT date_trunc('month',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_month (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('month',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prev_month () RETURNS timestamp AS $$
	SELECT date_trunc('month',now()::timestamp-'1month'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prev_month (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('month',coalesce($1,now())::timestamp-'1month'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_year () RETURNS timestamp AS $$
	SELECT date_trunc('year',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION to_year (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('year',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION days_in_month (timestamp with time zone) RETURNS integer AS $$
	SELECT date_part('day',to_month($1+'1month')-to_month($1))::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION days2quantity (a_day timestamp with time zone,a_month timestamp with time zone) RETURNS double precision AS $$
	SELECT CASE
		WHEN $1 IS NULL THEN 1
		WHEN to_month($1)>to_month($2) THEN 0
		WHEN to_month($1)<to_month($2) THEN 1
		ELSE 1-(date_part('day',$1)-1)/days_in_month($1)
	END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION quantity2days (a_quantity double precision,a_month timestamp with time zone) RETURNS integer AS $$
	SELECT round($1*days_in_month($2))::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- TO KB/MB/GB 1000/1024
----------------------------
CREATE OR REPLACE FUNCTION to_kb1000 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1000.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_kb1000 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1000,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_kb1024 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1024.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_kb1024 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1024,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_mb1000 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1000000.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_mb1000 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1000000,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_mb1024 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1048576.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_mb1024 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1048576,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1000_ (numeric) RETURNS numeric AS $$
	SELECT trunc($1/1000000000.0,3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1000_ (double precision) RETURNS numeric AS $$
	SELECT trunc($1::numeric/1000000000,3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1000 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1000000000.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1000 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1000000000,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1024 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1073741824.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_gb1024 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1073741824,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_tb1000 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1000000000000.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_tb1000 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1000000000000,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_tb1024 (numeric) RETURNS numeric AS $$
	SELECT trunc(coalesce($1/1099511627776.0,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_tb1024 (double precision) RETURNS numeric AS $$
	SELECT trunc(coalesce($1::numeric/1099511627776,0),3);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

----------------------------
-- TO/FROM CENTS
----------------------------
CREATE OR REPLACE FUNCTION from_cents (a_cents double precision) RETURNS numeric AS $$
	SELECT CASE WHEN $1>trunc($1) THEN ($1/100)::numeric ELSE trunc(($1/100)::numeric,2) END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_cents(double precision) RETURNS double precision AS $$
	SELECT $1 * 100;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- TO SIGN
----------------------------
CREATE OR REPLACE FUNCTION to_sign (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN '+' ELSE '-' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_sign (integer) RETURNS text AS $$
	SELECT CASE WHEN $1<0 THEN '-' ELSE '+' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_yes (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN 'yes' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_no (boolean) RETURNS text AS $$
	SELECT CASE WHEN NOT $1 THEN 'no' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_yesno (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN '{lang:Yes}' ELSE '{lang:No}' END;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- COMPARE
----------------------------
CREATE OR REPLACE FUNCTION compare (cmp text,lhs double precision,rhs double precision) RETURNS boolean AS $$
	SELECT	CASE $1	WHEN 'lt' THEN $2 <  $3
			WHEN 'le' THEN $2 <= $3
			WHEN 'gt' THEN $2 >  $3
			WHEN 'ge' THEN $2 >= $3
			WHEN 'eq' THEN $2 =  $3
			          ELSE $2 != $3
		END;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- LOG
----------------------------
----------------------------
-- LOG_VAR
----------------------------

