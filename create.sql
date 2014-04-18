-- $Header: /home/sol/usr/cvs/reodb/create.sql,v 1.2 2007/08/31 11:16:18 sol Exp $

CREATE SEQUENCE "obj_id_seq" START 1000000;
CREATE TABLE obj (
    obj_id          integer             NOT NULL DEFAULT nextval('obj_id_seq'),
    class_id        integer             NOT NULL,
    label           text                NULL,
    descr           text                NULL,
    create_time     timestamp           NOT NULL DEFAULT now(),
    update_time     timestamp           NULL
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_obj FROM obj limit 0;

CREATE TABLE ref (
    obj_id          integer             NOT NULL,
    _id             integer             NOT NULL,
    name            text                NOT NULL DEFAULT '',
    no              integer             NULL,
    label           text                NULL,
    descr           text                NULL
);
SELECT * INTO del_ref FROM ref LIMIT 0;

CREATE TABLE prop (
    obj_id          integer             NOT NULL,
    class_id        integer             NOT NULL,
    name            text                NOT NULL,
    type_id         integer             NOT NULL,
    no              integer             NOT NULL DEFAULT 0,
    def             text                NULL,
    is_in_table     boolean             NOT NULL DEFAULT FALSE,
    can_be_null     boolean             NOT NULL DEFAULT FALSE,
    is_required     boolean             NOT NULL DEFAULT FALSE,
    is_repeated     boolean             NOT NULL DEFAULT FALSE,
    save_history    boolean             NOT NULL DEFAULT FALSE
);
SELECT * INTO del_prop FROM prop LIMIT 0;

CREATE SEQUENCE "value_id_seq" START 1000000;
CREATE TABLE value (
    id              integer             NOT NULL DEFAULT nextval('value_id_seq'),
    obj_id          integer             NOT NULL,
    prop_id         integer             NOT NULL,
    no              integer             NOT NULL DEFAULT 0,
    value           text                NOT NULL DEFAULT ''
);
SELECT * INTO del_value FROM value LIMIT 0;

CREATE TABLE integer_value (
    id              integer             NOT NULL DEFAULT nextval('value_id_seq'),
    obj_id          integer             NOT NULL,
    prop_id         integer             NOT NULL,
    no              integer             NOT NULL DEFAULT 0,
    value           integer             NULL
);
SELECT * INTO del_integer_value FROM value LIMIT 0;

CREATE TABLE old_value (
    obj_id          integer             NULL,
    prop_id         integer             NULL,
    no              integer             NULL,
    value           text                NULL,
    old_time        timestamp           NULL,
    user_id         integer             NULL
);

CREATE SEQUENCE "user_value_id_seq" START 1000000;
CREATE TABLE user_value (
    id              integer             NOT NULL DEFAULT nextval('user_value_id_seq'),
    obj_id          integer             NOT NULL,
    user_id         integer             NOT NULL,
    prop_id         integer             NOT NULL,
    no              integer             NOT NULL DEFAULT 0,
    value           text                NOT NULL DEFAULT ''
);
SELECT * INTO del_user_value FROM user_value LIMIT 0;

CREATE SEQUENCE "tag_id_seq" START 1000000;
CREATE TABLE tag (
    id              integer             NOT NULL DEFAULT nextval('tag_id_seq'),
    obj_id          integer             NOT NULL,
    tag_id          integer             NOT NULL
);
SELECT * INTO del_tag FROM tag limit 0;

CREATE SEQUENCE "tie_id_seq" START 1000000;
CREATE TABLE tie (
    id              integer             NOT NULL DEFAULT nextval('tie_id_seq'),
    src_id          integer             NOT NULL,
    dst_id          integer             NOT NULL,
    tag_id          integer             NOT NULL
);
SELECT * INTO del_tie FROM tie limit 0;

CREATE TABLE link (
    obj_id          integer             NOT NULL,
    src_id          integer             NOT NULL,
    dst_id          integer             NOT NULL,
    tag_id          integer             NOT NULL
);
SELECT NULL::timestamp AS old_time,NULL::integer AS user_id,* INTO old_link FROM link LIMIT 0;

CREATE SEQUENCE "status_id_seq" START 1000000;
CREATE TABLE status (
    id              integer             NOT NULL DEFAULT nextval('status_id_seq'),
    object_id       integer             NOT NULL,
    subject_id      integer             NULL,
    type_id         integer             NOT NULL,
    time            timestamp           NOT NULL DEFAULT now()
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_status FROM status limit 0;

CREATE TABLE profile (
    obj_id          integer             NOT NULL,
    type_id         integer             NOT NULL,
    state_id        integer             NOT NULL,
    class_id        integer             NOT NULL,
    client_id       integer             NULL,
    name            text                NOT NULL
);
SELECT * INTO del_profile FROM profile LIMIT 0;

CREATE SEQUENCE "blacklisted_id_seq" START 1000000;
CREATE TABLE blacklisted (
    id              integer             NOT NULL DEFAULT nextval('blacklisted_id_seq'),
    object_id       integer             NOT NULL,
    client_id       integer             NOT NULL,
    name            text                NOT NULL,
    message         text                NULL
);
SELECT * INTO del_blacklisted FROM blacklisted LIMIT 0;

CREATE TABLE change (
    obj_id          integer             NOT NULL,
    type_id         integer             NOT NULL,
    state_id        integer             NOT NULL,
    class_id        integer             NOT NULL,
    record_id       integer             NULL,
    client_id       integer             NOT NULL,
    time            timestamp           NOT NULL DEFAULT now(),
    user_comment    text                NOT NULL DEFAULT '',
    tech_comment    text                NOT NULL DEFAULT '',
    finish_time     timestamp           NULL
);
SELECT * INTO del_change FROM change LIMIT 0;

