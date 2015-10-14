
CREATE PROCEDURAL LANGUAGE plpgsql;

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
AS '$libdir/plpgsql', 'plpgsql_call_handler' LANGUAGE c;

CREATE FUNCTION plpgsql_validator(oid) RETURNS void
AS '$libdir/plpgsql', 'plpgsql_validator' LANGUAGE c;

