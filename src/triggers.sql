-- $Header: /home/sol/usr/cvs/reodb/triggers.sql,v 1.3 2007/08/31 11:16:18 sol Exp $

-- ODB TRIGGER FUNCTIONS
CREATE OR REPLACE FUNCTION odb_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
    NEW.obj_id := coalesce(NEW.obj_id,nextval('obj_id_seq'));
    INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,class_id(TG_RELNAME));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_safe_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
    NEW.obj_id := coalesce(NEW.obj_id,nextval('obj_id_seq'));
    IF NOT EXISTS (SELECT 1 FROM obj WHERE obj_id=NEW.obj_id) THEN
        INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,class_id(TG_RELNAME));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_after_update_trigger () RETURNS "trigger" AS $$
BEGIN
    UPDATE obj SET update_time=now() WHERE obj_id=NEW.obj_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_mark_deleted_trigger () RETURNS "trigger" AS $$
DECLARE
    ds_id integer := state_id(TG_RELNAME,'deleted');
BEGIN
    IF OLD.state_id != ds_id THEN
        EXECUTE 'UPDATE '||TG_RELNAME||' SET state_id='||ds_id||' WHERE obj_id='||OLD.obj_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION odb_forbid_delete_trigger () RETURNS "trigger" AS $$
BEGIN
    RAISE EXCEPTION 'It is forbidden to delete %',TG_RELNAME;
    RETURN NULL;
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
    EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),NULL,* FROM '||TG_RELNAME||' WHERE obj_id='||OLD.obj_id;
    IF TG_OP='UPDATE' THEN
        RETURN NEW;
    ELSE
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- REODB TRIGGERS
CREATE OR REPLACE FUNCTION reodb_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
    NEW.obj_id := coalesce(NEW.obj_id,nextval('obj_id_seq'));
    IF NOT EXISTS (SELECT 1 FROM obj WHERE obj_id=NEW.obj_id) THEN
        INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,class_id(TG_RELNAME));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_simple_change_trigger () RETURNS "trigger" AS $$
BEGIN
    EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),'''||TG_OP||''',* FROM '||TG_RELNAME||' WHERE obj_id='||OLD.obj_id;
    IF TG_OP='UPDATE' THEN
        RETURN NEW;
    ELSE
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_after_update_trigger () RETURNS "trigger" AS $$
BEGIN
    UPDATE obj SET update_time=now() WHERE obj_id=NEW.obj_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_mark_deleted_trigger () RETURNS "trigger" AS $$
DECLARE
    ds_id integer := state_id(TG_RELNAME,'deleted');
BEGIN
    IF OLD.state_id != ds_id THEN
        EXECUTE 'UPDATE '||TG_RELNAME||' SET state_id='||ds_id||' WHERE obj_id='||OLD.obj_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_before_change_trigger () RETURNS "trigger" AS $$
BEGIN
    IF TG_OP='DELETE' THEN
        IF ref_name(OLD.state_id) IN ('deleted', 'temporary') THEN
            EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),'''||TG_OP||''', ($1).* ' USING OLD;
            RETURN OLD;
        ELSE
            EXECUTE 'UPDATE '||TG_RELNAME||' SET state_id=state_id('''||TG_RELNAME||''',''deleted'') WHERE obj_id='||OLD.obj_id;
            RETURN NULL;
        END IF;
    ELSE
        IF NEW IS DISTINCT FROM OLD THEN
            EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),'''||TG_OP||''', ($1).* ' USING OLD;
        END IF;
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_before_delete_trigger () RETURNS "trigger" AS $$
BEGIN
    IF ref_name(OLD.state_id) IN ('deleted','temporary') THEN
        EXECUTE 'INSERT INTO del_'||TG_RELNAME||' SELECT * FROM '||TG_RELNAME||' WHERE obj_id='||OLD.obj_id;
        RETURN OLD;
    END IF;
    EXECUTE 'UPDATE '||TG_RELNAME||' SET state_id=state_id('''||TG_RELNAME||''',''deleted'') WHERE obj_id='||OLD.obj_id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_simple_delete_trigger () RETURNS "trigger" AS $$
BEGIN
    EXECUTE 'INSERT INTO del_' || TG_RELNAME||' SELECT ($1).*' USING OLD;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_after_delete_trigger () RETURNS "trigger" AS $$
BEGIN
    DELETE FROM obj WHERE obj_id=OLD.obj_id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION reodb_update_name_trigger () RETURNS "trigger" AS $$
DECLARE
    zname text := obj_name(NEW.obj_id);
BEGIN
    UPDATE obj SET name = obj_name(NEW.obj_id) WHERE obj_id = NEW.obj_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- NON OBJ TRIGGERS
CREATE OR REPLACE FUNCTION nonobj_before_change_trigger () RETURNS "trigger" AS $$
BEGIN
    EXECUTE 'INSERT INTO old_'||TG_RELNAME||' SELECT now(),'''||TG_OP||''',* FROM '||TG_RELNAME||' WHERE id='||quote_literal(OLD.id);
    IF TG_OP='UPDATE' THEN
        RETURN NEW;
    ELSE
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION nonobj_before_delete_trigger () RETURNS "trigger" AS $$
BEGIN
    EXECUTE 'INSERT INTO del_'||TG_RELNAME||' SELECT * FROM '||TG_RELNAME||' WHERE id='||quote_literal(OLD.id);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- OBJ
CREATE OR REPLACE FUNCTION update_time_trigger () RETURNS "trigger" AS $$
BEGIN
    IF NEW.update_time IS NOT DISTINCT FROM OLD.update_time THEN
        NEW.update_time := now();
    END IF;
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

-- REF
CREATE OR REPLACE FUNCTION ref_after_change_trigger () RETURNS "trigger" AS $$
BEGIN
    IF TG_OP='INSERT' OR NEW.label!=OLD.label OR NEW.descr!=OLD.descr THEN
        UPDATE obj SET label=NEW.label,descr=NEW.descr WHERE obj_id=NEW.obj_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION refresh_zref() RETURNS "trigger" AS $$
BEGIN
    REFRESH MATERIALIZED VIEW zref_mat;
    RETURN NULL;
end
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
CREATE OR REPLACE FUNCTION value_after_change_trigger () RETURNS "trigger" AS $$
DECLARE
    copy_to text;
    func    text;
    prop    text;
    row     record;
BEGIN
    IF (TG_OP='DELETE') THEN
        row := OLD;
    ELSE
        row := NEW;
    END IF;

    func := coalesce(
        get_value_non_def(row.prop_id, 'prop:'||lower(TG_OP)||'_trigger'),
        get_value_non_def(row.prop_id, 'prop:trigger')
    );
    IF func IS NOT NULL THEN
        EXECUTE 'SELECT '||func||'('||row.obj_id||')';
    END IF;

    copy_to := get_value_non_def(row.prop_id, 'prop:copy_to');
    IF copy_to IS NOT NULL THEN
        FOREACH prop IN ARRAY string_to_array(copy_to, ';') LOOP
            IF TG_OP = 'DELETE' THEN
                PERFORM delete_value(row.obj_id, prop);
            ELSE
                PERFORM set_value(row.obj_id, prop, row.value);
            END IF;
        END LOOP;
    END IF;

    RETURN row;
END;
$$ LANGUAGE plpgsql;

--- INTEGER_VALUE
CREATE OR REPLACE FUNCTION integer_value_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM integer_value WHERE obj_id=NEW.obj_id AND prop_id=NEW.prop_id AND no=NEW.no) THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
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

-- TIE
CREATE OR REPLACE FUNCTION tie_before_insert_trigger () RETURNS "trigger" AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tie WHERE src_id=NEW.src_id AND dst_id=NEW.dst_id AND tag_id=NEW.tag_id) THEN
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
    NEW.obj_id := coalesce(NEW.obj_id,nextval('obj_id_seq'));
    INSERT INTO obj (obj_id,class_id) VALUES (NEW.obj_id,3);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- OBJ
CREATE TRIGGER update_time_trigger                  BEFORE  UPDATE  ON obj          FOR EACH ROW EXECUTE PROCEDURE update_time_trigger();
CREATE TRIGGER obj_before_delete_trigger            BEFORE  DELETE  ON obj          FOR EACH ROW EXECUTE PROCEDURE obj_before_delete_trigger();

-- REF
CREATE TRIGGER reodb_before_insert_trigger          BEFORE  INSERT  ON ref          FOR EACH ROW EXECUTE PROCEDURE reodb_before_insert_trigger();
CREATE TRIGGER reodb_after_update_trigger           AFTER   UPDATE  ON ref          FOR EACH ROW EXECUTE PROCEDURE reodb_after_update_trigger();
CREATE TRIGGER reodb_before_delete_trigger          BEFORE  DELETE  ON ref          FOR EACH ROW EXECUTE PROCEDURE reodb_before_delete_trigger();
CREATE TRIGGER reodb_after_delete_trigger           AFTER   DELETE  ON ref          FOR EACH ROW EXECUTE PROCEDURE reodb_after_delete_trigger();
CREATE TRIGGER reodb_update_name_trigger    AFTER INSERT OR UPDATE  ON ref          FOR EACH ROW EXECUTE PROCEDURE reodb_update_name_trigger();

-- PROP
CREATE TRIGGER reodb_before_insert_trigger          BEFORE  INSERT  ON prop         FOR EACH ROW EXECUTE PROCEDURE reodb_before_insert_trigger();
CREATE TRIGGER reodb_after_update_trigger           AFTER   UPDATE  ON prop         FOR EACH ROW EXECUTE PROCEDURE reodb_after_update_trigger();
CREATE TRIGGER reodb_before_delete_trigger          BEFORE  DELETE  ON prop         FOR EACH ROW EXECUTE PROCEDURE reodb_before_delete_trigger();
CREATE TRIGGER reodb_after_delete_trigger           AFTER   DELETE  ON prop         FOR EACH ROW EXECUTE PROCEDURE reodb_after_delete_trigger();
CREATE TRIGGER reodb_update_name_trigger    AFTER INSERT OR UPDATE  ON prop         FOR EACH ROW EXECUTE PROCEDURE reodb_update_name_trigger();

-- VALUE
CREATE TRIGGER value_before_insert_trigger          BEFORE  INSERT  ON value        FOR EACH ROW EXECUTE PROCEDURE value_before_insert_trigger();
CREATE TRIGGER value_after_change_trigger AFTER INSERT OR UPDATE OR DELETE ON value FOR EACH ROW EXECUTE PROCEDURE value_after_change_trigger();

--- INTEGER_VALUE
CREATE TRIGGER integer_value_before_insert_trigger  BEFORE  INSERT  ON integer_value FOR EACH ROW EXECUTE PROCEDURE integer_value_before_insert_trigger();

-- TAG
CREATE TRIGGER tag_before_insert_trigger            BEFORE  INSERT  ON tag          FOR EACH ROW EXECUTE PROCEDURE tag_before_insert_trigger();

-- TIE
CREATE TRIGGER tie_before_insert_trigger            BEFORE  INSERT  ON tie          FOR EACH ROW EXECUTE PROCEDURE tie_before_insert_trigger();

-- LINK
CREATE TRIGGER link_before_insert_trigger           BEFORE  INSERT  ON link         FOR EACH ROW EXECUTE PROCEDURE link_before_insert_trigger();
CREATE TRIGGER reodb_after_update_trigger           AFTER   UPDATE  ON link         FOR EACH ROW EXECUTE PROCEDURE reodb_after_update_trigger();
CREATE TRIGGER reodb_before_change_trigger  BEFORE UPDATE OR DELETE ON link         FOR EACH ROW EXECUTE PROCEDURE reodb_before_change_trigger();
CREATE TRIGGER reodb_after_delete_trigger           AFTER   DELETE  ON link         FOR EACH ROW EXECUTE PROCEDURE reodb_after_delete_trigger();

