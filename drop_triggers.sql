-- $Header: /home/sol/usr/cvs/reodb/drop_triggers.sql,v 1.1.1.1 2007/08/30 15:13:56 sol Exp $

-- ODB TRIGGER FUNCTIONS
DROP FUNCTION	odb_before_insert_trigger () CASCADE;
DROP FUNCTION	odb_after_update_trigger () CASCADE;
DROP FUNCTION	odb_before_delete_trigger () CASCADE;
DROP FUNCTION	odb_after_delete_trigger () CASCADE;

-- OBJ
DROP FUNCTION	obj_update_time_trigger () CASCADE;
DROP FUNCTION	obj_before_delete_trigger () CASCADE;
