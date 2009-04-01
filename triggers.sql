-- $Header: /home/sol/usr/cvs/reodb/triggers.sql,v 1.3 2007/08/31 11:16:18 sol Exp $

-- ODB TRIGGER FUNCTIONS
CREATE OR REPLACE FUNCTION odb_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	NEW.obj_id := coalesce(NEW.obj_id,nextval('id'));
	INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,class_id(TG_RELNAME));
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_safe_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	NEW.obj_id := coalesce(NEW.obj_id,nextval('id'));
	IF NOT EXISTS (SELECT 1 FROM obj WHERE obj_id=NEW.obj_id) THEN
		INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,class_id(TG_RELNAME));
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_after_update_trigger () RETURNS "trigger" AS $$
BEGIN
	UPDATE obj SET update_time='now' WHERE obj_id=NEW.obj_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_before_delete_trigger () RETURNS "trigger" AS $$
BEGIN
	EXECUTE 'INSERT INTO del_'||TG_RELNAME||' SELECT * FROM '||TG_RELNAME||' WHERE obj_id='||OLD.obj_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_after_delete_trigger () RETURNS "trigger" AS $$
BEGIN
	DELETE FROM obj WHERE obj_id=OLD.obj_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_before_change_trigger () RETURNS "trigger" AS $$
BEGIN
	EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),* FROM '||TG_RELNAME||' WHERE obj_id='||OLD.obj_id;
	IF TG_OP='UPDATE' THEN
		RETURN NEW;
	ELSE
		RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

-- OBJ
CREATE OR REPLACE FUNCTION update_time_trigger () RETURNS "trigger" AS $$
BEGIN
	NEW.update_time := 'now';
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION obj_before_delete_trigger () RETURNS "trigger" AS $$
BEGIN
	INSERT INTO old_obj SELECT now(),OLD.*;
	INSERT INTO del_value SELECT * FROM value WHERE obj_id=OLD.obj_id;
	DELETE FROM value WHERE obj_id=OLD.obj_id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- NON OBJ
CREATE OR REPLACE FUNCTION before_delete_trigger () RETURNS "trigger" AS $$
BEGIN
	EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),* FROM '||TG_RELNAME||' WHERE id='||OLD.id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION before_change_trigger () RETURNS "trigger" AS $$
BEGIN
	EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),* FROM '||TG_RELNAME||' WHERE id='||OLD.id;
	IF TG_OP='UPDATE' THEN
		RETURN NEW;
	ELSE
		RETURN OLD;
	END IF;
END;
$$ LANGUAGE plpgsql;

-- VALUE
CREATE OR REPLACE FUNCTION value_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM value WHERE obj_id=NEW.obj_id AND prop_id=NEW.prop_id AND no=NEW.no) THEN
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION value_change_trigger () RETURNS "trigger" AS $$
DECLARE
	func text := get_value(NEW.prop_id,'prop:trigger');
BEGIN
	IF func IS NOT NULL THEN
		EXECUTE 'SELECT '||func||'('||NEW.obj_id||')';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION value_delete_trigger () RETURNS "trigger" AS $$
DECLARE
	func text := get_value(OLD.prop_id,'prop:trigger');
BEGIN
	IF func IS NOT NULL THEN
		EXECUTE 'SELECT '||func||'('||OLD.obj_id||')';
	END IF;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- TAG
CREATE OR REPLACE FUNCTION tag_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM tag WHERE obj_id=NEW.obj_id AND tag_id=NEW.tag_id) THEN
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TAG2
CREATE OR REPLACE FUNCTION tag2_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM tag2 WHERE src_id=NEW.src_id AND dst_id=NEW.dst_id AND tag_id=NEW.tag_id) THEN
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- LINK
CREATE OR REPLACE FUNCTION link_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM link WHERE src_id=NEW.src_id AND dst_id=NEW.dst_id AND tag_id=NEW.tag_id) THEN
		RETURN NULL;
	END IF;
	NEW.obj_id := coalesce(NEW.obj_id,nextval('id'));
	INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,3);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- OBJ
CREATE TRIGGER update_time_trigger		BEFORE	UPDATE	ON obj		FOR EACH ROW EXECUTE PROCEDURE update_time_trigger();
CREATE TRIGGER obj_before_delete_trigger	BEFORE	DELETE	ON obj		FOR EACH ROW EXECUTE PROCEDURE obj_before_delete_trigger();

-- REF
CREATE TRIGGER odb_before_insert_trigger	BEFORE	INSERT	ON ref		FOR EACH ROW EXECUTE PROCEDURE odb_before_insert_trigger();
CREATE TRIGGER odb_after_update_trigger		AFTER	UPDATE	ON ref		FOR EACH ROW EXECUTE PROCEDURE odb_after_update_trigger();
CREATE TRIGGER odb_before_delete_trigger	BEFORE	DELETE	ON ref		FOR EACH ROW EXECUTE PROCEDURE odb_before_delete_trigger();
CREATE TRIGGER odb_after_delete_trigger		AFTER	DELETE	ON ref		FOR EACH ROW EXECUTE PROCEDURE odb_after_delete_trigger();

-- PROP
CREATE TRIGGER odb_before_insert_trigger	BEFORE	INSERT	ON prop		FOR EACH ROW EXECUTE PROCEDURE odb_before_insert_trigger();
CREATE TRIGGER odb_after_update_trigger		AFTER	UPDATE	ON prop		FOR EACH ROW EXECUTE PROCEDURE odb_after_update_trigger();
CREATE TRIGGER odb_before_delete_trigger	BEFORE	DELETE	ON prop		FOR EACH ROW EXECUTE PROCEDURE odb_before_delete_trigger();
CREATE TRIGGER odb_after_delete_trigger		AFTER	DELETE	ON prop		FOR EACH ROW EXECUTE PROCEDURE odb_after_delete_trigger();

-- VALUE
CREATE TRIGGER value_before_insert_trigger	BEFORE	INSERT	ON value	FOR EACH ROW EXECUTE PROCEDURE value_before_insert_trigger();
CREATE TRIGGER value_change_trigger	AFTER INSERT OR UPDATE	ON value	FOR EACH ROW EXECUTE PROCEDURE value_change_trigger();
CREATE TRIGGER value_delete_trigger		AFTER	DELETE	ON value	FOR EACH ROW EXECUTE PROCEDURE value_delete_trigger();

-- TAG
CREATE TRIGGER tag_before_insert_trigger	BEFORE	INSERT	ON tag		FOR EACH ROW EXECUTE PROCEDURE tag_before_insert_trigger();

-- TAG2
CREATE TRIGGER tag2_before_insert_trigger	BEFORE	INSERT	ON tag2		FOR EACH ROW EXECUTE PROCEDURE tag2_before_insert_trigger();

-- LINK
CREATE TRIGGER link_before_insert_trigger	BEFORE	INSERT	ON link		FOR EACH ROW EXECUTE PROCEDURE link_before_insert_trigger();
CREATE TRIGGER odb_after_update_trigger		AFTER	UPDATE	ON link		FOR EACH ROW EXECUTE PROCEDURE odb_after_update_trigger();
CREATE TRIGGER odb_before_change_trigger BEFORE UPDATE OR DELETE ON link	FOR EACH ROW EXECUTE PROCEDURE odb_before_change_trigger();
CREATE TRIGGER odb_after_delete_trigger		AFTER	DELETE	ON link		FOR EACH ROW EXECUTE PROCEDURE odb_after_delete_trigger();

-- BLACKLIST
CREATE TRIGGER odb_before_insert_trigger	BEFORE	INSERT	ON blacklist	FOR EACH ROW EXECUTE PROCEDURE odb_before_insert_trigger();
CREATE TRIGGER odb_after_update_trigger		AFTER	UPDATE	ON blacklist	FOR EACH ROW EXECUTE PROCEDURE odb_after_update_trigger();
CREATE TRIGGER odb_before_delete_trigger	BEFORE	DELETE	ON blacklist	FOR EACH ROW EXECUTE PROCEDURE odb_before_delete_trigger();
CREATE TRIGGER odb_after_delete_trigger		AFTER	DELETE	ON blacklist	FOR EACH ROW EXECUTE PROCEDURE odb_after_delete_trigger();

