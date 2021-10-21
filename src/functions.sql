-- REPLACE
CREATE TYPE replace_data AS (keys text,vals text,sets text);
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value boolean) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value integer) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value double precision) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value text) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3) END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value timestamp) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value inet) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (INOUT a_data replace_data,name text,value jsonb) AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
        CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::jsonb) END,
        CASE WHEN $3 IS NULL THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::jsonb) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

--- REPLACE with old value
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data, a_name text, a_new text, a_old text) RETURNS replace_data AS $$
    SELECT  CASE WHEN a_new IS NULL THEN a_data.keys ELSE coalesce(a_data.keys||',','')||a_name END,
            CASE WHEN a_new IS NULL THEN a_data.vals ELSE coalesce(a_data.vals||',','')||quote_literal(a_new) END,
            CASE WHEN a_new IS NULL OR a_new=a_old THEN a_data.sets ELSE coalesce(a_data.sets||',','')||a_name||'='||quote_literal(a_new) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value boolean,old boolean) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value integer,old integer) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3 END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value double precision,old double precision) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||$3::text END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||$3::text END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value interval,old interval) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value timestamp,old timestamp) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value inet,old inet) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value macaddr, old macaddr) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::text) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::text) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value inet[],old inet[]) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data, a_name text, a_new jsonb, a_old jsonb) RETURNS replace_data AS $$
    SELECT  CASE WHEN a_new IS NULL THEN a_data.keys ELSE coalesce(a_data.keys||',','')||a_name END,
            CASE WHEN a_new IS NULL THEN a_data.vals ELSE coalesce(a_data.vals||',','')||quote_literal(CASE WHEN a_old IS NULL THEN a_new ELSE a_old||a_new END) END,
            CASE WHEN a_new IS NULL OR a_new=a_old THEN a_data.sets ELSE coalesce(a_data.sets||',','')||a_name||'='||quote_literal(CASE WHEN a_old IS NULL THEN a_new ELSE a_old||a_new END) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION prepare_replace (a_data replace_data,name text,value uuid,old uuid) RETURNS replace_data AS $$
    SELECT  CASE WHEN $3 IS NULL THEN $1.keys ELSE coalesce($1.keys||',','')||$2 END,
            CASE WHEN $3 IS NULL THEN $1.vals ELSE coalesce($1.vals||',','')||quote_literal($3::uuid) END,
            CASE WHEN $3 IS NULL OR $3=$4 THEN $1.sets ELSE coalesce($1.sets||',','')||$2||'='||quote_literal($3::uuid) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

-- prepare replace with force
CREATE OR REPLACE FUNCTION prepare_replace (a replace_data, name text, value integer, old integer, force boolean) RETURNS replace_data AS $$
    SELECT  CASE WHEN force OR  value IS NOT NULL THEN a.keys ELSE coalesce(a.keys||',','')||name END,
            CASE WHEN force OR  value IS NOT NULL THEN a.vals ELSE coalesce(a.vals||',','')||coalesce(value::text, 'NULL') END,
            CASE WHEN force OR (value IS NOT NULL AND value IS DISTINCT FROM old)
                                                  THEN a.sets ELSE coalesce(a.sets||',','')||name||'='||coalesce(value::text, 'NULL') END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

-- force replace
CREATE OR REPLACE FUNCTION force_replace (a replace_data, name text, value integer) RETURNS replace_data AS $$
    SELECT  coalesce(a.keys||',','')||name,
            coalesce(a.vals||',','')||coalesce(value::text, 'NULL'),
            coalesce(a.sets||',','')||name||'='||coalesce(value::text, 'NULL');
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION force_replace (a replace_data, name text, value timestamp) RETURNS replace_data AS $$
    SELECT  coalesce(a.keys||',','')||name,
            coalesce(a.vals||',','')||coalesce(quote_literal(value), 'NULL'),
            coalesce(a.sets||',','')||name||'='||coalesce(quote_literal(value), 'NULL');
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

--- DEBUG
CREATE OR REPLACE FUNCTION raise_notice (a text) RETURNS boolean AS $$
BEGIN
    RAISE NOTICE '%',a;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION raise_exception (a text) RETURNS boolean AS $$
BEGIN
    RAISE EXCEPTION '%',a;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE STRICT;


-- CJOIN
CREATE OR REPLACE FUNCTION cjoin (a_strs text[]) RETURNS text AS $$
    SELECT array_to_string($1,',');
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION cjoin (a_strs text[],a_delimiter text) RETURNS text AS $$
    SELECT array_to_string($1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION join (a_strs text[],a_delimiter text) RETURNS text AS $$
    SELECT array_to_string($1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;

--- STRING functions
CREATE OR REPLACE FUNCTION collapse_spaces (a text) RETURNS text AS $$
    SELECT regexp_replace($1,E'\\s+',' ','g');
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

-- LANG
CREATE OR REPLACE FUNCTION unlang (a_str text) RETURNS text AS $$
    SELECT regexp_replace(a_str, '\{lang:(.+?)\}', '\1', 'gi');
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

-- SCHEMA
CREATE OR REPLACE FUNCTION find_primary_key (a_table text, a_namespace text) RETURNS text AS $$
	SELECT  min(a.attname)
	FROM	pg_index		i
	JOIN	pg_class		c ON c.oid = i.indrelid AND c.oid = a_table::regclass
	JOIN	pg_attribute	a ON a.attrelid = c.oid AND a.attnum = any(i.indkey)
	JOIN	pg_namespace	n ON n.oid = c.relnamespace AND n.nspname = a_namespace::name
	WHERE	i.indisprimary
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION find_primary_key (a_table text) RETURNS text AS $$
	SELECT find_primary_key(a_table, 'public');
$$ LANGUAGE sql IMMUTABLE STRICT;

-- DIFF
CREATE OR REPLACE FUNCTION shorten (a text,len integer) RETURNS text AS $$
    SELECT CASE WHEN length($1)>$2 THEN left($1,$2-3)||'...' ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text) RETURNS text AS $$
    SELECT CASE WHEN $1!='' THEN $1 ELSE $2 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text) RETURNS text AS $$
    SELECT CASE
        WHEN $1!='' THEN $1
        WHEN $2!='' THEN $2
        ELSE $3
    END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text) RETURNS text AS $$
    SELECT CASE
        WHEN $1!='' THEN $1
        WHEN $2!='' THEN $2
        WHEN $3!='' THEN $3
        ELSE $4
    END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION nonempty (a_1 text,a_2 text,a_3 text,a_4 text,a_5 text) RETURNS text AS $$
    SELECT CASE
        WHEN $1!='' THEN $1
        WHEN $2!='' THEN $2
        WHEN $3!='' THEN $3
        WHEN $4!='' THEN $4
        ELSE $5
    END;
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
    SELECT substr(encode(decode(md5(random()::text),'hex'),'base64'),1,16);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION md5bigint (a_str text) RETURNS bigint AS $$
    SELECT ('x'||md5(a_str))::bit(64)::bigint;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION random_text(a_length int) RETURNS text AS $$
DECLARE
    chars text := '23456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPRSTUVWXYZ';
    result text;
BEGIN
    SELECT INTO result array_to_string(array(
        SELECT SUBSTRING(chars FROM floor(random()*length(chars))::int+1 FOR 1)
        FROM generate_series(1, a_length)
    ), '');

    RETURN result;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION random_between(minimum int, maximum int) RETURNS int AS $$
    SELECT (random() * (maximum-minimum+1) + minimum)::integer;
$$ LANGUAGE sql VOLATILE STRICT;




--- IP2INT & INT2IP functions
CREATE OR REPLACE FUNCTION ip2int (a text) RETURNS integer AS $$
BEGIN
    BEGIN
        RETURN a::inet-'0.0.0.0'::inet;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ip2int (a inet) RETURNS integer AS $$
BEGIN
    BEGIN
        RETURN a-'0.0.0.0'::inet;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION int2ip (a integer) RETURNS inet AS $$
    SELECT '0.0.0.0'::inet+$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION inet_address_count (a inet) RETURNS double precision AS $$
DECLARE
    max_mask_length int = CASE WHEN family(a) = '4' THEN 32 ELSE 128 END;
BEGIN
    -- Returns number of IP addresses, used by this prefix
    -- IPv6 networks may have enormous IP address count, so function returns DOUBLE PRECISION

    RETURN 2 ^ (max_mask_length - masklen(a));
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- STR2something
CREATE OR REPLACE FUNCTION str2inet (a text) RETURNS inet AS $$
BEGIN
    BEGIN
        RETURN a::inet;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2inets (a text) RETURNS inet[] AS $$
BEGIN
    BEGIN
        RETURN csplit(a)::inet[];
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2boolean (a text) RETURNS boolean AS $$
BEGIN
    BEGIN
        RETURN a::boolean;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2boolean (a boolean) RETURNS boolean AS $$
BEGIN
    RETURN a;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2smallint (a text) RETURNS smallint AS $$
BEGIN
    BEGIN
        RETURN a::smallint;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2integer (a text) RETURNS integer AS $$
BEGIN
    BEGIN
        RETURN a::integer;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2integers (a text) RETURNS integer[] AS $$
BEGIN
    BEGIN
        RETURN csplit(a)::integer[];
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2integers (a text, def integer[]) RETURNS integer[] AS $$
BEGIN
    BEGIN
        RETURN coalesce(csplit(a)::integer[], def);
    EXCEPTION WHEN OTHERS THEN
        RETURN def;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2bigint (a text) RETURNS bigint AS $$
BEGIN
    BEGIN
        RETURN a::bigint;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2bigints (a text) RETURNS bigint[] AS $$
BEGIN
    BEGIN
        RETURN csplit(a)::bigint[];
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2uuid (a text) RETURNS uuid AS $$
BEGIN
    BEGIN
        RETURN a::uuid;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2double (a text) RETURNS double precision AS $$
BEGIN
    BEGIN
        RETURN a::double precision;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2numeric (a text) RETURNS numeric AS $$
BEGIN
    BEGIN
        RETURN a::numeric;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2date (a text) RETURNS timestamp AS $$
BEGIN
    BEGIN
        RETURN a::date;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2timestamp (a text) RETURNS timestamp AS $$
BEGIN
    BEGIN
        RETURN a::timestamp;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION _str2interval (a text) RETURNS interval AS $$
BEGIN
    BEGIN
        RETURN a::interval;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2interval (a text) RETURNS interval AS $$
    SELECT coalesce(_str2interval($1),_str2interval('1'||$1));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION str2jsonb (a text) RETURNS jsonb AS $$
BEGIN
    BEGIN
        RETURN a::jsonb;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- OLD STR2something
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
CREATE OR REPLACE FUNCTION fraction2num (a text,def numeric) RETURNS numeric AS $$
DECLARE
    result numeric;
    numerator numeric;
    denominator numeric;
BEGIN
    IF a !~ '^[\d.]+/[\d.]+$' THEN
        RETURN def;
    END IF;

    SELECT INTO numerator substring(a from '^(.+)/');
    SELECT INTO denominator substring(a from '/(.+)$');
    IF denominator = 0 THEN
        RAISE EXCEPTION 'denominator must be > 0';
    END IF;

    BEGIN
        SELECT INTO result numerator/denominator;
    EXCEPTION
        WHEN OTHERS THEN
        -- do nothing
    END;
    RETURN coalesce(result,def);
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
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
CREATE OR REPLACE FUNCTION str2macaddr(a text) RETURNS MACADDR AS
$$
BEGIN
    RETURN a::MACADDR;
    EXCEPTION WHEN OTHERS THEN
    RETURN NULL;
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

CREATE OR REPLACE FUNCTION ahrefify (a_txt text) RETURNS text AS $$
    SELECT regexp_replace($1,E'(https?://\\S+)',E'<a href="\\1">\\1</a>','g');
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;

-- EMAIL
CREATE OR REPLACE FUNCTION is_email (a_email text) RETURNS boolean AS $$
    SELECT $1~*'^[a-z0-9_.+-]+@[a-z0-9.-]+$';
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION email_hash (a_email text) RETURNS text AS $$
    SELECT md5(lower(trim($1)));
$$ LANGUAGE sql IMMUTABLE STRICT;

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

--- CRYPTO
CREATE OR REPLACE FUNCTION sha1 (a_str bytea) returns text AS $$
    SELECT encode(digest(a_str, 'sha1'), 'hex');
$$ LANGUAGE sql STRICT IMMUTABLE;

--- PASSWORD
CREATE OR REPLACE FUNCTION is_crypted (a_pwd text) RETURNS boolean AS $$
    SELECT a_pwd ~E'^\\$\\w+\\$\\S+$';
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION check_password (a_test text, a_pwd text) RETURNS boolean AS $$
    SELECT a_pwd = crypt(a_test, a_pwd);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION crypt_password (a_pwd text, algo text) RETURNS text AS $$
    SELECT CASE WHEN is_crypted(a_pwd) THEN a_pwd ELSE crypt(a_pwd, gen_salt(algo)) END;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION crypt_password (a_pwd text, algo text, iter_count integer) RETURNS text AS $$
    SELECT CASE WHEN is_crypted(a_pwd) THEN a_pwd ELSE crypt(a_pwd, gen_salt(algo, iter_count)) END;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION crypt_password (a_pwd text) RETURNS text AS $$
    SELECT crypt_password(a_pwd, 'bf', 7);
$$ LANGUAGE sql VOLATILE STRICT;

--CREATE OR REPLACE FUNCTION last_strpos (haystack text,needle char) RETURNS integer AS
--  '/www/rcp3/src/sql/last_strpos','last_strpos'
--LANGUAGE c IMMUTABLE STRICT;

----------------------------
-- TO DATE/TIME
----------------------------
CREATE OR REPLACE FUNCTION to_epoch (timestamp with time zone) RETURNS bigint AS $$
    SELECT date_part('epoch',$1)::bigint;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_epoch (timestamp) RETURNS bigint AS $$
    SELECT date_part('epoch',$1)::bigint;
$$ LANGUAGE sql IMMUTABLE STRICT;
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
        WHEN $1>'1year' THEN date_part('month',$1)||' monthes'
        WHEN $1>'1day'  THEN date_part('day',$1)||' days'
        WHEN $1>'1hour' THEN date_part('hour',$1)||' hours'
                ELSE date_part('minute',$1)||' minutes'
    END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION monthdiff (a_from timestamp,a_till timestamp) RETURNS double precision AS $$
    SELECT date_part('year',age($1,$2))*12+date_part('month',age($1,$2))+(CASE WHEN date_part('day',age($1,$2))>27 THEN 1 ELSE 0 END);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION datediff (a_period interval,a_from timestamp,a_till timestamp) RETURNS double precision AS $$
    SELECT CASE
        WHEN $1>='1month' THEN monthdiff($2,$3)/(date_part('epoch',$1)/date_part('epoch','1month'::interval))
        ELSE date_part('epoch',age($2,$3))/date_part('epoch',$1)
    END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION renew_expires (a_period interval,a_expires timestamp,a_sale_time timestamp,a_amount integer) RETURNS timestamp AS $$
    SELECT $3+$1*(datediff($1,$2,$3)+$4);
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
-- PERIOD OPERATIONS
----------------------------
CREATE OR REPLACE FUNCTION period_from (a_init timestamp,a_period interval,a_now timestamp) RETURNS timestamp AS $$
    SELECT $1+$2*floor(date_part('epoch',$3-$1)/date_part('epoch',$2));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION period_till (a_init timestamp,a_period interval,a_now timestamp) RETURNS timestamp AS $$
    SELECT period_from($1,$2,$3)+$2;
$$ LANGUAGE sql IMMUTABLE STRICT;

----------------------------
--- INTERVAL TABLE
----------------------------
CREATE OR REPLACE FUNCTION interval_table(a_terms text[]) RETURNS TABLE (term text, since timestamp, till timestamp) AS $$
BEGIN
    RETURN QUERY
        WITH iterms AS (
            SELECT  unnest AS term, unnest::interval AS iterm
            FROM    unnest(a_terms)
        )
        SELECT      t.term,
                    now()::timestamp+coalesce(max(s.iterm), '0day'::interval) AS since,
                    now()::timestamp+t.iterm AS till
        FROM        iterms  t
        LEFT JOIN   iterms  s ON s.iterm<t.iterm
        GROUP BY    t.term,t.iterm
        ORDER BY    t.iterm;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION interval_table(a_terms text) RETURNS TABLE (term text, since timestamp, till timestamp) AS $$
    SELECT interval_table(string_to_array($1, ','));
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
CREATE OR REPLACE FUNCTION today () RETURNS timestamp AS $$
    SELECT date_trunc('day',now()::timestamp);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION today (timestamp with time zone) RETURNS timestamp AS $$
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
    SELECT date_trunc('month',coalesce($1,now())::timestamp-'1month'::interval);
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
CREATE OR REPLACE FUNCTION next_year () RETURNS timestamp AS $$
    SELECT date_trunc('year',now()::timestamp+'1year'::interval);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION days_in_month (timestamp with time zone) RETURNS integer AS $$
    SELECT date_part('day',to_month($1+'1month')-to_month($1))::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION seconds_in_month (timestamp without time zone) RETURNS integer AS $$
    -- This procedure is not DST tolerant
    SELECT days_in_month($1) * 86400;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION days2quantity (a_day timestamp with time zone,a_month timestamp with time zone) RETURNS double precision AS $$
    SELECT CASE
        WHEN $1 IS NULL THEN 1
        WHEN to_month($1)>to_month($2) THEN 0
        WHEN to_month($1)<to_month($2) THEN 1
        ELSE 1 - ((date_part('day',$1)-1)/days_in_month($1))
    END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION fraction_of_month (
    a_start_time timestamp without time zone,
    a_end_time timestamp without time zone,
    a_month timestamp without time zone
) RETURNS double precision AS $$
DECLARE
    a_month timestamp without time zone := to_month(a_month);
    period_start_time timestamp without time zone := greatest(a_start_time, a_month);
    period_end_time timestamp without time zone := least(a_end_time, next_month(a_month));
BEGIN
    IF a_start_time IS NULL THEN
        RETURN 1;
    END IF;

    IF a_end_time < a_start_time THEN
        RAISE EXCEPTION 'Start date "%" MUST NOT be greater than the end date "%"', a_start_time, a_end_time;
    END IF;

    RETURN
        (EXTRACT(EPOCH FROM period_end_time) - EXTRACT(EPOCH FROM period_start_time))
            /
        seconds_in_month(a_month);
END;
$$ LANGUAGE plpgsql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION quantity2seconds (a_quantity double precision, a_month timestamp without time zone) RETURNS integer AS $$
    SELECT round(a_quantity*seconds_in_month(a_month))::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION quantity2days (a_quantity double precision,a_month timestamp without time zone) RETURNS integer AS $$
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
CREATE OR REPLACE FUNCTION to_cents (a_sum double precision) RETURNS double precision AS $$
    SELECT (a_sum::numeric * 100)::double precision;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_cents (a_sum numeric) RETURNS integer AS $$
    SELECT trunc($1 * 100)::integer;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_cents (a_amount text) RETURNS integer AS $$
    SELECT trunc(str2numeric(a_amount) * 100)::integer;
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
CREATE OR REPLACE FUNCTION to_1 (boolean) RETURNS text AS $$
    SELECT CASE WHEN $1 THEN '1' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_1 (text) RETURNS text AS $$
    SELECT CASE WHEN $1!='' THEN '1' END;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION to_1 (numeric) RETURNS text AS $$
    SELECT CASE WHEN $1!=0 THEN '1' END;
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
CREATE OR REPLACE FUNCTION to_plus (boolean) RETURNS text AS $$
    SELECT CASE WHEN $1 THEN '+' END;
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
-- GET OBJ CLASS/STATE/FIELD
----------------------------
CREATE OR REPLACE FUNCTION get_obj_class_id (a_obj_id integer) RETURNS integer AS $$
    SELECT class_id FROM obj WHERE obj_id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_class (a_obj_id integer) RETURNS text AS $$
    SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_field (a_obj_id integer, a_field text, a_table text) RETURNS text AS $$
DECLARE
    res     text;
BEGIN
    EXECUTE 'SELECT '||a_field||' FROM '||a_table||' WHERE obj_id='||a_obj_id INTO res;
    RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_field (a_obj_id integer, a_field text) RETURNS text AS $$
DECLARE
    pos     integer := strpos(a_field, ':');
    z_class text;
BEGIN
    IF pos=0 THEN
        z_class := get_obj_class(a_obj_id);
    ELSE
        z_class := substr(a_field, 0, pos);
        a_field := substr(a_field, pos + 1);
    END IF;
    RETURN get_obj_field(a_obj_id, a_field, z_class);
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_state_id (a_obj_id integer) RETURNS integer AS $$
DECLARE
    res integer;
BEGIN
    BEGIN
        EXECUTE 'SELECT state_id FROM '|| (
            SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=a_obj_id)
        ) ||' WHERE obj_id='||a_obj_id INTO res;
        RETURN res;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_state (a_obj_id integer) RETURNS text AS $$
DECLARE
    res text;
BEGIN
    BEGIN
        EXECUTE 'SELECT name FROM ref WHERE obj_id=(SELECT state_id FROM '|| (
            SELECT name FROM ref WHERE obj_id=(SELECT class_id FROM obj WHERE obj_id=a_obj_id)
        ) ||' WHERE obj_id='||a_obj_id||')' INTO res;
        RETURN res;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_label (a_obj_id integer) RETURNS text AS $$
      SELECT label FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_create_time (a_obj_id integer) RETURNS timestamp AS $$
      SELECT create_time FROM obj WHERE obj_id = $1;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_label_descr (a_obj_id integer, OUT label text, OUT descr text ) RETURNS SETOF record AS $$
BEGIN
      RETURN QUERY
      SELECT    o.label,o.descr
      FROM      obj AS o
      WHERE     o.obj_id = a_obj_id;
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
CREATE OR REPLACE FUNCTION set_obj_update_time (a_obj_id integer) RETURNS void AS $$
    UPDATE obj SET update_time=now() WHERE obj_id=$1;
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- REF
----------------------------
CREATE OR REPLACE FUNCTION ref_parent_id (a_obj_id integer) RETURNS integer AS $$
    SELECT _id FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;
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
CREATE OR REPLACE FUNCTION ref_id (parent text, name text) RETURNS integer AS $$
    SELECT sub_ref_id(name, ref_id(parent));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (text,text,text) RETURNS integer AS $$
    SELECT obj_id FROM ref WHERE name=$3 AND _id=ref_id($1,$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_id (text,text,text,text) RETURNS integer AS $$
    SELECT obj_id FROM ref WHERE name=$4 AND _id=ref_id($1,$2, $3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent_id integer,a_types text) RETURNS integer[] AS $$
    SELECT array_agg(obj_id) FROM ref WHERE _id=$1 AND name=ANY(csplit($2));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent_id integer,a_names text[]) RETURNS integer[] AS $$
    SELECT array_agg(obj_id) FROM ref WHERE _id=$1 AND name=ANY($2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_types text) RETURNS integer[] AS $$
    SELECT array_agg(obj_id) FROM ref WHERE _id=ref_id($1) AND name=ANY(csplit($2));
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
CREATE OR REPLACE FUNCTION ref_ids (a_parent text,a_names text[]) RETURNS integer[] AS $$
    SELECT array_agg(obj_id) FROM ref WHERE _id=ref_id($1) AND name=ANY($2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_name (a_obj_id integer) RETURNS text AS $$
    SELECT name FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_in (a_obj_id integer,a_names text) RETURNS boolean AS $$
    SELECT name = ANY(csplit($2)) FROM ref WHERE obj_id=$1;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION ref_pname (a_obj_id integer) RETURNS text AS $$
    SELECT name FROM ref WHERE obj_id=(SELECT _id FROM ref WHERE obj_id=$1);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION ref_g2name (a_obj_id integer) RETURNS text AS $$
    SELECT      pt.name||','||zt.name
    FROM        ref     zt
    JOIN        ref     pt ON pt.obj_id = zt._id
    WHERE       zt.obj_id = a_obj_id
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
    the_id  integer := ref_id(a_ref);
    pos integer;
BEGIN
    IF the_id IS NULL THEN
        pos := last_strpos(a_ref,',');
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
    SELECT CASE WHEN $1='class' THEN 1 ELSE sub_ref_id($1,1) END;
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
CREATE OR REPLACE FUNCTION type_id (a_ggparent text,a_grandparent text,a_parent text,a_ref text) RETURNS integer AS $$
    SELECT obj_id FROM ref WHERE name=$4 AND _id=ref_id('type',$1,$2,$3);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_ids (a_parent text,a_names text[]) RETURNS integer[] AS $$
    SELECT ref_ids(type_id($1),$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION type_ids (a_parent text,a_names text) RETURNS integer[] AS $$
    SELECT ref_ids(type_id($1),$2);
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
    SELECT ref_ids(ref_id('state',$1),$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_ids (a_parent text,a_names text) RETURNS integer[] AS $$
    SELECT ref_ids(ref_id('state',$1),$2);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION state_full_name (a_obj_id integer) RETURNS text AS $$
    SELECT ref_full_name($1,top_ref_id('state'));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION prev_state_id (a_obj_id integer) RETURNS integer AS $$
    SELECT      s.type_id
    FROM        status      s
    JOIN        ref     t ON t.obj_id=s.type_id AND s.object_id=$1
    JOIN        ref     y ON y.obj_id=t._id AND y._id=top_ref_id('state')
    ORDER BY    s.time DESC
    LIMIT       1
    OFFSET      1;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- STATUS
----------------------------
CREATE OR REPLACE FUNCTION status_id (a_name text) RETURNS integer AS $$
    SELECT ref_id(a_name, top_ref_id('status'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION status_id (a_parent text, a_name text) RETURNS integer AS $$
    SELECT ref_id(a_name, status_id(a_parent));
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
CREATE OR REPLACE FUNCTION is_status (a_obj_id integer, a_type text) RETURNS boolean AS $$
    SELECT time IS NOT NULL FROM status WHERE object_id = a_obj_id AND type_id = status_id(a_type);
$$ LANGUAGE sql STABLE STRICT;
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
-- XXX important: this function DOES change the time of the status if it already exists, for not changing use add_status
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_subject_id integer,a_type_id integer,a_time timestamp) RETURNS integer AS $$
DECLARE
    the_id      integer;
    the_time    timestamp;
    b_time      timestamp := coalesce(a_time,now());
BEGIN
    SELECT INTO the_id,the_time id,time FROM status WHERE object_id=a_obj_id AND type_id=a_type_id;
    IF the_id IS NULL THEN
        INSERT INTO status (object_id,subject_id,type_id,time)
        VALUES (a_obj_id,a_subject_id,a_type_id,b_time) RETURNING id INTO the_id;
    ELSIF the_time!=b_time THEN
        UPDATE status SET subject_id=coalesce(a_subject_id,subject_id),time=b_time WHERE id=the_id;
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
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type_id integer) RETURNS integer AS $$
    SELECT set_status($1,NULL,$2,NULL);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type text) RETURNS integer AS $$
    SELECT set_status($1,status_id($2),now());
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION reset_status (a_obj_id integer,a_type text) RETURNS integer AS $$
    SELECT set_status($1,status_id($2),now());
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_status (a_obj_id integer,a_type_id integer) RETURNS integer AS $$
    SELECT set_status(a_obj_id, a_type_id, now());
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_status (a_obj_id integer,a_type_id integer) RETURNS integer AS $$
DECLARE
    z_id        integer;
BEGIN
    SELECT INTO z_id id FROM status WHERE object_id=a_obj_id AND type_id=a_type_id;
    IF z_id IS NULL THEN
        INSERT INTO status (object_id,type_id) VALUES (a_obj_id,a_type_id) RETURNING id INTO z_id;
    END IF;
    RETURN z_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION del_status (a_obj_id integer,a_type text) RETURNS void AS $$
    DELETE FROM status WHERE object_id=$1 AND type_id=status_id($2);
$$ LANGUAGE sql VOLATILE STRICT;
-- TODO redo this way: if current statuses differ from given then delete and insert else do nothing
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,a__id integer,statuses text[],a_subject_id integer) RETURNS integer AS $$
DECLARE
    row record;
    n_has   boolean;
    adds    integer[];
    dels    integer[];
BEGIN
    FOR row IN
        SELECT      t.obj_id,t.name,s.id IS NOT NULL AS has
        FROM        ref t
        LEFT JOIN   status  s ON s.type_id=t.obj_id AND s.object_id=a_obj_id
        WHERE       t._id=a__id
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
        INSERT INTO status (object_id,type_id,subject_id)
        SELECT a_obj_id,obj_id,a_subject_id FROM ref WHERE obj_id=ANY(adds);
    END IF;
    IF dels>'{}'::integer[] THEN
        DELETE FROM status WHERE object_id=a_obj_id AND type_id=ANY(dels);
    END IF;
    RETURN a_obj_id;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,a__id integer,statuses text[]) RETURNS integer AS $$
    SELECT set_statuses($1, $2, $3, NULL);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,parent text,statuses text[]) RETURNS integer AS $$
    SELECT set_statuses($1,status_id($2),$3, NULL);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_statuses (a_obj_id integer,parent text,statuses text) RETURNS integer AS $$
    SELECT set_statuses($1,status_id($2),csplit($3), NULL);
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
-- PROP
----------------------------
CREATE OR REPLACE FUNCTION prop_id (a_prop text) RETURNS integer AS $$
DECLARE
    pos integer;
BEGIN
    pos := position(':' in a_prop);
    RETURN  obj_id FROM prop
    WHERE   name = substr(a_prop, pos + 1)
        AND CASE    WHEN pos=0 THEN TRUE
                    ELSE class_id=class_id(substr(a_prop, 0, pos))
            END
    LIMIT   1;
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
    a_obj_id        integer,    -- $1
    a_class_id      integer,    -- $2
    a_name          text,       -- $3
    a_type_id       integer,    -- $4
    a_no            integer,    -- $5
    a_def           text,       -- $6
    a_is_in_table   boolean,    -- $7
    a_can_be_null   boolean,    -- $8
    a_is_required   boolean,    -- $9
    a_is_repeated   boolean,    -- $10
    a_label         text        -- $11
) RETURNS integer AS $$
DECLARE
    the_id  integer := a_obj_id;
    prep    replace_data;
BEGIN
    prep := (NULL,NULL,NULL);
    prep := prepare_replace(prep,   'class_id',     a_class_id);
    prep := prepare_replace(prep,   'name',         a_name);
    prep := prepare_replace(prep,   'type_id',      a_type_id);
    prep := prepare_replace(prep,   'no',           a_no);
    prep := prepare_replace(prep,   'def',          a_def);
    prep := prepare_replace(prep,   'is_in_table',  a_is_in_table);
    prep := prepare_replace(prep,   'can_be_null',  a_can_be_null);
    prep := prepare_replace(prep,   'is_required',  a_is_required);
    prep := prepare_replace(prep,   'is_repeated',  a_is_repeated);
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
    a_no            integer,    -- $1
    a_prop          text,       -- $2
    a_type_id       integer,    -- $3
    a_label         text,       -- $4
    a_def           text,       -- $5
    a_is_in_table   boolean,    -- $6
    a_can_be_null   boolean,    -- $7
    a_is_required   boolean,    -- $8
    a_is_repeated   boolean     -- $9
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
-- GET INT VALUE
----------------------------
CREATE OR REPLACE FUNCTION get_int_value (a_obj_id integer, a_prop_id integer) RETURNS integer AS $$
    SELECT str2int(get_value(a_obj_id, a_prop_id));
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_int_value (a_obj_id integer, a_prop_id integer, a_def integer) RETURNS integer AS $$
    SELECT str2int(get_value(a_obj_id, a_prop_id), a_def);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_int_value (a_obj_id integer,a_prop text) RETURNS integer AS $$
    SELECT str2int(get_value(a_obj_id, a_prop));
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_int_value (a_obj_id integer, a_prop text, a_def integer) RETURNS integer AS $$
    SELECT str2int(get_value(a_obj_id, a_prop), a_def);
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

----------------------------
-- DEPRECATED: GET INTEGER VALUE
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
    SELECT      p.name,coalesce(v.value,p.def) as value
    FROM        prop p
    LEFT JOIN   value v     ON v.prop_id=p.obj_id AND v.obj_id=$1
    WHERE       p.class_id=$2;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION get_props_values (a_obj_id integer,a_class text) RETURNS TABLE(name text, value text) AS $$
    SELECT *  FROM get_props_values($1, class_id($2));
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- IS SET VALUE
----------------------------
CREATE OR REPLACE FUNCTION is_set_value (a_obj_id integer,a_prop_id integer) RETURNS boolean AS $$
    SELECT EXISTS (SELECT 1 FROM value WHERE obj_id = $1 AND prop_id = $2);
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- SET VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop_id integer,a_value text) RETURNS integer AS $$
DECLARE
    the_id      integer;
    the_def     text;
    the_value   text;
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
    SELECT set_value(a_obj_id,prop_id(a_prop),a_value);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_prop text,a_value integer) RETURNS integer AS $$
    SELECT set_value(a_obj_id,prop_id(a_prop),a_value::text);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_value (a_obj_id integer,a_class text,a_prop text,a_value text) RETURNS integer AS $$
    SELECT set_value(a_obj_id,prop_id(a_class,a_prop),a_value);
$$ LANGUAGE sql VOLATILE;

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
    the_id      integer;
    the_def     text;
    the_value   text;
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
-- SET TABLE VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_table_value (a_obj_id integer, a_table text, a_column text, a_value text, a_pk text) RETURNS integer AS $$
DECLARE
    the_id integer;
BEGIN
    EXECUTE 'UPDATE '||a_table||' SET '||a_column||' = '||quote_literal(a_value)||' WHERE '||a_pk||'='||a_obj_id||' RETURNING '||a_pk INTO the_id;
    RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_table_value (a_obj_id integer, a_table text, a_column text, a_value text) RETURNS integer AS $$
BEGIN
	RETURN set_table_value(a_obj_id, a_table, a_column, a_value, coalesce(find_primary_key(a_table), 'id'));
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

----------------------------
-- SET INTEGER VALUE
----------------------------
CREATE OR REPLACE FUNCTION set_integer_value (a_obj_id integer,a_prop_id integer,a_value integer) RETURNS integer AS $$
DECLARE
    the_id  integer;
    the_def integer;
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
    the_pos     integer;
    the_value   text;
BEGIN
    the_pos := strpos(a_values,',');
    IF the_pos > 0 THEN
        PERFORM add_values(a_obj_id,a_prop_id,substr(a_values,the_pos+1));
        the_value   := btrim(substr(a_values,0,the_pos));
    ELSE
        the_value   := btrim(a_values);
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
--- HIERARCHY VALUES
----------------------------
CREATE OR REPLACE FUNCTION root_obj_id () RETURNS integer AS $$
    SELECT 0;
$$ LANGUAGE sql IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION find_obj_in_hierarchy (a_obj_id integer, a_prop_id integer, a_path text) RETURNS integer AS $$
DECLARE
    z_field     text;
    next_path   text;
    next_id     integer;
    pos         integer := 0;
BEGIN
    IF is_set_value(a_obj_id, a_prop_id) THEN
        RETURN a_obj_id;
    END IF;

    IF length(a_path) > 0 THEN
        pos := strpos(a_path, ',');
        IF pos=0 THEN
            z_field := a_path;
        ELSE
            z_field := substr(a_path, 0, pos);
        END IF;
        next_id := get_obj_field(a_obj_id, z_field);
    END IF;

    IF pos > 0 THEN
        next_path := substr(a_path, pos+1);
        IF next_path='...' THEN
            next_path := a_path;
        END IF;
        IF a_obj_id = root_obj_id() OR a_obj_id = next_id THEN
            RETURN null;
        END IF;

        RETURN find_obj_in_hierarchy(next_id, a_prop_id, next_path);
    END IF;

    RETURN CASE WHEN is_set_value(next_id, a_prop_id) THEN next_id ELSE root_client_id() END;
END;
$$ LANGUAGE plpgsql STABLE STRICT;

CREATE OR REPLACE FUNCTION get_hierarchy_value (a_obj_id integer, a_prop_id integer, a_path text) RETURNS text AS $$
    SELECT get_value(find_obj_in_hierarchy(a_obj_id, a_prop_id, a_path), a_prop_id);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_value (a_obj_id integer, a_prop text, a_path text) RETURNS text AS $$
    SELECT get_value(find_obj_in_hierarchy(a_obj_id, prop_id(a_prop), a_path), prop_id(a_prop));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer, a_prop_id integer, a_path text) RETURNS SETOF text AS $$
    SELECT get_values(find_obj_in_hierarchy(a_obj_id, a_prop_id, a_path), a_prop_id);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_hierarchy_values (a_obj_id integer, a_prop text, a_path text) RETURNS SETOF text AS $$
    SELECT get_values(find_obj_in_hierarchy(a_obj_id, prop_id(a_prop), a_path), prop_id(a_prop));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer, a_prop_id integer, a_path text) RETURNS integer AS $$
    SELECT get_integer_value(find_obj_in_hierarchy(a_obj_id, a_prop_id, a_path), a_prop_id);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer, a_prop text, a_path text) RETURNS integer AS $$
    SELECT get_integer_value(find_obj_in_hierarchy(a_obj_id, prop_id(a_prop), a_path), prop_id(a_prop));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer (a_obj_id integer, a_prop_id integer, a_path text) RETURNS integer AS $$
    SELECT get_integer_value(find_obj_in_hierarchy(a_obj_id, a_prop_id, a_path), a_prop_id);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_integer_hierarchy_value (a_obj_id integer, a_prop text, a_path text) RETURNS integer AS $$
    SELECT get_integer_value(find_obj_in_hierarchy(a_obj_id, prop_id(a_prop), a_path), prop_id(a_prop));
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
    the_id  integer;
    par_id  integer := param_id(a_name);
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
CREATE OR REPLACE FUNCTION get_param (a_obj_id integer,a_name text) RETURNS text AS $$
    SELECT value FROM value WHERE obj_id=$1 AND prop_id=param_id($2);
$$ LANGUAGE sql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION set_params (a_obj_id integer,a_params hstore) RETURNS text AS $$
DECLARE
    a RECORD;
    res integer;
BEGIN
    FOR a IN SELECT * FROM each(a_params) LOOP
        res := set_param(a_obj_id,a.key,a.value);
    END LOOP;
    return res;
END;
$$ LANGUAGE plpgsql VOLATILE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION get_params2hstore (a_obj_id integer) RETURNS hstore AS $$
    SELECT hstore(array_agg(p.name),array_agg(v.value))
    FROM value v JOIN prop p ON p.obj_id=v.prop_id AND v.obj_id=$1;
$$ LANGUAGE sql STABLE STRICT;

----------------------------
-- TAG
----------------------------
CREATE OR REPLACE FUNCTION tag_id (a_type text) RETURNS integer AS $$
    SELECT ref_id($1,top_ref_id('tag'));
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION class_tag_id (a_class text,a_name text) RETURNS integer AS $$
    SELECT obj_id FROM zref WHERE name=$2 AND ztype_id($1) IN (obj_id,_id);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION set_tag (a_obj_id integer,a_tag_id integer) RETURNS integer AS $$
    INSERT INTO tag (obj_id,tag_id) VALUES ($1,$2) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_tag (a_obj_id integer,a_tag text) RETURNS integer AS $$
    INSERT INTO tag (obj_id,tag_id) VALUES ($1,tag_id($2)) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;

CREATE OR REPLACE FUNCTION tag_ids (a_parent text, a_names text) RETURNS integer[] AS $$
    SELECT ref_ids(ref_id('tag', a_parent), a_names);
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE OR REPLACE FUNCTION set_tags (a_obj_id integer, a_tag_ids integer[]) RETURNS integer[] AS $$
    DELETE FROM tag WHERE obj_id = a_obj_id;
    WITH rows AS (
        INSERT INTO tag (obj_id, tag_id)
        SELECT a_obj_id, unnest
        FROM unnest(a_tag_ids)
        RETURNING id
    )
    SELECT array_agg(id) FROM rows;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_tags (a_obj_id integer, a_parent text, a_names text) RETURNS integer[] AS $$
    SELECT set_tags(a_obj_id, tag_ids(a_parent, a_names));
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- TIE
----------------------------
CREATE OR REPLACE FUNCTION set_tie (a_src_id integer,a_dst_id integer,a_tag_id integer) RETURNS integer AS $$
    INSERT INTO tie (src_id,dst_id,tag_id) VALUES ($1,$2,$3) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_tie (a_src_id integer,a_dst_id integer,a_tag text) RETURNS integer AS $$
    INSERT INTO tie (src_id,dst_id,tag_id) VALUES ($1,$2,tag_id($3)) RETURNING id;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_uniq_tie (a_src_id integer,a_dst_id integer,a_tag_id integer) RETURNS integer AS $$
DECLARE
    the_id integer;
BEGIN
    SELECT INTO the_id id FROM tie WHERE src_id=a_src_id AND tag_id=a_tag_id;
    IF the_id IS NOT NULL THEN
        UPDATE tie SET dst_id=a_dst_id WHERE id=the_id;
    ELSE
        INSERT INTO tie (src_id,dst_id,tag_id) VALUES (a_src_id,a_dst_id,a_tag_id)
        RETURNING id INTO the_id;
    END IF;
    RETURN the_id;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_ties (a_src_id integer, a_tag_id integer, a_dst_ids integer[]) RETURNS integer AS $$
    WITH r AS (
        INSERT INTO tie (src_id,tag_id,dst_id)
        SELECT $1,$2,unnest($3)
        RETURNING id
    )
    SELECT max(r.id) FROM r;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION add_ties (a_src_ids integer[], a_tag_id integer, a_dst_id integer) RETURNS integer AS $$
    WITH r AS (
        INSERT INTO tie (src_id,tag_id,dst_id)
        SELECT unnest(a_src_ids), a_tag_id, a_dst_id
        RETURNING id
    )
    SELECT max(r.id) FROM r;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION del_ties (a_src_id integer, a_tag_id integer, a_dst_ids integer[]) RETURNS integer AS $$
    WITH r AS (
        DELETE FROM tie WHERE src_id=$1 AND tag_id=$2 AND dst_id=ANY($3) RETURNING id
    )
    SELECT max(r.id) FROM r;
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_ties (a_src_id integer, a_tag_id integer, a_dst_ids integer[]) RETURNS integer AS $$
    DELETE FROM tie WHERE src_id=$1 AND tag_id=$2;
    SELECT add_ties($1,$2,$3);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION set_ties (a_src_ids integer[], a_tag_id integer, a_dst_id integer) RETURNS integer AS $$
    DELETE FROM tie WHERE tag_id = a_tag_id AND dst_id = a_dst_id;
    SELECT add_ties(a_src_ids, a_tag_id, a_dst_id);
$$ LANGUAGE sql VOLATILE STRICT;

----------------------------
-- OBJECT
----------------------------
CREATE OR REPLACE FUNCTION obj_id (a_class text, a_name text) RETURNS integer AS $$
DECLARE
    res integer;
BEGIN
    BEGIN
        EXECUTE 'SELECT '||a_class||'_id('''||a_name||''')' INTO res;
    EXCEPTION WHEN OTHERS THEN
        -- DO NOTHING
    END;
    RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_id (a_obj text) RETURNS integer AS $$
    SELECT obj_id(substr(a_obj, 0, position(':' in a_obj)), substr(a_obj, position(':' in a_obj)+1));
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_name (a_obj_id integer) RETURNS text AS $$
DECLARE
    z_table text;
    z_name  text;
BEGIN
    SELECT INTO z_table,z_name nonempty(get_value(r.obj_id, 'class:table'), r.name), get_value(r.obj_id, 'class:obj_name')
    FROM zref r WHERE r.obj_id = (SELECT class_id FROM obj WHERE obj_id=a_obj_id);
    IF z_name IS NOT NULL THEN
        EXECUTE 'SELECT '||z_name||' FROM '||z_table||' WHERE obj_id='||a_obj_id INTO z_name;
    END IF;
    RETURN z_name;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION get_obj_full_name (a_obj_id integer) RETURNS text AS $$
    SELECT class_full_name(class_id)||':'||obj_name(a_obj_id) FROM obj WHERE obj_id=a_obj_id;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION obj_full_name (a_obj_id integer) RETURNS text AS $$
    SELECT class_full_name(class_id)||':'||obj_name(a_obj_id) FROM obj WHERE obj_id=a_obj_id;
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION record_id (a_class text,a_name text) RETURNS integer AS $$
DECLARE
    res integer;
BEGIN
    BEGIN
        EXECUTE 'SELECT '||a_class||'_id('''||a_name||''')' INTO res;
    EXCEPTION
        WHEN OTHERS THEN -- DO NOTHING
    END;
    RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION record_id (a_class text,a hstore) RETURNS integer AS $$
DECLARE
    res integer;
BEGIN
    BEGIN
        EXECUTE 'SELECT '||a_class||'_id(('''||a::text||''')::hstore)' INTO res;
    EXCEPTION WHEN OTHERS THEN
        RETURN NULL;
    END;
    RETURN res;
END;
$$ LANGUAGE plpgsql STABLE STRICT;
CREATE OR REPLACE FUNCTION record_id (a_class_id integer,a_name text) RETURNS integer AS $$
    SELECT record_id(ref_name($1),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION record_id (a_class_id integer,a hstore) RETURNS integer AS $$
    SELECT record_id(ref_name($1),$2);
$$ LANGUAGE sql STABLE STRICT;
CREATE OR REPLACE FUNCTION record_id (a_object text) RETURNS integer AS $$
    SELECT record_id(split_part($1,':',1),split_part($1,':',2));
$$ LANGUAGE sql STABLE STRICT;

--- VALUES DEBUG
CREATE OR REPLACE FUNCTION dump_value (a_value text) RETURNS text AS $$
    SELECT CASE WHEN $1~E'^\\d+$' AND EXISTS (SELECT 1 FROM obj WHERE obj_id=$1::integer) THEN get_obj_full_name($1::integer) ELSE $1 END
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION dump_all_values (a_obj_id integer) RETURNS text AS $$
    SELECT  string_agg(val,',')
    FROM    (
        SELECT      c.name||':'||p.name||'="'||v.value||'"' AS val
        FROM        value       v
        JOIN        prop        p ON p.obj_id=v.prop_id
        JOIN        ref         c ON c.obj_id=p.class_id
        WHERE       v.obj_id=$1
        ORDER BY    c.name,p.name,v.no
    )   AS a
$$ LANGUAGE sql STABLE STRICT;

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
-- PG
----------------------------
CREATE OR REPLACE FUNCTION pg_typename (a_oid integer) RETURNS name AS $$
    SELECT typname FROM pg_type WHERE oid=$1;
$$ LANGUAGE sql STABLE STRICT;

---------------------------
--- UTILS
---------------------------
CREATE OR REPLACE FUNCTION lock_table(a_table text, a_flag boolean, a_mode text) RETURNS BOOLEAN AS $$
BEGIN
    IF a_flag THEN
        a_mode = coalesce(a_mode,' IN SHARE UPDATE EXCLUSIVE MODE ');
        EXECUTE 'LOCK TABLE '|| a_table || ' ' || a_mode ;
        RETURN true;
    END IF;
    RETURN false;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;

CREATE OR REPLACE FUNCTION refresh_materialized_view(a_view text, is_concurent bool = FALSE) RETURNS BOOLEAN AS $$
DECLARE
    query text := 'REFRESH MATERIALIZED VIEW ';
BEGIN
    IF is_concurent THEN
        query := query || ' CONCURRENTLY ';
    END IF;
    execute query || a_view;
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION pg_has_advisory_xact_lock(a_key bigint) RETURNS BOOLEAN AS $$
DECLARE
    res boolean;
BEGIN
    SELECT INTO res EXISTS(
        SELECT  1
        FROM    pg_locks ad
        WHERE   ad.locktype = 'advisory'
          AND ad.mode = 'ExclusiveLock'
          AND ad.classid = (a_key >> 32)::bit(32)::int
          AND ad.objid = a_key::bit(32)::int
    );

    RETURN res;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION pg_has_advisory_xact_lock_shared(a_key bigint) RETURNS BOOLEAN AS $$
DECLARE
    res boolean;
BEGIN
    SELECT INTO res EXISTS(
        SELECT  1
        FROM    pg_locks ad
        JOIN    pg_locks tx ON tx.virtualtransaction = ad.virtualtransaction AND tx.locktype = 'transactionid'
        WHERE   ad.locktype = 'advisory'
            AND ad.mode = 'ShareLock'
            AND ad.classid = (a_key >> 32)::bit(32)::int
            AND ad.objid = a_key::bit(32)::int
            AND tx.transactionid::text = (txid_current() % (2^32)::bigint)::text
    );

    RETURN res;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION pg_has_advisory_lock_shared(a_key bigint) RETURNS BOOLEAN AS $$
    SELECT pg_has_advisory_xact_lock_shared(a_key);
$$ LANGUAGE sql VOLATILE STRICT;
CREATE OR REPLACE FUNCTION pg_has_advisory_lock(a_key bigint) RETURNS BOOLEAN AS $$
SELECT pg_has_advisory_xact_lock(a_key);
$$ LANGUAGE sql VOLATILE STRICT;
