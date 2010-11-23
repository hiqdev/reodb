-- $Header: /home/sol/usr/cvs/reodb/create.sql,v 1.2 2007/08/31 11:16:18 sol Exp $

CREATE SEQUENCE "id" START 1000000;

CREATE TABLE obj (
	obj_id		bigint		NOT NULL DEFAULT nextval('id'),
	class_id	bigint		NOT NULL,
	label		text		NOT NULL DEFAULT '',
	descr		text		NOT NULL DEFAULT '',
	create_time	timestamp	NOT NULL DEFAULT now(),
	update_time	timestamp	NOT NULL DEFAULT now()
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_obj FROM obj limit 0;

CREATE TABLE ref (
	obj_id		bigint		NOT NULL,
	_id		bigint		NOT NULL,
	name		text		NOT NULL DEFAULT '',
	no		integer		NOT NULL DEFAULT 0
);
SELECT * INTO del_ref FROM ref LIMIT 0;

CREATE TABLE prop (
	obj_id		bigint		NOT NULL,
	class_id	bigint		NOT NULL,
	name		text		NOT NULL,
	type_id		bigint		NOT NULL,
	no		integer		NOT NULL DEFAULT 0,
	def		text		NULL,
	is_in_table	boolean		NOT NULL DEFAULT FALSE,
	can_be_null	boolean		NOT NULL DEFAULT FALSE,
	is_required	boolean		NOT NULL DEFAULT FALSE,
	is_repeated	boolean		NOT NULL DEFAULT FALSE,
	save_history	boolean		NOT NULL DEFAULT FALSE,
	insert_trigger	text		NULL,
	update_trigger	text		NULL,
	delete_trigger	text		NULL
);
SELECT * INTO del_prop FROM prop LIMIT 0;

CREATE TABLE value (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	obj_id		bigint		NOT NULL,
	prop_id		bigint		NOT NULL,
	no		integer		NOT NULL DEFAULT 0,
	value		text		NOT NULL DEFAULT ''
);
SELECT * INTO del_value FROM value LIMIT 0;

CREATE TABLE old_value (
	obj_id		bigint		NULL,
	prop_id		bigint		NULL,
	no		integer		NULL,
	value		text		NULL,
	old_time	timestamp	NULL,
	user_id		bigint		NULL
);

CREATE TABLE user_value (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	obj_id		bigint		NOT NULL,
	user_id		bigint		NOT NULL,
	prop_id		bigint		NOT NULL,
	no		integer		NOT NULL DEFAULT 0,
	value		text		NOT NULL DEFAULT ''
);
SELECT * INTO del_user_value FROM user_value LIMIT 0;

CREATE TABLE tag (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	obj_id		bigint		NOT NULL,
	tag_id		bigint		NOT NULL
);
SELECT * INTO del_tag FROM tag limit 0;

CREATE TABLE tag2 (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	src_id		bigint		NOT NULL,
	dst_id		bigint		NOT NULL,
	tag_id		bigint		NOT NULL
);
SELECT * INTO del_tag2 FROM tag2 limit 0;

CREATE TABLE link (
	obj_id		bigint		NOT NULL,
	src_id		bigint		NOT NULL,
	dst_id		bigint		NOT NULL,
	tag_id		bigint		NOT NULL
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_link FROM link limit 0;

CREATE TABLE status (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	object_id	bigint		NOT NULL,
	user_id		bigint		NULL,
	type_id		bigint		NOT NULL,
	time		timestamp	NOT NULL DEFAULT now()
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_status FROM status limit 0;

CREATE TABLE blacklist (
	obj_id		bigint		NOT NULL,
	class_id	bigint		NOT NULL,
	user_id		bigint		NOT NULL,
	name		text		NOT NULL,
	for_myself	boolean		NOT NULL DEFAULT TRUE
);
SELECT * INTO del_blacklist FROM blacklist LIMIT 0;

CREATE TABLE wrong_login (
	login		text		NOT NULL,
	ip		inet		NOT NULL,
	time		timestamp	NOT NULL DEFAULT now()
);

CREATE TABLE log (
	id		bigint		NOT NULL DEFAULT nextval('id'),
	login		text		NOT NULL,
	ip		inet		NOT NULL,
	time		timestamp	NOT NULL,
	page		text		NOT NULL,
	was_allowed	boolean		NOT NULL
);

CREATE TABLE log_var (
	id		bigint		NOT NULL,
	name		text		NOT NULL,
	value		text		NOT NULL
);

