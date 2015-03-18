
-- BASIC BRANCHES
SELECT set_ref(0,'scalar',              '{Lang:Scalar}');
SELECT set_ref(0,'type',                '{Lang:Type}');
SELECT set_ref(0,'tag',                 '{Lang:Tag}');
SELECT set_ref(0,'state',               '{Lang:State}');
SELECT set_ref(0,'status',              '{Lang:Status}');
SELECT set_ref(0,'error',               '{Lang:Error}');
SELECT set_ref(0,'class',               '{Lang:Class}');

-- BASIC CLASSES
SELECT set_ref(0,'class,ref',           '{Lang:Reference}');
SELECT set_ref(0,'class,prop',          '{Lang:Property}');
SELECT set_ref(0,'class,link',          '{Lang:Link}');

-- SCALARS
SELECT set_ref('scalar,integer',        '{Lang:integer}');
SELECT set_ref('scalar,no',             '{Lang:no}');
SELECT set_ref('scalar,money',          '{Lang:money}');
SELECT set_ref('scalar,real',           '{Lang:real}');
SELECT set_ref('scalar,date',           '{Lang:date}');
SELECT set_ref('scalar,time',           '{Lang:time}');
SELECT set_ref('scalar,datetime',       '{Lang:datetime}');
SELECT set_ref('scalar,boolean',        '{Lang:boolean}');
SELECT set_ref('scalar,text',           '{Lang:text}');
SELECT set_ref('scalar,name',           '{Lang:name}');
SELECT set_ref('scalar,login',          '{Lang:login}');
SELECT set_ref('scalar,password',       '{Lang:password}');
SELECT set_ref('scalar,textarea',       '{Lang:textarea}');
SELECT set_ref('scalar,ip',             '{Lang:ip}');
SELECT set_ref('scalar,ips',            '{Lang:ips}');
SELECT set_ref('scalar,nets',           '{Lang:nets}');
SELECT set_ref('scalar,mac',            '{Lang:mac}');
SELECT set_ref('scalar,email',          '{Lang:email}');
SELECT set_ref('scalar,emails',         '{Lang:emails}');
SELECT set_ref('scalar,domain',         '{Lang:domain}');
SELECT set_ref('scalar,domains',        '{Lang:domains}');
SELECT set_ref('scalar,filtertext',     '{Lang:filter text}');
SELECT set_ref('scalar,label',          '{Lang:label}');
SELECT set_ref('scalar,systempath',     '{Lang:system path}');

-- PROPS
SELECT set_prop( 1,'class:label',       scalar_id('text'),      '{Lang:Label}',         '',     TRUE,NULL,NULL,NULL);
SELECT set_prop( 2,'class:descr',       scalar_id('textarea'),  '{Lang:Description}',   '',     TRUE,NULL,NULL,NULL);
SELECT set_prop( 0,'class:obj_name',    scalar_id('text'),      '{Lang:Object name}',   '');

SELECT set_prop( 1,'ref:_id',           class_id('ref'),        '{Lang:Parent}',        NULL,   TRUE,NULL,NULL,NULL);
SELECT set_prop( 2,'ref:name',          scalar_id('name'),      '{Lang:Name}',          '',     TRUE,NULL,NULL,NULL);
SELECT set_prop( 3,'ref:no',            scalar_id('no'),        '{Lang:No.}',           '0',    TRUE,NULL,NULL,NULL);

SELECT set_prop( 1,'prop:class_id',     class_id('ref'),        '{Lang:Class}',         NULL,   TRUE,NULL,TRUE,NULL);
SELECT set_prop( 2,'prop:name',         scalar_id('name'),      '{Lang:Name}',          '',     TRUE,NULL,TRUE,NULL);
SELECT set_prop( 3,'prop:type_id',      class_id('ref'),        '{Lang:Type}',          NULL,   TRUE,NULL,TRUE,NULL);
SELECT set_prop( 4,'prop:no',           scalar_id('no'),        '{Lang:No.}',           '0',    TRUE,NULL,NULL,NULL);
SELECT set_prop( 5,'prop:def',          scalar_id('label'),     '{Lang:Default value}', '',     TRUE,TRUE,NULL,NULL);
SELECT set_prop(11,'prop:is_in_table',  scalar_id('boolean'),   '{Lang:Is in table}',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(12,'prop:can_be_null',  scalar_id('boolean'),   '{Lang:Can be null}',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(13,'prop:is_required',  scalar_id('boolean'),   '{Lang:Is required}',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(14,'prop:is_repeated',  scalar_id('boolean'),   '{Lang:Is repeated}',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(21,'prop:save_history', scalar_id('boolean'),   '{Lang:Save history}',  'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop( 0,'prop:insert_trigger',scalar_id('name'),     '{Lang:Insert trigger}','');
SELECT set_prop( 0,'prop:update_trigger',scalar_id('name'),     '{Lang:Update trigger}','');
SELECT set_prop( 0,'prop:delete_trigger',scalar_id('name'),     '{Lang:Delete trigger}','');
SELECT set_prop( 0,'prop:separator',    scalar_id('boolean'),   '{Lang:Separator}',     'f');
SELECT set_prop( 0,'prop:comment',      scalar_id('text'),      '{Lang:Comment}',       '');
SELECT set_prop( 0,'prop:readonly',     scalar_id('boolean'),   '{Lang:Readonly}',      'f');
SELECT set_prop( 0,'prop:admin_only',   scalar_id('boolean'),   '{Lang:Admin only}',    'f');
SELECT set_prop( 0,'prop:owner_only',   scalar_id('boolean'),   '{Lang:Owner only}',    'f');
SELECT set_prop( 0,'prop:disabled',     scalar_id('boolean'),   '{Lang:Disabled}',      'f');
SELECT set_prop( 0,'prop:hidden',       scalar_id('boolean'),   '{Lang:Hidden}',        'f');
SELECT set_prop( 0,'prop:before_html',  scalar_id('text'),      'Additional html before input', '');

-- OBJECT_NAMEs
SELECT set_value(class_id('ref'),       'class:obj_name',       'ref_full_name(obj_id)');
SELECT set_value(class_id('prop'),      'class:obj_name',       'class_full_name(class_id)||'':''||name');

-- PRIORITIES
SELECT set_ref( 0,'type,priority',              '{Lang:Priority}');
SELECT set_ref( 1,'type,priority,low',          '{Lang:Low}');
SELECT set_ref( 2,'type,priority,medium',       '{Lang:Medium}');
SELECT set_ref( 3,'type,priority,high',         '{Lang:High}');
SELECT set_ref( 4,'type,priority,ultrahigh',    '{Lang:Ultrahigh}');

-- GRADES
SELECT set_ref( 0,'type,grade',                 '{Lang:Grade}');
SELECT set_ref( 1,'type,grade,terrible',        '{Lang:Terrible}');
SELECT set_ref( 2,'type,grade,bad',             '{Lang:Bad}');
SELECT set_ref( 3,'type,grade,ok',              '{Lang:O.k.}');
SELECT set_ref( 4,'type,grade,good',            '{Lang:Good}');
SELECT set_ref( 5,'type,grade,excellent',       '{Lang:Excellent}');

