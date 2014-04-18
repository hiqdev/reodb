-- $Header: /home/sol/usr/cvs/reodb/defaults.sql,v 1.1.1.1 2007/08/30 15:13:56 sol Exp $

ALTER TABLE ONLY change             ALTER type_id       SET DEFAULT type_id('change,set');
ALTER TABLE ONLY change             ALTER state_id      SET DEFAULT state_id('change,new');

