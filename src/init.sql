
-- BASIC BRANCHES
SELECT set_ref(0,'scalar',              'Scalar');
SELECT set_ref(0,'type',                'Type');
SELECT set_ref(0,'tag',                 'Tag');
SELECT set_ref(0,'state',               'State');
SELECT set_ref(0,'status',              'Status');
SELECT set_ref(0,'error',               'Error');
SELECT set_ref(0,'class',               'Class');

-- BASIC CLASSES
SELECT set_ref(0,'class,ref',           'Reference');
SELECT set_ref(0,'class,prop',          'Property');
SELECT set_ref(0,'class,link',          'Link');
SELECT set_ref(0,'class,param',         'Param');

-- SCALARS
SELECT set_ref('scalar,integer',        'integer');
SELECT set_ref('scalar,no',             'no');
SELECT set_ref('scalar,money',          'money');
SELECT set_ref('scalar,real',           'real');
SELECT set_ref('scalar,date',           'date');
SELECT set_ref('scalar,time',           'time');
SELECT set_ref('scalar,datetime',       'datetime');
SELECT set_ref('scalar,boolean',        'boolean');
SELECT set_ref('scalar,text',           'text');
SELECT set_ref('scalar,name',           'name');
SELECT set_ref('scalar,login',          'login');
SELECT set_ref('scalar,password',       'password');
SELECT set_ref('scalar,textarea',       'textarea');
SELECT set_ref('scalar,ip',             'ip');
SELECT set_ref('scalar,ips',            'ips');
SELECT set_ref('scalar,nets',           'nets');
SELECT set_ref('scalar,mac',            'mac');
SELECT set_ref('scalar,email',          'email');
SELECT set_ref('scalar,emails',         'emails');
SELECT set_ref('scalar,domain',         'domain');
SELECT set_ref('scalar,domains',        'domains');
SELECT set_ref('scalar,filtertext',     'filter text');
SELECT set_ref('scalar,label',          'label');
SELECT set_ref('scalar,systempath',     'system path');

-- PROPS
SELECT set_prop( 1,'class:table',       scalar_id('text'),      'Table',         '');
SELECT set_prop( 2,'class:obj_name',    scalar_id('text'),      'Object name',   '');
SELECT set_prop(11,'class:label',       scalar_id('text'),      'Label',         '',     TRUE,NULL,NULL,NULL);
SELECT set_prop(22,'class:descr',       scalar_id('textarea'),  'Description',   '',     TRUE,NULL,NULL,NULL);

SELECT set_prop( 1,'ref:_id',           class_id('ref'),        'Parent',        NULL,   TRUE,NULL,NULL,NULL);
SELECT set_prop( 2,'ref:name',          scalar_id('name'),      'Name',          '',     TRUE,NULL,NULL,NULL);
SELECT set_prop( 3,'ref:no',            scalar_id('no'),        'No.',           '0',    TRUE,NULL,NULL,NULL);

SELECT set_prop( 1,'prop:class_id',     class_id('ref'),        'Class',         NULL,   TRUE,NULL,TRUE,NULL);
SELECT set_prop( 2,'prop:name',         scalar_id('name'),      'Name',          '',     TRUE,NULL,TRUE,NULL);
SELECT set_prop( 3,'prop:type_id',      class_id('ref'),        'Type',          NULL,   TRUE,NULL,TRUE,NULL);
SELECT set_prop( 4,'prop:no',           scalar_id('no'),        'No.',           '0',    TRUE,NULL,NULL,NULL);
SELECT set_prop( 5,'prop:def',          scalar_id('label'),     'Default value', '',     TRUE,TRUE,NULL,NULL);
SELECT set_prop(11,'prop:is_in_table',  scalar_id('boolean'),   'Is in table',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(12,'prop:can_be_null',  scalar_id('boolean'),   'Can be null',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(13,'prop:is_required',  scalar_id('boolean'),   'Is required',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(14,'prop:is_repeated',  scalar_id('boolean'),   'Is repeated',   'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop(21,'prop:save_history', scalar_id('boolean'),   'Save history',  'f',    TRUE,NULL,NULL,NULL);
SELECT set_prop( 0,'prop:copy_to',      scalar_id('name'),      'Copy to props', '');
SELECT set_prop( 0,'prop:trigger',      scalar_id('name'),      'Trigger on all','');
SELECT set_prop( 0,'prop:insert_trigger',scalar_id('name'),     'Insert trigger','');
SELECT set_prop( 0,'prop:update_trigger',scalar_id('name'),     'Update trigger','');
SELECT set_prop( 0,'prop:delete_trigger',scalar_id('name'),     'Delete trigger','');
SELECT set_prop( 0,'prop:separator',    scalar_id('boolean'),   'Separator',     'f');
SELECT set_prop( 0,'prop:comment',      scalar_id('text'),      'Comment',       '');
SELECT set_prop( 0,'prop:readonly',     scalar_id('boolean'),   'Readonly',      'f');
SELECT set_prop( 0,'prop:admin_only',   scalar_id('boolean'),   'Admin only',    'f');
SELECT set_prop( 0,'prop:owner_only',   scalar_id('boolean'),   'Owner only',    'f');
SELECT set_prop( 0,'prop:disabled',     scalar_id('boolean'),   'Disabled',      'f');
SELECT set_prop( 0,'prop:hidden',       scalar_id('boolean'),   'Hidden',        'f');
SELECT set_prop( 0,'prop:before_html',  scalar_id('text'),      'Additional html before input', '');

-- OBJECT_NAMEs
SELECT set_value(class_id('ref'),       'class:obj_name',       'ref_full_name(obj_id)');
SELECT set_value(class_id('prop'),      'class:obj_name',       'class_full_name(class_id)||'':''||name');

-- PRIORITIES
SELECT set_ref( 0,'type,priority',              'Priority');
SELECT set_ref( 1,'type,priority,low',          'Low');
SELECT set_ref( 2,'type,priority,medium',       'Medium');
SELECT set_ref( 3,'type,priority,high',         'High');
SELECT set_ref( 4,'type,priority,ultrahigh',    'Ultrahigh');

-- GRADES
SELECT set_ref( 0,'type,grade',                 'Grade');
SELECT set_ref( 1,'type,grade,terrible',        'Terrible');
SELECT set_ref( 2,'type,grade,bad',             'Bad');
SELECT set_ref( 3,'type,grade,ok',              'O.k.');
SELECT set_ref( 4,'type,grade,good',            'Good');
SELECT set_ref( 5,'type,grade,excellent',       'Excellent');

