
--- JOIN
CREATE OR REPLACE FUNCTION join_state (state text,value text,delimiter text) RETURNS text AS $$
    SELECT CASE WHEN $1 IS NULL THEN $2 ELSE (
        CASE WHEN $2 IS NULL THEN $1 ELSE $1||$3||$2 END
    ) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE AGGREGATE join (text,text) (
    STYPE = text,
    SFUNC = join_state
);

--- CJOIN for text
CREATE OR REPLACE FUNCTION cjoin_state (state text,value text) RETURNS text AS $$
    SELECT CASE WHEN $1 IS NULL THEN $2 ELSE (
        CASE WHEN $2 IS NULL THEN $1 ELSE $1||','||$2 END
    ) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE AGGREGATE cjoin (text) (
    SFUNC = cjoin_state,
    STYPE = text
);

--- CJOIN for integer
CREATE OR REPLACE FUNCTION cjoin_state (state text,value integer) RETURNS text AS $$
    SELECT CASE WHEN $1 IS NULL THEN $2::text ELSE (
        CASE WHEN $2 IS NULL THEN $1 ELSE $1||','||$2::text END
    ) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE AGGREGATE cjoin (integer) (
    SFUNC = cjoin_state,
    STYPE = text
);

-- SJOIN
CREATE OR REPLACE FUNCTION sjoin_state (state text,value text) RETURNS text AS $$
    SELECT CASE WHEN $1 IS NULL THEN $2 ELSE (
        CASE WHEN $2 IS NULL THEN $1 ELSE $1||' '||$2 END
    ) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE AGGREGATE sjoin (text) (
    SFUNC = sjoin_state,
    STYPE = text
);

-- FIRST/LAST integer,integer
CREATE TYPE integer_integer AS (k integer,v integer);

CREATE OR REPLACE FUNCTION first_state (state integer_integer,k integer,v integer) RETURNS integer_integer AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::integer_integer ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state integer_integer) RETURNS integer AS $$
    SELECT $1.v;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE AGGREGATE first (integer,integer) (
    STYPE = integer_integer,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state integer_integer,k integer,v integer) RETURNS integer_integer AS $$
    SELECT CASE WHEN $1 IS NULL OR $2>$1.k THEN ($2,$3)::integer_integer ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state integer_integer) RETURNS integer AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (integer,integer) (
    STYPE = integer_integer,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST integer,bigint
CREATE TYPE integer_bigint AS (k integer,v bigint);

CREATE OR REPLACE FUNCTION first_state (state integer_bigint,k integer,v bigint) RETURNS integer_bigint AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::integer_bigint ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state integer_bigint) RETURNS bigint AS $$
	SELECT $1.v;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE AGGREGATE first (integer,bigint) (
    STYPE = integer_bigint,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state integer_bigint,k integer,v bigint) RETURNS integer_bigint AS $$
    SELECT CASE WHEN $1 IS NULL OR ($3 IS NOT NULL AND $2>$1.k) THEN ($2,$3)::integer_bigint ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state integer_bigint) RETURNS bigint AS $$
	SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (integer,bigint) (
    STYPE = integer_bigint,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST integer,text
CREATE TYPE integer_text AS (k integer,v text);

CREATE OR REPLACE FUNCTION first_state (state integer_text,k integer,v text) RETURNS integer_text AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::integer_text ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state integer_text) RETURNS text AS $$
	SELECT $1.v;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE AGGREGATE first (integer,text) (
    STYPE = integer_text,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state integer_text,k integer,v text) RETURNS integer_text AS $$
    SELECT CASE WHEN $1 IS NULL OR ($3 IS NOT NULL AND $2>$1.k) THEN ($2,$3)::integer_text ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state integer_text) RETURNS text AS $$
	SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (integer,text) (
    STYPE = integer_text,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST integer,boolean
CREATE TYPE integer_boolean AS (k integer,v boolean);

CREATE OR REPLACE FUNCTION first_state (state integer_boolean,k integer,v boolean) RETURNS integer_boolean AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::integer_boolean ELSE $1 END;
$$ LANGUAGE sql IMMUTABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state integer_boolean) RETURNS boolean AS $$
    SELECT $1.v;
$$ LANGUAGE sql IMMUTABLE STRICT;
CREATE AGGREGATE first (integer,boolean) (
    STYPE = integer_boolean,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state integer_boolean,k integer,v boolean) RETURNS integer_boolean AS $$
    SELECT CASE WHEN $1 IS NULL OR $2>$1.k THEN ($2,$3)::integer_boolean ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state integer_boolean) RETURNS boolean AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (integer,boolean) (
    STYPE = integer_boolean,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST timestamp,integer
CREATE TYPE timestamp_integer AS (k timestamp,v integer);

CREATE OR REPLACE FUNCTION first_state (state timestamp_integer,k timestamp,v integer) RETURNS timestamp_integer AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::timestamp_integer ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state timestamp_integer) RETURNS integer AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE first (timestamp,integer) (
    STYPE = timestamp_integer,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state timestamp_integer,k timestamp,v integer) RETURNS timestamp_integer AS $$
    SELECT CASE WHEN $1 IS NULL OR $2>$1.k THEN ($2,$3)::timestamp_integer ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state timestamp_integer) RETURNS integer AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (timestamp,integer) (
    STYPE = timestamp_integer,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST timestamp,double precision
CREATE TYPE timestamp_double_precision AS (k timestamp,v double precision);

CREATE OR REPLACE FUNCTION first_state (state timestamp_double_precision,k timestamp,v double precision) RETURNS timestamp_double_precision AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::timestamp_double_precision ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state timestamp_double_precision) RETURNS double precision AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE first (timestamp,double precision) (
    STYPE = timestamp_double_precision,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state timestamp_double_precision,k timestamp,v double precision) RETURNS timestamp_double_precision AS $$
    SELECT CASE WHEN $1 IS NULL OR $2>$1.k THEN ($2,$3)::timestamp_double_precision ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state timestamp_double_precision) RETURNS double precision AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (timestamp,double precision) (
    STYPE = timestamp_double_precision,
    SFUNC = last_state,
    FINALFUNC = last_final
);

-- FIRST/LAST timestamp,text
CREATE TYPE timestamp_text AS (k timestamp,v text);

CREATE OR REPLACE FUNCTION first_state (state timestamp_text,k timestamp,v text) RETURNS timestamp_text AS $$
    SELECT CASE WHEN $1 IS NULL OR $2<$1.k THEN ($2,$3)::timestamp_text ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION first_final (state timestamp_text) RETURNS text AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE first (timestamp,text) (
    STYPE = timestamp_text,
    SFUNC = first_state,
    FINALFUNC = first_final
);

CREATE OR REPLACE FUNCTION last_state (state timestamp_text,k timestamp,v text) RETURNS timestamp_text AS $$
    SELECT CASE WHEN $1 IS NULL OR $2>$1.k THEN ($2,$3)::timestamp_text ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;
CREATE OR REPLACE FUNCTION last_final (state timestamp_text) RETURNS text AS $$
    SELECT $1.v;
$$ LANGUAGE sql STABLE STRICT;
CREATE AGGREGATE last (timestamp,text) (
    STYPE = timestamp_text,
    SFUNC = last_state,
    FINALFUNC = last_final
);
