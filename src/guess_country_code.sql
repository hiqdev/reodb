CREATE TABLE guess_country_code (
    cc      text not null,
    name    text not null
);
CREATE INDEX  guess_country_code_cc_index ON guess_country_code (cc);
CREATE INDEX  guess_country_code_name_index ON guess_country_code (name);

CREATE OR REPLACE FUNCTION guess_country_code(a_name text) RETURNS text AS $$
    SELECT cc FROM guess_country_code WHERE name=lower($1 COLLATE "ru_RU.UTF-8");
$$ LANGUAGE sql IMMUTABLE STRICT;
