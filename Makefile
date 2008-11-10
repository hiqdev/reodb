# $Header: /home/sol/usr/cvs/reodb/Makefile,v 1.3 2007/08/31 13:21:16 sol Exp $

DBNAME	:= reodb
PSQL	:= psql $(DBNAME)

_all.sql: _redo.sql init.sql
	cat $^ > $@

_redo.sql: create.sql zero_insert.sql alter.sql functions.sql defaults.sql triggers.sql views.sql
	cat $^ > $@

recreate:
	dropdb $(DBNAME);createdb $(DBNAME)

#	$(PSQL) -f $< > notice 2> error
%: %.sql
	$(PSQL) -f $<
clean:
	rm -f _*.sql

do_all: clean recreate _all

