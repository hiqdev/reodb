-- $Header: /home/sol/usr/cvs/reodb/functions.sql,v 1.3 2007/08/31 11:16:18 sol Exp $

-- REPLACE
CREATE TYPE replace_data AS (keys text,vals text,sets text);
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value boolean) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value integer) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value double precision) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value text) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3) END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value timestamp) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value inet) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
		CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value boolean,old boolean) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value integer,old integer) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value double precision,old double precision) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value text,old text) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3) END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value timestamp,old timestamp) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value inet,old inet) AS $$
	SELECT	CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
		CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
		CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

-- CJOIN
CREATE OR REPLACE FUNCTION cjoin (a_strs text[]) RETURNS text AS $$
	SELECT array_to_string($1,',');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION cjoin (a_strs text[],a_delimiter text) RETURNS text AS $$
	SELECT array_to_string($1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;

-- LANG
CREATE OR REPLACE FUNCTION unlang (a_str text) RETURNS text AS $$
	SELECT substr($1,7,abs(length($1)-7));
$$ LANGUAGE sql IMMUTABLE STRICT;

-- EXECUTE
CREATE OR REPLACE FUNCTION safe_execute (a_query text) RETURNS text AS $$
BEGIN
	BEGIN
		EXECUTE a_query;
	EXCEPTION WHEN OTHERS THEN
		RETURN SQLERRM;
	END;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

-- DIFF
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text) RETURNS text AS $$
	SELECT CASE WHEN $1!='' THEN $1 ELSE $2 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text) RETURNS text AS $$
	SELECT	CASE WHEN $1!='' THEN $1 ELSE
		CASE WHEN $2!='' THEN $2 ELSE $3
	END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text) RETURNS text AS $$
	SELECT	CASE WHEN $1!='' THEN $1 ELSE
		CASE WHEN $2!='' THEN $2 ELSE
		CASE WHEN $3!='' THEN $3 ELSE $4
	END END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text,a_5 text) RETURNS text AS $$
	SELECT	CASE WHEN $1!='' THEN $1 ELSE
		CASE WHEN $2!='' THEN $2 ELSE
		CASE WHEN $3!='' THEN $3 ELSE
		CASE WHEN $4!='' THEN $4 ELSE $5
	END END END END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonzero (a_1 integer,a_2 integer) RETURNS integer AS $$
	SELECT CASE WHEN $1>0 THEN $1 ELSE $2 END;
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
CREATE OR REPLACE FUNCTION passgen (length integer) RETURNS text AS $$
	SELECT substr(encode(decode(md5(random()::text),'hex'),'base64'),1,$1);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION passgen () RETURNS text AS $$
	SELECT substr(encode(decode(md5(random()::text),'hex'),'base64'),1,10);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION str2int (a text,def integer) RETURNS integer AS $$
DECLARE
	r integer;
BEGIN
	BEGIN
		SELECT INTO r a::integer;
	EXCEPTION
		WHEN OTHERS THEN
			-- do nothing
	END;
	RETURN coalesce(r,def);
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION str2int (a text) RETURNS integer AS $$
	SELECT str2int($1,0);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION str2num (a text,def numeric) RETURNS numeric AS $$
DECLARE
	r numeric;
BEGIN
	BEGIN
		SELECT INTO r a::numeric;
	EXCEPTION
		WHEN OTHERS THEN
			-- do nothing
	END;
	RETURN coalesce(r,def);
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION str2num (a text) RETURNS numeric AS $$
DECLARE
	r numeric;
BEGIN
	BEGIN
		SELECT INTO r a::numeric;
	EXCEPTION
		WHEN OTHERS THEN
			-- do nothing
	END;
	RETURN coalesce(r,0);
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION str2inet (a text) RETURNS inet AS $$
DECLARE
	r inet;
BEGIN
	BEGIN
		SELECT INTO r a::inet;
	EXCEPTION
		WHEN OTHERS THEN
			-- do nothing
	END;
	RETURN r;
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION str2time (a text) RETURNS timestamp AS $$
DECLARE
	t timestamp;
BEGIN
	BEGIN
		SELECT INTO t a::timestamp;
	EXCEPTION
		WHEN OTHERS THEN
			-- do nothing
	END;
	RETURN t;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION smart_str2num (aa text) RETURNS numeric AS $$
	SELECT str2num(replace($1,',','.'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION smart_str2time (aa text) RETURNS timestamp AS $$
DECLARE
	bb text := trim(aa);
	lc text := lower(bb);
	rr text;
BEGIN
	IF lc='this' OR lc='thismonth' THEN
		RETURN to_month();
	END IF;
	IF lc='prev' OR lc='prevmonth' OR lc='previousmonth' THEN
		RETURN prev_month();
	END IF;
	rr := regexp_replace(bb,'^(\d{1,2})\.(\d{1,2})\.(\d{4})',E'\\3-\\2-\\1');
	RETURN str2time(rr);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- CHECK EMAIL
CREATE OR REPLACE FUNCTION is_email (a_email text) RETURNS boolean AS $$
	SELECT $1~*'^[a-z0-9_.+-]+@[a-z0-9.-]+$';
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

-- SPLIT
CREATE OR REPLACE FUNCTION split (a text,sym text) RETURNS text[] AS $$
DECLARE
	str text := a;
	npt text;
	res text[];
	fin boolean := false;
	pos integer;
BEGIN
	LOOP
		pos := strpos(str,sym);
		IF pos=0 THEN
			pos := length(str)+1;
			fin := true;
		END IF;
		IF pos>1 THEN
			npt := btrim(substr(str,0,pos),E'       \n');
			IF npt!='' THEN
				res := array_append(res,npt);
			END IF;
		END IF;
		EXIT WHEN fin;
		str := substr(str,pos+1);
	END LOOP;
	RETURN res;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION csplit (a text) RETURNS text[] AS $$
	SELECT split($1,',');
$$ LANGUAGE sql IMMUTABLE STRICT;

-- CHECK IP
CREATE OR REPLACE FUNCTION is_ip_allowed (a_ip inet,a_nets text) RETURNS boolean AS $$
	SELECT max((str2inet(net)>>=$1)::integer)::boolean
	FROM (SELECT unnest(csplit($2)) AS net) AS foo;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

-- UNNEST
CREATE OR REPLACE FUNCTION unnest (a text[]) RETURNS SETOF text AS $$
DECLARE
	r text;
BEGIN
	FOR i IN 1..coalesce(array_upper(a,1),0) LOOP
		r := a[i];
		RETURN NEXT r;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- OBSOLETE AS OF 9.1
--	CREATE OR REPLACE FUNCTION crypt (text, text) RETURNS text
--		AS '$libdir/pgcrypto', 'pg_crypt'
--	LANGUAGE C IMMUTABLE STRICT;
--	CREATE OR REPLACE FUNCTION gen_salt (text) RETURNS text
--		AS '$libdir/pgcrypto', 'pg_gen_salt'
--	LANGUAGE C VOLATILE STRICT;

-- PASSWORD
CREATE OR REPLACE FUNCTION is_crypted (a_pwd text) RETURNS boolean AS $$
	SELECT $1~E'^\\$\\d\\$';
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION check_password (a_test text,a_pwd text) RETURNS boolean AS $$
	SELECT CASE WHEN is_crypted($2) THEN $2=crypt($1,$2) ELSE $1=$2 END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION crypt_password (a_pwd text) RETURNS text AS $$
	SELECT CASE WHEN is_crypted($1) THEN $1 ELSE crypt($1,gen_salt('md5')) END;
$$ LANGUAGE sql VOLATILE STRICT;

--CREATE OR REPLACE FUNCTION last_strpos (haystack text,needle char) RETURNS integer AS
--	'/www/rcp3/src/sql/last_strpos','last_strpos'
--LANGUAGE c IMMUTABLE STRICT;

----------------------------
-- TO DATE/TIME
----------------------------
CREATE OR REPLACE FUNCTION to_datetime_std (timestamp) RETURNS text AS $$
	SELECT to_char($1,'DD.MM.YYYY HH24:MI:SS');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_datetime_iso (timestamp) RETURNS text AS $$
	SELECT to_char($1,'YYYY-MM-DD HH24:MI:SS');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_datetime_usa (timestamp) RETURNS text AS $$
	SELECT to_char($1,'FMMM/FMDD/YYYY FMHH:MIAM');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_date_usa (timestamp) RETURNS text AS $$
	SELECT to_char($1,'FMMM/FMDD/YYYY');
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
-- DATE/TIME OPERATIONS
----------------------------
CREATE OR REPLACE FUNCTION abs (diff interval) RETURNS interval AS $$
	SELECT CASE WHEN $1<'0sec'::interval THEN -$1 ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION inc_years (a_date timestamp,a_years integer) RETURNS timestamp AS $$
	SELECT $1+'1year'::interval*coalesce($2,0);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION inc_years (a_date timestamp,a_years double precision) RETURNS timestamp AS $$
	SELECT $1+'1year'::interval*coalesce($2,0);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION dec_years (a_date timestamp,a_years integer) RETURNS timestamp AS $$
	SELECT $1-'1year'::interval*coalesce($2,0);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION dec_years (a_date timestamp,a_years double precision) RETURNS timestamp AS $$
	SELECT $1-'1year'::interval*coalesce($2,0);
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION age_since_new_year (a_date timestamp) RETURNS interval AS $$
	SELECT age($1,date_trunc('year',$1));
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION short_interval (a_interval interval) RETURNS text AS $$
	SELECT CASE
		WHEN $1>'1year'	THEN date_part('month',$1)||' monthes'
		WHEN $1>'1day'	THEN date_part('day',$1)||' days'
		WHEN $1>'1hour'	THEN date_part('hour',$1)||' hours'
				ELSE date_part('minute',$1)||' minutes'
	END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

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
CREATE OR REPLACE FUNCTION this_month () RETURNS timestamp AS $$
	SELECT date_trunc('month',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION this_month (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('month',coalesce($1,now())::timestamp);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prev_month () RETURNS timestamp AS $$
	SELECT date_trunc('month',now()::timestamp-'1month'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prev_month (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('month',coalesce($1,now())::timestamp+'1month'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION next_month () RETURNS timestamp AS $$
	SELECT date_trunc('month',now()::timestamp+'1month'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION next_month (timestamp with time zone) RETURNS timestamp AS $$
	SELECT date_trunc('month',coalesce($1,now())::timestamp+'1month'::interval);
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
	SELECT CASE WHEN $1>trunc($1) THEN ($1/100)::numeric ELSE trunc((coalesce($1,0)/100)::numeric,2) END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION to_cents (a_sum numeric) RETURNS integer AS $$
	SELECT trunc($1 * 100)::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- TO BOOL
----------------------------
CREATE OR REPLACE FUNCTION to_bool (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN 'TRUE' ELSE 'FALSE' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_t (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN 't' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_t (text) RETURNS text AS $$
	SELECT CASE WHEN $1!='' THEN 't' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_t (numeric) RETURNS text AS $$
	SELECT CASE WHEN $1!=0 THEN 't' END;
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
-- TO SIGN
----------------------------
CREATE OR REPLACE FUNCTION to_sign (boolean) RETURNS text AS $$
	SELECT CASE WHEN $1 THEN '+' ELSE '-' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_sign (integer) RETURNS text AS $$
	SELECT CASE WHEN $1<0 THEN '-' ELSE '+' END;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- COMPARE
----------------------------
CREATE OR REPLACE FUNCTION compare (cmp text,lhs double precision,rhs double precision) RETURNS boolean AS $$
    SELECT CASE $1
        WHEN 'lt' THEN $2 <  $3
        WHEN 'le' THEN $2 <= $3
        WHEN 'gt' THEN $2 >  $3
        WHEN 'ge' THEN $2 >= $3
        WHEN 'eq' THEN $2 =  $3
            ELSE $2 != $3
    END;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- GET OBJECT CLASS/STATE
----------------------------
CREATE OR REPLACE FUNCTION obj_class_id (a_obj_id integer) RETURNS integer AS $$
	SELECT class_id FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION obj_class (a_obj_id integer) RETURNS text AS $$
	SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_state_id (a_obj_id integer) RETURNS integer AS $$
DECLARE
	res integer;
BEGIN
	EXECUTE 'SELECT state_id FROM '|| (
		SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=a_obj_id)
	) ||' WHERE obj_id='||a_obj_id INTO res;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_state (a_obj_id integer) RETURNS text AS $$
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
CREATE OR REPLACE FUNCTION obj_label (a_obj_id integer) RETURNS text AS $$
	SELECT label FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_descr (a_obj_id integer) RETURNS text AS $$
	SELECT descr FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_obj_label (a_obj_id integer,a_label text) RETURNS integer AS $$
	UPDATE obj SET label=$2 WHERE obj_id=$1 RETURNING obj_id;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_obj_label (a_obj_id integer,a_label text,a_descr text) RETURNS integer AS $$
	UPDATE obj SET label=$2,descr=$3 WHERE obj_id=$1 RETURNING obj_Id;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_obj_descr (a_obj_id integer,a_descr text) RETURNS void AS $$
	UPDATE obj SET descr=coalesce($2,'') WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

----------------------------
-- GET/SET OBJECT CREATE/UPDATE TIME
----------------------------
CREATE OR REPLACE FUNCTION obj_create_time (a_obj_id integer) RETURNS timestamp AS $$
	SELECT create_time FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_update_time (a_obj_id integer) RETURNS timestamp AS $$
	SELECT update_time FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_obj_create_time (a_obj_id integer,a_create_time timestamp) RETURNS void AS $$
	UPDATE obj SET create_time=$2 WHERE obj_id = $1;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_obj_update_time (a_obj_id integer,a_update_time timestamp) RETURNS void AS $$
	UPDATE obj SET update_time=$2 WHERE obj_id = $1;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_obj_update_time (a_obj_id integer) RETURNS void AS $$
	UPDATE obj SET update_time='now' WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- REF
----------------------------
CREATE OR REPLACE FUNCTION top_ref_id (a_ref text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$1 AND _id=0;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION top_ref_id (a_one text,a_two text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=top_ref_id($1);
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
CREATE OR REPLACE FUNCTION simple_sub_ref_id (a_name text,a_id integer) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$1 AND _id IN (SELECT obj_id FROM ref WHERE $2 IN (obj_id,_id));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION sub_ref_id (a_name text,a_id integer) RETURNS integer AS $$
DECLARE
	pos integer := strpos(a_name,',');
BEGIN
	RETURN CASE WHEN pos=0
		THEN simple_sub_ref_id(a_name,a_id)
		ELSE sub_ref_id(substr(a_name,pos+1),simple_sub_ref_id(substr(a_name,0,pos),a_id))
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
CREATE OR REPLACE FUNCTION ref_ids (a_parent_id integer) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_1 text,a_2 text,a_3 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1) AND name IN ($2,$3,$4);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_1 text,a_2 text,a_3 text,a_4 text) RETURNS SETOF integer AS $$
	SELECT obj_id FROM ref WHERE _id=ref_id($1) AND name IN ($2,$3,$4,$5);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_name (a_obj_id integer) RETURNS text AS $$
	SELECT name FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_in (a_obj_id integer,a_names text) RETURNS boolean AS $$
	SELECT name = ANY(csplit($2)) FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_pname (a_obj_id integer) RETURNS text AS $$
	SELECT name FROM ref WHERE obj_id=(SELECT _id FROM ref WHERE obj_id=$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT CASE WHEN _id=0 THEN name ELSE ref_full_name(_id)||','||name END
	FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_full_name (a_parent_id integer,a_obj_id integer) RETURNS text AS $$
	SELECT CASE WHEN _id=0 OR _id=$2 THEN name ELSE ref_full_name(_id,$2)||','||name END
	FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_ref (a_no integer,a_ref text,a_label text,a_descr text) RETURNS integer AS $$
DECLARE
	the_id	integer := ref_id(a_ref);
	pos	integer;
BEGIN
	IF the_id IS NULL THEN
		pos	:= last_strpos(a_ref,',');
		INSERT INTO ref (obj_id,_id,name,no,label,descr)
		VALUES (the_id,ref_id(substr(a_ref,0,pos)),substr(a_ref,pos+1),a_no,a_label,a_descr)
		RETURNING obj_id INTO the_id;
	ELSE
		UPDATE ref SET no=a_no,label=a_label,descr=a_descr
		WHERE obj_id=the_id;
	END IF;
	PERFORM set_obj_label(the_id,a_label,a_descr);
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_ref (a_no integer,a_ref text,a_label text) RETURNS integer AS $$
	SELECT set_ref($1,$2,$3,NULL);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_ref (a_ref text,a_label text) RETURNS integer AS $$
	SELECT set_ref(NULL,$1,$2,NULL);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

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
CREATE OR REPLACE FUNCTION state_id (a_name text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('state'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_id (a_parent text,a_name text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('state',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_ids (a_parent text,a_names text[]) RETURNS integer[] AS $$
	SELECT array_agg(obj_id) FROM ref WHERE _id=ref_id('state',$1) AND name = ANY($2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_ids (a_parent text,a_names text) RETURNS integer[] AS $$
	SELECT array_agg(obj_id) FROM ref WHERE _id=ref_id('state',$1) AND name = ANY(csplit($2));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT ref_full_name($1,top_ref_id('state'));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- STATUS
----------------------------
CREATE OR REPLACE FUNCTION status_id (a_name text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('status'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION status_id (a_parent text,a_name text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$2 AND _id=ref_id('status',$1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION status_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT ref_full_name($1,top_ref_id('status'));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_status (a_obj_id integer,a_type_id integer) RETURNS timestamp AS $$
	SELECT time FROM status WHERE object_id=$1 AND type_id=$2;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION get_status (a_obj_id integer,a_type text) RETURNS timestamp AS $$
	SELECT time FROM status WHERE object_id=$1 AND type_id=status_id($2);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION has_status (a_obj_id integer,a_type text,a_period interval) RETURNS boolean AS $$
	SELECT EXISTS (SELECT 1 FROM status WHERE object_id=$1 AND type_id=status_id($2) AND time>now()-$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION has_status (a_obj_id integer,a_type_id integer,a_period interval) RETURNS boolean AS $$
	SELECT EXISTS (SELECT 1 FROM status WHERE object_id=$1 AND type_id=$2 AND time>now()-$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION check_status (a_obj_id integer,a_type_id integer,a_period interval) RETURNS timestamp AS $$
	SELECT time FROM status WHERE object_id=$1 AND type_id=$2 AND time>now()-$3;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION check_status (a_obj_id integer,a_type text,a_period interval) RETURNS timestamp AS $$
	SELECT time FROM status WHERE object_id=$1 AND type_id=status_id($2) AND time>now()-$3;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_subject_id integer,a_type_id integer,a_time timestamp) RETURNS integer AS $$
DECLARE
	the_id		integer;
	the_time	timestamp;
	b_time		timestamp := coalesce(a_time,now());
BEGIN
	SELECT INTO the_id,the_time id,time FROM status WHERE object_id=a_obj_id AND type_id=a_type_id;
	IF the_id IS NULL THEN
		INSERT INTO status (object_id,subject_id,type_id,time)
		VALUES (a_obj_id,a_subject_id,a_type_id,b_time) RETURNING id INTO the_id;
	ELSIF the_time!=a_time THEN
		UPDATE status SET subject_id=coalesce(a_subject_id,subject_id),time=a_time WHERE id=the_id;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type_id integer,a_time timestamp) RETURNS integer AS $$
	SELECT set_status($1,NULL,$2,$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type_id integer,a_time timestamp with time zone) RETURNS integer AS $$
	SELECT set_status($1,$2,$3::timestamp);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type text,a_time timestamp) RETURNS integer AS $$
	SELECT set_status($1,status_id($2),$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type text,a_time timestamp with time zone) RETURNS integer AS $$
	SELECT set_status($1,status_id($2),$3::timestamp);
$$ LANGUAGE sql VOLATILE STRICT;
-- XXX important: this function does NOT change time of the status if it already exists
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type text) RETURNS integer AS $$
DECLARE
	a_type_id	integer := status_id(a_type);
	the_id		integer;
BEGIN
	SELECT INTO the_id id FROM status WHERE object_id=a_obj_id AND type_id=a_type_id;
	IF the_id IS NULL THEN
		INSERT INTO status (object_id,type_id) VALUES (a_obj_id,a_type_id) RETURNING id INTO the_id;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION reset_status (a_obj_id integer,a_type text) RETURNS integer AS $$
	SELECT set_status($1,status_id($2),now());
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION del_status (a_obj_id integer,a_type text) RETURNS void AS $$
	DELETE FROM status WHERE object_id=$1 AND type_id=status_id($2);
$$ LANGUAGE sql VOLATILE STRICT;
-- TODO redo this way: if current statuses differ from given then delete and insert else do nothing
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,a__id integer,statuses text[]) RETURNS integer AS $$
DECLARE
	row	record;
	n_has	boolean;
	adds	integer[];
	dels	integer[];
BEGIN
	FOR row IN
		SELECT		t.obj_id,t.name,s.id IS NOT NULL AS has
		FROM		ref	t
		LEFT JOIN	status	s ON s.type_id=t.obj_id AND s.object_id=a_obj_id
		WHERE		t._id=a__id
	LOOP
		n_has := row.name = ANY(statuses);
		IF row.has THEN
			IF NOT n_has THEN
				dels := dels || row.obj_id;
			END IF;
		ELSIF n_has THEN
			adds := adds || row.obj_id;
		END IF;
	END LOOP;
	IF adds>'{}'::integer[] THEN
		INSERT INTO status (object_id,type_id)
		SELECT a_obj_id,obj_id FROM ref WHERE obj_id=ANY(adds);
	END IF;
	IF dels>'{}'::integer[] THEN
		DELETE FROM status WHERE object_id=a_obj_id AND type_id=ANY(dels);
	END IF;
	RETURN a_obj_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,parent text,statuses text[]) RETURNS integer AS $$
	SELECT set_statuses($1,status_id($2),$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,parent text,statuses text) RETURNS integer AS $$
	SELECT set_statuses($1,status_id($2),csplit($3));
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_statuses (a_obj_id integer,statuses integer[]) RETURNS integer AS $$
DECLARE
	s integer;
	res integer;
BEGIN
	FOREACH s IN ARRAY statuses LOOP
		res := set_status(a_obj_id,statuses[i],now());
	END LOOP;
	RETURN res;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

----------------------------
-- ERROR
----------------------------
CREATE OR REPLACE FUNCTION error_id (a_name text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$1 AND _id IN (SELECT obj_id FROM ref WHERE ref_id('error') IN (obj_id,_id));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION set_error_ref (a_ref text) RETURNS integer AS $$
	SELECT coalesce(error_id($1),set_ref(NULL,'error,'||$1,NULL,NULL));
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION add_errors (a_obj_id integer,errors text[]) RETURNS integer AS $$
DECLARE
	e text;
	res integer;
BEGIN
	IF errors != '{}' THEN
		FOREACH e IN ARRAY errors LOOP
			res := set_status(a_obj_id,set_error_ref(e),now());
		END LOOP;
	END IF;
	RETURN res;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_errors (a_obj_id integer,errors text[]) RETURNS integer AS $$
	DELETE FROM status WHERE object_id=$1 AND type_id IN (
		SELECT obj_id FROM ref WHERE _id IN (SELECT obj_id FROM ref WHERE ref_id('error') IN (obj_id,_id))
	);
	SELECT add_errors($1,$2);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

----------------------------
-- PAGE
----------------------------
CREATE OR REPLACE FUNCTION ref_page_id (a_page text) RETURNS integer AS $$
	SELECT obj_id FROM ref WHERE name=$1 AND _id IN (SELECT obj_id FROM ref WHERE ref_id('error') IN (obj_id,_id));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION set_ref_page_id (a_page text) RETURNS integer AS $$
DECLARE
BEGIN
	FOREACH p IN ARRAY csplit(a_page) LOOP
	END LOOP;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

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
CREATE OR REPLACE FUNCTION prop_id (a_class_id integer,a_name text) RETURNS integer AS $$
	SELECT obj_id FROM prop WHERE name = $2 AND class_id = $1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_id (a_class text,a_name text) RETURNS integer AS $$
	SELECT obj_id FROM prop WHERE name = $2 AND class_id = class_id($1);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION get_prop_def (a_obj_id integer) RETURNS text AS $$
	SELECT def FROM prop WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION prop_name (a_obj_id integer) RETURNS text AS $$
	SELECT name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION prop_prop (a_obj_id integer) RETURNS text AS $$
	SELECT ref_name(class_id)||':'||name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION prop_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT class_full_name(class_id)||':'||name FROM prop WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION replace_prop (
	a_obj_id	integer,	-- $1
	a_class_id	integer,	-- $2
	a_name		text,		-- $3
	a_type_id	integer,	-- $4
	a_no		integer,	-- $5
	a_def		text,		-- $6
	a_is_in_table	boolean,	-- $7
	a_can_be_null	boolean,	-- $8
	a_is_required	boolean,	-- $9
	a_is_repeated	boolean,	-- $10
	a_label		text		-- $11
) RETURNS integer AS $$
DECLARE
	the_id	integer := a_obj_id;
	prep	replace_data;
BEGIN
	prep := (NULL,NULL,NULL);
	prep := prepare_replace(prep,'class_id',	a_class_id);
	prep := prepare_replace(prep,'name',		a_name);
	prep := prepare_replace(prep,'type_id',		a_type_id);
	prep := prepare_replace(prep,'no',		a_no);
	prep := prepare_replace(prep,'def',		a_def);
	prep := prepare_replace(prep,'is_in_table',	a_is_in_table);
	prep := prepare_replace(prep,'can_be_null',	a_can_be_null);
	prep := prepare_replace(prep,'is_required',	a_is_required);
	prep := prepare_replace(prep,'is_repeated',	a_is_repeated);
	IF the_id IS NULL THEN
		EXECUTE 'INSERT INTO prop ('||prep.keys||') VALUES ('||prep.vals||') RETURNING obj_id' INTO the_id;
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
	a_no		integer,		-- $1
	a_prop		text,		-- $2
	a_type_id	integer,		-- $3
	a_label		text,		-- $4
	a_def		text,		-- $5
	a_is_in_table	boolean,	-- $6
	a_can_be_null	boolean,	-- $7
	a_is_required	boolean,	-- $8
	a_is_repeated	boolean		-- $9
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
CREATE OR REPLACE FUNCTION is_set_value (a_obj_id integer,a_prop_id integer) RETURNS boolean AS $$
	SELECT EXISTS (SELECT 1 FROM value WHERE obj_id = $1 AND prop_id = $2);
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- GET VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_value_non_def (a_obj_id integer,a_prop_id integer) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 ORDER BY no ASC LIMIT 1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (a_obj_id integer,a_prop_id integer,a_default text) RETURNS text AS $$
	SELECT coalesce(get_value_non_def($1,$2),$3);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (a_obj_id integer,a_prop_id integer) RETURNS text AS $$
	SELECT get_value($1,$2,get_prop_def($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_values (a_obj_id integer,a_prop_id integer) RETURNS SETOF text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 ORDER BY no ASC;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_non_def (a_obj_id integer,a_prop text) RETURNS text AS $$
	SELECT get_value_non_def($1,prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (a_obj_id integer,a_prop text,a_default text) RETURNS text AS $$
	SELECT get_value($1,prop_id($2),$3);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value (a_obj_id integer,a_prop text) RETURNS text AS $$
	SELECT get_value($1,prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS text AS $$
	SELECT value FROM value WHERE obj_id = $1 AND prop_id = $2 AND no = $3;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- GET BIGINT VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_integer_value (a_obj_id integer,a_prop_id integer) RETURNS integer AS $$
	SELECT coalesce(get_value($1,$2)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_integer_value (a_obj_id integer,a_prop text) RETURNS integer AS $$
	SELECT coalesce(get_value($1,$2)::integer,0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_integer_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS integer AS $$
	SELECT coalesce(get_value_by_no($1,$2,$3)::integer,0);
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
CREATE OR REPLACE FUNCTION get_double_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer) RETURNS double precision AS $$
	SELECT coalesce(get_value_by_no($1,$2,$3)::double precision, 0);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

----------------------------
-- GET PROP VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_props_values (a_obj_id integer,a_class_id integer) RETURNS TABLE(name text, value text) AS $$
	SELECT		p.name,coalesce(v.value,p.def) as value
	FROM		prop p
	LEFT JOIN	value v		ON v.prop_id=p.obj_id AND v.obj_id=$1
	WHERE		p.class_id=$2;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION get_props_values (a_obj_id integer,a_class text) RETURNS TABLE(name text, value text) AS $$
	SELECT *  FROM get_props_values($1, class_id($2));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- SET VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop_id integer,a_value text) RETURNS integer AS $$
DECLARE
	the_id		integer;
	the_def		text;
	the_value	text;
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) AND EXISTS (SELECT 1 FROM prop WHERE obj_id=a_prop_id) THEN
		SELECT INTO the_id,the_value id,value FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id ORDER BY no ASC LIMIT 1;
		SELECT INTO the_def def FROM prop WHERE obj_id=a_prop_id;
		IF the_def=a_value THEN
			IF the_id IS NOT NULL THEN
				DELETE FROM value WHERE id=the_id;
			END IF;
		ELSIF the_id IS NOT NULL THEN
			IF the_value!=a_value THEN
				UPDATE value SET value=a_value WHERE id=the_id;
			END IF;
		ELSE
			INSERT INTO value (obj_id,prop_id,value) VALUES (a_obj_id,a_prop_id,a_value)
			RETURNING id INTO the_id;
		END IF;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop text,a_value text) RETURNS integer AS $$
BEGIN
	RETURN set_value(a_obj_id,prop_id(a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop text,a_value integer) RETURNS integer AS $$
BEGIN
	RETURN set_value(a_obj_id,prop_id(a_prop),a_value::text);
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_class text,a_prop text,a_value text) RETURNS integer AS $$
BEGIN
	RETURN set_value(a_obj_id,prop_id(a_class,a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE;
CREATE OR REPLACE FUNCTION set_value_if_not (a_obj_id integer,a_prop text,a_value text) RETURNS integer AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM value WHERE obj_id=a_obj_id AND prop_id=prop_id(a_prop)) THEN
		RETURN set_value(a_obj_id,a_prop,a_value);
	ELSE
		RETURN NULL;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_value_by_no (a_obj_id integer,a_prop_id integer,a_no integer,a_value text) RETURNS integer AS $$
DECLARE
	the_id		integer;
	the_def		text;
	the_value	text;
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id AND no=a_no;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) AND EXISTS (SELECT 1 FROM prop WHERE obj_id=a_prop_id) THEN
		SELECT INTO the_id,the_value id,value FROM value WHERE obj_id=a_obj_id AND prop_id=a_prop_id AND no=a_no;
		SELECT INTO the_def def FROM prop WHERE obj_id=a_prop_id;
		IF the_def=a_value THEN
			IF the_id IS NOT NULL THEN
				DELETE FROM value WHERE id=the_id;
			END IF;
		ELSIF the_id IS NOT NULL THEN
			IF the_value!=a_value THEN
				UPDATE value SET value=a_value WHERE id=the_id;
			END IF;
		ELSE
			INSERT INTO value (obj_id,prop_id,no,value) VALUES (a_obj_id,a_prop_id,a_no,a_value)
			RETURNING id INTO the_id;
		END IF;
	END IF;
	RETURN the_id;
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
-- SET INTEGER VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_integer_value (a_obj_id integer,a_prop_id integer,a_value integer) RETURNS integer AS $$
DECLARE
	the_id	integer;
	the_def	integer;
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM integer_value WHERE obj_id=a_obj_id AND prop_id=a_prop_id;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) AND EXISTS (SELECT 1 FROM prop WHERE obj_id=a_prop_id) THEN
		SELECT INTO the_id id FROM integer_value WHERE obj_id=a_obj_id AND prop_id=a_prop_id ORDER BY no ASC LIMIT 1;
		SELECT INTO the_def str2int(def) FROM prop WHERE obj_id=a_prop_id;
		IF the_def=a_value THEN
			IF the_id IS NOT NULL THEN
				DELETE FROM integer_value WHERE id=the_id;
			END IF;
		ELSIF the_id IS NOT NULL THEN
			UPDATE integer_value SET value=a_value WHERE id=the_id;
		ELSE
			INSERT INTO integer_value (obj_id,prop_id,value) VALUES (a_obj_id,a_prop_id,a_value)
			RETURNING id INTO the_id;
		END IF;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_integer_value (a_obj_id integer,a_prop text,a_value integer) RETURNS integer AS $$
	SELECT set_integer_value($1,prop_id($2),$3);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

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
-- DELETE VALUE
----------------------------
CREATE OR REPLACE FUNCTION verify_value (a_obj_id integer,a_prop text,a_value text) RETURNS integer AS $$
	SELECT CASE WHEN get_value($1,$2)=$3 THEN set_value($1,$2||'_verified',$3) END;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- ADD/INSERT VALUE
----------------------------
CREATE OR REPLACE FUNCTION add_value (a_obj_id integer,a_prop_id integer,text) RETURNS void AS $$
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
CREATE OR REPLACE FUNCTION insert_value (a_obj_id integer,a_prop_id integer,a_value text) RETURNS void AS $$
	UPDATE value SET no=no+1 WHERE obj_id = $1 AND prop_id = $2;
	INSERT INTO value (obj_id,prop_id,value,no) VALUES ($1,$2,$3,0);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION insert_value (a_obj_id integer,a_prop text,a_value text) RETURNS void AS $$
BEGIN
	PERFORM insert_value(a_obj_id,prop_id(a_prop),a_value);
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

----------------------------
-- SET OLD VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_old_value (a_obj_id integer,a_prop_id integer,a_value text,a_user_id integer) RETURNS integer AS $$
	INSERT INTO old_value (obj_id,prop_id,value,old_time,user_id) VALUES ($1,$2,$3,now(),$4);
	SELECT $1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_old_value (a_obj_id integer,a_prop text,a_value text,a_user_id integer) RETURNS integer AS $$
	INSERT INTO old_value (obj_id,prop_id,value,old_time,user_id) VALUES ($1,prop_id($2),$3,now(),$4);
	SELECT $1;
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

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
			class := obj_class(a_obj_id);
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
CREATE OR REPLACE FUNCTION get_hierarchy_value (a_obj_id integer,a_prop text,a_path text) RETURNS text AS $$
	SELECT get_value(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer,a_prop_id integer,a_path text) RETURNS SETOF text AS $$
	SELECT get_values(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer,a_prop text,a_path text) RETURNS SETOF text AS $$
	SELECT get_values(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer,a_prop_id integer,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer,a_prop text,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer (a_obj_id integer,a_prop_id integer,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,$2,$3),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer,a_prop text,a_path text) RETURNS integer AS $$
	SELECT get_integer_value(find_obj_in_hierarchy($1,prop_id($2),$3),prop_id($2));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- PARAM
----------------------------
CREATE OR REPLACE FUNCTION param_id (a_name text) RETURNS integer AS $$
	SELECT prop_id(class_id('param'),$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION set_param (a_name text) RETURNS integer AS $$
	SELECT replace_prop(param_id($1),class_id('param'),$1,scalar_id('label'),NULL,NULL,NULL,NULL,NULL,NULL,NULL);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_param (a_obj_id integer,a_name text,a_value text) RETURNS integer AS $$
DECLARE
	the_id	integer;
	par_id	integer := param_id(a_name);
BEGIN
	IF a_value IS NULL THEN
		DELETE FROM value WHERE obj_id=a_obj_id AND prop_id=par_id;
	ELSIF EXISTS (SELECT 1 FROM obj WHERE obj_id=a_obj_id) THEN
		SELECT INTO the_id id FROM value WHERE obj_id=a_obj_id AND prop_id=par_id;
		IF the_id IS NOT NULL THEN
			UPDATE value SET value=a_value WHERE id=the_id;
		ELSE
			INSERT INTO value (obj_id,prop_id,value)
			VALUES (a_obj_id,coalesce(par_id,set_param(a_name)),a_value)
			RETURNING id INTO the_id;
		END IF;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_param (a_obj_id integer,a_name text,a_value integer) RETURNS integer AS $$
	SELECT set_param($1,$2,$3::text);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

----------------------------
-- TAG
----------------------------
CREATE OR REPLACE FUNCTION tag_id (a_type text) RETURNS integer AS $$
	SELECT ref_id($1,top_ref_id('tag'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION set_tag (a_obj_id integer,a_tag_id integer) RETURNS integer AS $$
	INSERT INTO tag (obj_id,tag_id) VALUES ($1,$2) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_tag (a_obj_id integer,a_tag text) RETURNS integer AS $$
	INSERT INTO tag (obj_id,tag_id) VALUES ($1,tag_id($2)) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- TAG2
----------------------------
CREATE OR REPLACE FUNCTION set_tag2 (a_src_id integer,a_dst_id integer,a_tag_id integer) RETURNS integer AS $$
	INSERT INTO tag2 (src_id,dst_id,tag_id) VALUES ($1,$2,$3) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_tag2 (a_src_id integer,a_dst_id integer,a_tag text) RETURNS integer AS $$
	INSERT INTO tag2 (src_id,dst_id,tag_id) VALUES ($1,$2,tag_id($3)) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_uniq_tag2 (a_src_id integer,a_dst_id integer,a_tag_id integer) RETURNS integer AS $$
DECLARE
	the_id integer;
BEGIN
	SELECT INTO the_id id FROM tag2 WHERE src_id=a_src_id AND tag_id=a_tag_id;
	IF the_id IS NOT NULL THEN
		UPDATE tag2 SET dst_id=a_dst_id WHERE id=the_id;
	ELSE
		INSERT INTO tag2 (src_id,dst_id,tag_id) VALUES (a_src_id,a_dst_id,a_tag_id)
		RETURNING id INTO the_id;
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

----------------------------
-- OBJECT
----------------------------
CREATE OR REPLACE FUNCTION obj_name (a_obj_id integer) RETURNS text AS $$
DECLARE
	class	text;
	name	text;
BEGIN
	SELECT INTO class,name r.name,get_value(obj_id,'class:obj_name',r.name)
	FROM ref r WHERE obj_id = (SELECT class_id FROM obj WHERE obj_id=$1);
	IF name IS NOT NULL THEN
		EXECUTE 'SELECT '||name||' FROM '||class||' WHERE obj_id='||$1 INTO name;
	END IF;
	RETURN name;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_full_name (a_obj_id integer) RETURNS text AS $$
	SELECT class_full_name(class_id)||':'||obj_name($1) FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_id (a_object text) RETURNS integer AS $$
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
CREATE OR REPLACE FUNCTION obj_id (a_class text, a_name text) RETURNS integer AS $$
DECLARE
	res	integer;
BEGIN
	EXECUTE 'SELECT '||a_class||'_id('''||a_name||''')' INTO res;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

--- VALUES DEBUG
CREATE OR REPLACE FUNCTION dump_value (a_value text) RETURNS text AS $$
	SELECT CASE WHEN $1~E'^\\d+$' AND EXISTS (SELECT 1 FROM obj WHERE obj_id=$1::integer) THEN obj_full_name($1::integer) ELSE $1 END
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION dump_all_values (a_obj_id integer) RETURNS text AS $$
	SELECT	cjoin(val)
	FROM	(
		SELECT		c.name||':'||p.name||'="'||v.value||'"' AS val
		FROM		value		v
		JOIN		prop		p ON p.obj_id=v.prop_id
		JOIN		ref		c ON c.obj_id=p.class_id
		WHERE		v.obj_id=$1
		ORDER BY	c.name,p.name,v.no
	)	AS a
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- BLACKLIST
----------------------------
CREATE OR REPLACE FUNCTION blacklist_id (a_class_id integer,a_user_id integer,a_name text) RETURNS integer AS $$
	SELECT obj_id FROM blacklist WHERE class_id=$1 AND user_id=$2 AND name=$3;
$$ LANGUAGE sql STABLE STRICT;
-- CREATE OR REPLACE FUNCTION in_blacklist (a_name text,a_class_id integer,a_user_id integer) RETURNS boolean AS $$
--  SELECT EXISTS (
--      SELECT 1 FROM blacklist WHERE $1 LIKE name AND class_id=$2 AND user_id IN (
--          SELECT client_resellers($3,for_myself)
--      )
--  )
-- $$ LANGUAGE sql STABLE STRICT;
-- CREATE OR REPLACE FUNCTION blacklist_check (a_name text,a_class text,a_user_id integer) RETURNS text AS $$
--	SELECT CASE WHEN in_blacklist($1,class_id($2),$3) THEN $1 ELSE NULL END
-- $$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION replace_blacklist (
	a_obj_id	integer,
	a_class_id	integer,
	a_user_id	integer,
	a_name		text,
	a_label		text
) RETURNS integer AS $$
DECLARE
	the_id	integer := a_obj_id;
	prep	replace_data;
BEGIN
	prep := (NULL,NULL,NULL);
	prep := prepare_replace(prep,'class_id',	a_class_id);
	prep := prepare_replace(prep,'user_id',		a_user_id);
	prep := prepare_replace(prep,'name',		a_name);
	IF the_id IS NULL THEN
		EXECUTE 'INSERT INTO blacklist ('||keys||') VALUES ('||vals||') RETURNING obj_id' INTO the_id;
	ELSIF sets!='' THEN
		EXECUTE 'UPDATE blacklist SET '||substr(sets,2)||' WHERE obj_id='||the_id;
	END IF;
	IF a_label IS NOT NULL THEN
		PERFORM set_obj_label(the_id,a_label);
	END IF;
	RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_blacklist (a_class_id integer,a_user_id integer,a_name text,a_label text) RETURNS integer AS $$
	SELECT replace_blacklist(blacklist_id($1,$2,$3),$1,$2,$3,$4);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
-- CREATE OR REPLACE FUNCTION set_blacklist (a_class text,a_user text,a_name text,a_label text) RETURNS integer AS $$
--  SELECT set_blacklist(class_id($1),client_id($2),$3,$4);
-- $$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;

----------------------------
-- SESSION
----------------------------
CREATE OR REPLACE FUNCTION init_session (a_user_id integer) RETURNS integer AS $$
BEGIN
	EXECUTE 'CREATE TEMPORARY TABLE session (name text,value text);';
	EXECUTE 'INSERT INTO session VALUES (''user_id'','''||a_user_id||''');';
	RETURN a_user_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION get_session_value (a_name text) RETURNS text AS $$
DECLARE
	res text;
BEGIN
	IF EXISTS (SELECT 1 FROM pg_class WHERE relname='session') THEN
		EXECUTE 'SELECT value FROM session WHERE name='''||a_name||'''' INTO res;
	ELSE
		RAISE NOTICE 'NO SESSION TABLE';
	END IF;
	RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_session_user_id () RETURNS integer AS $$
	SELECT str2num(get_session_value('user_id'))::integer;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- LOG
----------------------------
----------------------------
-- LOG_VAR
----------------------------

----------------------------
-- PG
----------------------------
CREATE OR REPLACE FUNCTION pg_typename (a_oid integer) RETURNS name AS $$
	SELECT typname FROM pg_type WHERE oid=$1;
$$ LANGUAGE sql STABLE STRICT;

