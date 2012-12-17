
-- CJOIN

CREATE OR REPLACE FUNCTION cjoin_state (state text,value text) RETURNS text AS $$
	SELECT CASE WHEN $1 IS NULL THEN $2 ELSE (
		CASE WHEN $2 IS NULL THEN $1 ELSE $1||','||$2 END
	) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE AGGREGATE cjoin (text) (
	SFUNC = cjoin_state,
	STYPE = text
);

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

-- JOIN

CREATE TYPE text2 AS (f text,l text);

CREATE OR REPLACE FUNCTION join_state (state text,value text,delimiter text) RETURNS text AS $$
	SELECT CASE WHEN $1 IS NULL THEN $2 ELSE (
		CASE WHEN $2 IS NULL THEN $1 ELSE $1||$3||$2 END
	) END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE AGGREGATE join (text,text) (
	STYPE = text,
	SFUNC = join_state
);

-- SW1MAX

CREATE TYPE timestamp_double AS (t timestamp,d double precision);

CREATE OR REPLACE FUNCTION sw1max_state (state timestamp_double,value timestamp_double) RETURNS timestamp_double AS $$
        SELECT CASE WHEN $1 IS NULL OR $2.t>$1.t THEN $2 ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE OR REPLACE FUNCTION sw1max_final (state timestamp_double) RETURNS double precision AS $$
	SELECT $1.d;
$$ LANGUAGE sql STABLE STRICT;

CREATE AGGREGATE sw1max (timestamp_double) (
        STYPE = timestamp_double,
        SFUNC = sw1max_state,
        FINALFUNC = sw1max_final
);

-- LAST timestamp,double
CREATE OR REPLACE FUNCTION last_state (state timestamp_double,t timestamp,d double precision) RETURNS timestamp_double AS $$
        SELECT CASE WHEN $1 IS NULL OR $2>$1.t THEN ($2,$3)::timestamp_double ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE OR REPLACE FUNCTION last_final (state timestamp_double) RETURNS double precision AS $$
	SELECT $1.d;
$$ LANGUAGE sql STABLE STRICT;

CREATE AGGREGATE last (timestamp,double precision) (
        STYPE = timestamp_double,
        SFUNC = last_state,
        FINALFUNC = last_final
);

-- LAST integer,integer
CREATE TYPE integer_integer AS (k integer,v integer);

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

