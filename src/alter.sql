-- $Header: /home/sol/usr/cvs/reodb/alter.sql,v 1.2 2007/08/31 11:16:18 sol Exp $

-- PRIMARY KEYS
ALTER TABLE ONLY obj                ADD CONSTRAINT obj_obj_id_pkey                      PRIMARY KEY (obj_id);
ALTER TABLE ONLY ref                ADD CONSTRAINT ref_obj_id_pkey                      PRIMARY KEY (obj_id);
ALTER TABLE ONLY prop               ADD CONSTRAINT prop_obj_id_pkey                     PRIMARY KEY (obj_id);
ALTER TABLE ONLY value              ADD CONSTRAINT value_id_pkey                        PRIMARY KEY (id);
ALTER TABLE ONLY integer_value      ADD CONSTRAINT integer_value_id_pkey                PRIMARY KEY (id);
ALTER TABLE ONLY user_value         ADD CONSTRAINT user_value_id_pkey                   PRIMARY KEY (id);
ALTER TABLE ONLY tag                ADD CONSTRAINT tag_id_pkey                          PRIMARY KEY (id);
ALTER TABLE ONLY tie                ADD CONSTRAINT tie_id_pkey                          PRIMARY KEY (id);
ALTER TABLE ONLY link               ADD CONSTRAINT link_obj_id_pkey                     PRIMARY KEY (obj_id);

-- OBJ
ALTER TABLE ONLY obj                ADD CONSTRAINT obj_class_id_fkey                    FOREIGN KEY (class_id)  REFERENCES ref (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        obj_class_id_idx                                    ON obj (class_id);

-- REF
ALTER TABLE ONLY ref                ADD CONSTRAINT ref_name__id_uniq                    UNIQUE (name,_id);
ALTER TABLE ONLY ref                ADD CONSTRAINT ref_obj_id_fkey                      FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY ref                ADD CONSTRAINT ref__id_fkey                         FOREIGN KEY (_id)   REFERENCES ref (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        ref__id_idx                                         ON ref (_id);

-- PROP
ALTER TABLE ONLY prop               ADD CONSTRAINT prop_name_class_id_uniq              UNIQUE (name,class_id);
ALTER TABLE ONLY prop               ADD CONSTRAINT prop_obj_id_fkey                     FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY prop               ADD CONSTRAINT prop_class_id_fkey                   FOREIGN KEY (class_id)  REFERENCES ref (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY prop               ADD CONSTRAINT prop_type_id_fkey                    FOREIGN KEY (type_id)   REFERENCES ref (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        prop_class_id_idx                                   ON prop (class_id);

-- VALUE
ALTER TABLE ONLY value              ADD CONSTRAINT value_no_obj_id_prop_id_uniq         UNIQUE (obj_id,prop_id,no);
ALTER TABLE ONLY value              ADD CONSTRAINT value_obj_id_fkey                    FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY value              ADD CONSTRAINT value_prop_id_fkey                   FOREIGN KEY (prop_id)   REFERENCES prop (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
--- XXX doesn't work
--- CREATE INDEX                        value_value_idx                                     ON value (value);
CREATE INDEX                        value_prop_id_idx                                   ON value (prop_id);

--- integer_value
ALTER TABLE ONLY integer_value      ADD CONSTRAINT integer_value_no_obj_id_prop_id_uniq UNIQUE (obj_id,prop_id,no);
ALTER TABLE ONLY integer_value      ADD CONSTRAINT integer_value_obj_id_fkey            FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY integer_value      ADD CONSTRAINT integer_value_prop_id_fkey           FOREIGN KEY (prop_id)   REFERENCES prop (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        integer_value_value_idx                             ON integer_value (value);
CREATE INDEX                        integer_value_prop_id_idx                           ON integer_value (prop_id);

-- USER VALUE
ALTER TABLE ONLY user_value         ADD CONSTRAINT user_value_no_obj_id_user_id_prop_id_uniq UNIQUE (no,obj_id,user_id,prop_id);
ALTER TABLE ONLY user_value         ADD CONSTRAINT user_value_obj_id_fkey               FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY user_value         ADD CONSTRAINT user_value_user_id_fkey              FOREIGN KEY (user_id)   REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY user_value         ADD CONSTRAINT user_value_prop_id_fkey              FOREIGN KEY (prop_id)   REFERENCES prop (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE CASCADE;
CREATE INDEX                        user_value_value_idx                                ON user_value (value);
CREATE INDEX                        user_value_obj_id_idx                               ON user_value (obj_id);
CREATE INDEX                        user_value_prop_id_idx                              ON user_value (prop_id);

-- TAG
ALTER TABLE ONLY tag                ADD CONSTRAINT tag_tag_id_obj_id_uniq               UNIQUE (tag_id,obj_id);
ALTER TABLE ONLY tag                ADD CONSTRAINT tag_obj_id_fkey                      FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY tag                ADD CONSTRAINT tag_tag_id_fkey                      FOREIGN KEY (tag_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        tag_obj_id_idx                                      ON tag (obj_id);

-- TIE
ALTER TABLE ONLY tie                ADD CONSTRAINT tie_tag_id_src_id_dst_id_uniq        UNIQUE (tag_id,src_id,dst_id);
ALTER TABLE ONLY tie                ADD CONSTRAINT tie_src_id_fkey                      FOREIGN KEY (src_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY tie                ADD CONSTRAINT tie_dst_id_fkey                      FOREIGN KEY (dst_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY tie                ADD CONSTRAINT tie_tag_id_fkey                      FOREIGN KEY (tag_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        tie_src_id_idx                                      ON tie (src_id);
CREATE INDEX                        tie_dst_id_idx                                      ON tie (dst_id);

-- LINK
ALTER TABLE ONLY link               ADD CONSTRAINT link_tag_id_dst_id_src_id_uniq       UNIQUE (tag_id,dst_id,src_id);
ALTER TABLE ONLY link               ADD CONSTRAINT link_obj_id_fkey                     FOREIGN KEY (obj_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY link               ADD CONSTRAINT link_src_id_fkey                     FOREIGN KEY (src_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY link               ADD CONSTRAINT link_dst_id_fkey                     FOREIGN KEY (dst_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY link               ADD CONSTRAINT link_tag_id_fkey                     FOREIGN KEY (tag_id)    REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        link_src_id_idx                                     ON link (src_id);
CREATE INDEX                        link_dst_id_idx                                     ON link (dst_id);

-- STATUS
ALTER TABLE ONLY status             ADD CONSTRAINT status_id_pkey                       PRIMARY KEY (id);
ALTER TABLE ONLY status             ADD CONSTRAINT status_type_id_object_id_uniq        UNIQUE (type_id,object_id);
ALTER TABLE ONLY status             ADD CONSTRAINT status_object_id_fkey                FOREIGN KEY (object_id) REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY status             ADD CONSTRAINT status_subject_id_fkey               FOREIGN KEY (subject_id) REFERENCES obj (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE ONLY status             ADD CONSTRAINT status_type_id_fkey                  FOREIGN KEY (type_id)   REFERENCES ref (obj_id)
                                                                                        ON UPDATE CASCADE ON DELETE RESTRICT;
CREATE INDEX                        status_object_id_idx                                ON status (object_id);
CREATE INDEX                        status_subject_id_idx                               ON status (subject_id) WHERE subject_id is null;
CREATE INDEX                        status_time_idx                                     ON status (time);

