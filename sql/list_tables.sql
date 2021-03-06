SET client_min_messages = WARNING;

CREATE EXTENSION postgres_fdw;

CREATE SERVER ftex_test_foreign_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host '192.0.2.1', port '5432', dbname 'foreign_db');

CREATE FOREIGN TABLE ftex_test_foreign_table (id serial NOT NULL, data text)
SERVER ftex_test_foreign_server
OPTIONS (schema_name 'some_schema', table_name 'some_table');

SELECT relname, nspname, relkind
FROM pg_catalog.pg_class c, pg_catalog.pg_namespace n
WHERE relkind IN ('r', 'v')
AND nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast', 'pg_temp_1')
AND n.oid = relnamespace
ORDER BY nspname, relname;

SELECT relname, nspname, relkind
FROM pg_catalog.pg_class c, pg_catalog.pg_namespace n
WHERE relkind IN ('v')
AND nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast', 'pg_temp_1')
AND n.oid = relnamespace
ORDER BY nspname, relname;

BEGIN;
DECLARE "SQL_CUR0x0123456789ab" CURSOR FOR
SELECT relname, nspname, relkind
FROM pg_catalog.pg_class c, pg_catalog.pg_namespace n
WHERE relkind IN ('r', 'v')
AND nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast', 'pg_temp_1')
AND n.oid = relnamespace
ORDER BY nspname, relname;

FETCH 100 IN "SQL_CUR0x0123456789ab";

CLOSE "SQL_CUR0x0123456789ab";

BEGIN;
DECLARE "SQL_CUR0x0123456789ab" CURSOR FOR
SELECT relname, nspname, relkind
FROM pg_catalog.pg_class c, pg_catalog.pg_namespace n
WHERE relkind IN ('v')
AND nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast', 'pg_temp_1')
AND n.oid = relnamespace
ORDER BY nspname, relname;

FETCH 100 IN "SQL_CUR0x0123456789ab";

CLOSE "SQL_CUR0x0123456789ab";

DROP FOREIGN TABLE ftex_test_foreign_table;

DROP SERVER ftex_test_foreign_server;

\d
