-- $Header: /home/sol/usr/cvs/reodb/zero_insert.sql,v 1.2 2007/08/31 11:16:38 sol Exp $

INSERT INTO obj (obj_id,class_id,label) VALUES (0,2,'{lang:Initial root ref}');
INSERT INTO obj (obj_id,class_id,label) VALUES (1,2,'{lang:Class}');
INSERT INTO obj (obj_id,class_id,label)	VALUES (2,2,'{lang:Type}');
INSERT INTO obj (obj_id,class_id,label)	VALUES (3,2,'{lang:Link}');

INSERT INTO ref (obj_id,_id,name,no)	VALUES (0,0,'',0);
INSERT INTO ref (obj_id,_id,name,no)	VALUES (1,0,'class',0);
INSERT INTO ref (obj_id,_id,name,no)	VALUES (2,1,'ref',0);
INSERT INTO ref (obj_id,_id,name,no)	VALUES (3,1,'link',0);

