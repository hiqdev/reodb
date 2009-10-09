
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

-- LATEST

CREATE OR REPLACE FUNCTION latest_state (state timestamp_double,t timestamp,d double precision) RETURNS timestamp_double AS $$
        SELECT CASE WHEN $1 IS NULL OR $2>$1.t THEN ($2,$3)::timestamp_double ELSE $1 END;
$$ LANGUAGE sql STABLE CALLED ON NULL INPUT;

CREATE OR REPLACE FUNCTION latest_final (state timestamp_double) RETURNS double precision AS $$
	SELECT $1.d;
$$ LANGUAGE sql STABLE STRICT;

CREATE AGGREGATE latest (timestamp,double precision) (
        STYPE = timestamp_double,
        SFUNC = latest_state,
        FINALFUNC = latest_final
);

