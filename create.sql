-- $Header: /home/sol/usr/cvs/reodb/create.sql,v 1.2 2007/08/31 11:16:18 sol Exp $

CREATE SEQUENCE "id" START 1000000;

CREATE TABLE obj (
	obj_id		integer		DEFAULT nextval('id') NOT NULL,
	class_id	integer		NOT NULL,
	label		text		DEFAULT '' NOT NULL,
	descr		text		DEFAULT '' NOT NULL,
	create_time	timestamp	DEFAULT now() NOT NULL,
	update_time	timestamp	DEFAULT now() NOT NULL
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_obj FROM obj limit 0;

CREATE TABLE ref (
	obj_id		integer		NOT NULL,
	_id		integer		NOT NULL,
	name		text		DEFAULT '' NOT NULL,
	no		integer		DEFAULT 0 NOT NULL
);
SELECT * INTO del_ref FROM ref LIMIT 0;

CREATE TABLE prop (
	obj_id		integer		NOT NULL,
	class_id	integer		NOT NULL,
	name		text		NOT NULL,
	type_id		integer		NOT NULL,
	no		integer		DEFAULT 0 NOT NULL,
	def		text		NULL,
	is_t		boolean		DEFAULT FALSE NOT NULL,
	is_n		boolean		DEFAULT FALSE NOT NULL,
	is_s		boolean		DEFAULT FALSE NOT NULL,
	is_r		boolean		DEFAULT FALSE NOT NULL
);
SELECT * INTO del_prop FROM prop LIMIT 0;

CREATE TABLE value (
	id		integer		NOT NULL DEFAULT nextval('id'),
	obj_id		integer		NOT NULL,
	prop_id		integer		NOT NULL,
	no		integer		DEFAULT 0 NOT NULL,
	value		text		DEFAULT '' NOT NULL
);
SELECT * INTO del_value FROM value LIMIT 0;

CREATE TABLE user_value (
	id		integer		NOT NULL DEFAULT nextval('id'),
	obj_id		integer		NOT NULL,
	user_id		integer		NOT NULL,
	prop_id		integer		NOT NULL,
	no		integer		DEFAULT 0 NOT NULL,
	value		text		DEFAULT '' NOT NULL
);
SELECT * INTO del_user_value FROM user_value LIMIT 0;

CREATE TABLE tag (
	id		integer		NOT NULL DEFAULT nextval('id'),
	obj_id		integer		NOT NULL,
	tag_id		integer		NOT NULL
);
SELECT * INTO del_tag FROM tag limit 0;

CREATE TABLE tag2 (
	id		integer		NOT NULL DEFAULT nextval('id'),
	src_id		integer		NOT NULL,
	dst_id		integer		NOT NULL,
	tag_id		integer		NOT NULL
);
SELECT * INTO del_tag2 FROM tag2 limit 0;

CREATE TABLE link (
	obj_id		integer		NOT NULL,
	src_id		integer		NOT NULL,
	dst_id		integer		NOT NULL,
	tag_id		integer		NOT NULL
);
SELECT now()::timestamp without time zone AS old_time,* INTO old_link FROM link limit 0;

CREATE TABLE blacklist (
	obj_id		integer			NOT NULL,
	class_id	integer			NOT NULL,
	user_id		integer			NOT NULL,
	name		text			NOT NULL,
	for_myself	boolean			NOT NULL DEFAULT TRUE
);
SELECT * INTO del_blacklist FROM blacklist LIMIT 0;

CREATE TABLE wrong_login (
	login		text			NOT NULL,
	ip		inet			NOT NULL,
	time		timestamp		NOT NULL DEFAULT now()
);

CREATE TABLE log (
	id		integer			NOT NULL DEFAULT nextval('id'),
	login		text			NOT NULL,
	ip		inet			NOT NULL,
	time		timestamp		NOT NULL,
	page		text			NOT NULL,
	was_allowed	boolean			NOT NULL
);

CREATE TABLE log_var (
	id		integer			NOT NULL,
	name		text			NOT NULL,
	value		text			NOT NULL
);

