CREATE OR REPLACE FUNCTION guess_country(a_name text) RETURNS text AS $$
    WITH u AS (
        SELECT 'Ukraine' AS iso,        array['ua', 'украина', 'ukrain', 'ukraina', 'україна', 'ukrine', 'ukriane', 'ukaraine', 'kiev'] AS variants UNION ALL
        SELECT 'Belarus',               array['by', 'беларусь', 'беларусия'] UNION ALL
        SELECT 'Russian Federation',    array['ru', 'rus', 'russia', 'russian', 'russiya', 'россия', 'рф', 'rf', 'российская федерация', 'москва', 'moscow'] UNION ALL
        SELECT 'United States',         array['us', 'usa', 'сша', 'united stated'] UNION ALL
        SELECT 'United Kingdom',        array['gb', 'англия', 'england', 'britain', 'uk', 'scotland'] UNION ALL
        SELECT 'United Arab Emirates',  array['ae', 'оаэ'] UNION ALL
        SELECT 'Afghanistan',           array['af'] UNION ALL
        SELECT 'Albania',               array['al'] UNION ALL
        SELECT 'Algeria', array['dz'] UNION ALL
        SELECT 'American Samoa', array['as'] UNION ALL
        SELECT 'Andorra', array['ad'] UNION ALL
        SELECT 'Angola', array['ao'] UNION ALL
        SELECT 'Anguilla', array['ai'] UNION ALL
        SELECT 'Antarctica', array['aq'] UNION ALL
        SELECT 'Antigua And Barbuda', array['ag'] UNION ALL
        SELECT 'Argentina', array['ar'] UNION ALL
        SELECT 'Armenia', array['am'] UNION ALL
        SELECT 'Aruba', array['aw'] UNION ALL
        SELECT 'Australia', array['au'] UNION ALL
        SELECT 'Austria', array['at'] UNION ALL
        SELECT 'Azerbaijan', array['az'] UNION ALL
        SELECT 'Bahamas',               array['bs', 'багамы'] UNION ALL
        SELECT 'Bahrain', array['bh'] UNION ALL
        SELECT 'Bangladesh', array['bd'] UNION ALL
        SELECT 'Barbados', array['bb'] UNION ALL
        SELECT 'Belgium', array['be'] UNION ALL
        SELECT 'Belize', array['bz'] UNION ALL
        SELECT 'Benin', array['bj'] UNION ALL
        SELECT 'Bermuda', array['bm'] UNION ALL
        SELECT 'Bhutan', array['bt'] UNION ALL
        SELECT 'Bosnia And Herzegovina', array['ba'] UNION ALL
        SELECT 'Botswana', array['bw'] UNION ALL
        SELECT 'Bouvet Island', array['bv'] UNION ALL
        SELECT 'Brazil',                array['br', 'brasil'] UNION ALL
        SELECT 'Brunei Darussalam', array['bn'] UNION ALL
        SELECT 'Bulgaria', array['bg'] UNION ALL
        SELECT 'Burkina Faso', array['bf'] UNION ALL
        SELECT 'Burundi', array['bi'] UNION ALL
        SELECT 'Cambodia', array['kh'] UNION ALL
        SELECT 'Cameroon', array['cm'] UNION ALL
        SELECT 'Canada', array['ca'] UNION ALL
        SELECT 'Cape Verde', array['cv'] UNION ALL
        SELECT 'Cayman Islands', array['ky'] UNION ALL
        SELECT 'Central African Republic', array['cf'] UNION ALL
        SELECT 'Chad', array['td'] UNION ALL
        SELECT 'Chile', array['cl'] UNION ALL
        SELECT 'China', array['cn'] UNION ALL
        SELECT 'Christmas Island', array['cx'] UNION ALL
        SELECT 'Cocos (Keeling) Islands', array['cc'] UNION ALL
        SELECT 'Colombia', array['co'] UNION ALL
        SELECT 'Comoros', array['km'] UNION ALL
        SELECT 'Congo', array['cg'] UNION ALL
        SELECT 'Congo, The Democratic Republic Of The', array['cd'] UNION ALL
        SELECT 'Cook Islands', array['ck'] UNION ALL
        SELECT 'Costa Rica', array['cr'] UNION ALL
        SELECT 'Croatia', array['hr'] UNION ALL
        SELECT 'Cuba', array['cu'] UNION ALL
        SELECT 'Cyprus', array['cy'] UNION ALL
        SELECT 'Czech Republic',            array['cz', 'czech', 'czech rep.', 'чехия', 'czeсh republic'] UNION ALL
        SELECT 'Denmark', array['dk'] UNION ALL
        SELECT 'Djibouti', array['dj'] UNION ALL
        SELECT 'Dominica', array['dm', 'commonwealth of dominica'] UNION ALL
        SELECT 'Dominican Republic', array['do'] UNION ALL
        SELECT 'Ecuador', array['ec'] UNION ALL
        SELECT 'Egypt', array['eg'] UNION ALL
        SELECT 'El Salvador', array['sv'] UNION ALL
        SELECT 'Equatorial Guinea', array['gq'] UNION ALL
        SELECT 'Eritrea', array['er'] UNION ALL
        SELECT 'Estonia',                   array['ee', 'estland'] UNION ALL
        SELECT 'Ethiopia', array['et'] UNION ALL
        SELECT 'Faroe Islands', array['fo'] UNION ALL
        SELECT 'Fiji', array['fj'] UNION ALL
        SELECT 'Finland', array['fi'] UNION ALL
        SELECT 'France', array['fr'] UNION ALL
        SELECT 'French Guiana', array['gf'] UNION ALL
        SELECT 'French Polynesia', array['pf'] UNION ALL
        SELECT 'Gabon', array['ga'] UNION ALL
        SELECT 'Gambia', array['gm'] UNION ALL
        SELECT 'Georgia', array['ge'] UNION ALL
        SELECT 'Germany', array['de'] UNION ALL
        SELECT 'Ghana', array['gh'] UNION ALL
        SELECT 'Gibraltar', array['gi'] UNION ALL
        SELECT 'Greece', array['gr'] UNION ALL
        SELECT 'Greenland', array['gl'] UNION ALL
        SELECT 'Grenada', array['gd'] UNION ALL
        SELECT 'Guadeloupe', array['gp'] UNION ALL
        SELECT 'Guam', array['gu'] UNION ALL
        SELECT 'Guatemala', array['gt'] UNION ALL
        SELECT 'Guernsey', array['gg'] UNION ALL
        SELECT 'Guinea', array['gn'] UNION ALL
        SELECT 'Guinea-Bissau', array['gw'] UNION ALL
        SELECT 'Guyana', array['gy'] UNION ALL
        SELECT 'Haiti', array['ht'] UNION ALL
        SELECT 'Honduras', array['hn'] UNION ALL
        SELECT 'Hong Kong', array['hk'] UNION ALL
        SELECT 'Hungary', array['hu'] UNION ALL
        SELECT 'Iceland', array['is'] UNION ALL
        SELECT 'India', array['in'] UNION ALL
        SELECT 'Indonesia', array['id'] UNION ALL
        SELECT 'Iran, Islamic Republic Of', array['ir'] UNION ALL
        SELECT 'Iraq', array['iq'] UNION ALL
        SELECT 'Ireland', array['ie'] UNION ALL
        SELECT 'Isle Of Man', array['im'] UNION ALL
        SELECT 'Israel',                    array['il', 'израиль'] UNION ALL
        SELECT 'Italy',                     array['it', 'италия'] UNION ALL
        SELECT 'Jamaica', array['jm'] UNION ALL
        SELECT 'Japan', array['jp'] UNION ALL
        SELECT 'Jersey', array['je'] UNION ALL
        SELECT 'Jordan', array['jo'] UNION ALL
        SELECT 'Kazakhstan',                array['kz', 'казахстан'] UNION ALL
        SELECT 'Kenya',                     array['ke'] UNION ALL
        SELECT 'Kiribati',                  array['ki'] UNION ALL
        SELECT 'Korea, Democratic People''s Republic Of', array['kp'] UNION ALL
        SELECT 'Korea, Republic Of',        array['kr'] UNION ALL
        SELECT 'Kuwait',                    array['kw'] UNION ALL
        SELECT 'Kyrgyzstan',                array['kg', 'киргизстан'] UNION ALL
        SELECT 'Lao People''s Democratic Republic', array['la'] UNION ALL
        SELECT 'Latvia', array['lv'] UNION ALL
        SELECT 'Lebanon', array['lb'] UNION ALL
        SELECT 'Lesotho', array['ls'] UNION ALL
        SELECT 'Liberia', array['lr'] UNION ALL
        SELECT 'Libya', array['ly'] UNION ALL
        SELECT 'Liechtenstein', array['li'] UNION ALL
        SELECT 'Lithuania',                 array['lt', 'litva'] UNION ALL
        SELECT 'Luxembourg', array['lu'] UNION ALL
        SELECT 'Macao', array['mo'] UNION ALL
        SELECT 'Macedonia, The Former Yugoslav Republic Of', array['mk'] UNION ALL
        SELECT 'Madagascar', array['mg'] UNION ALL
        SELECT 'Malawi', array['mw'] UNION ALL
        SELECT 'Malaysia', array['my'] UNION ALL
        SELECT 'Maldives', array['mv'] UNION ALL
        SELECT 'Mali', array['ml'] UNION ALL
        SELECT 'Malta', array['mt'] UNION ALL
        SELECT 'Marshall Islands', array['mh'] UNION ALL
        SELECT 'Martinique', array['mq'] UNION ALL
        SELECT 'Mauritania', array['mr'] UNION ALL
        SELECT 'Mauritius', array['mu'] UNION ALL
        SELECT 'Mayotte', array['yt'] UNION ALL
        SELECT 'Mexico', array['mx'] UNION ALL
        SELECT 'Micronesia, Federated States Of', array['fm'] UNION ALL
        SELECT 'Moldova, Republic Of',  array['md', 'молдова', 'moldova'] UNION ALL
        SELECT 'Monaco', array['mc'] UNION ALL
        SELECT 'Mongolia', array['mn'] UNION ALL
        SELECT 'Montenegro', array['me'] UNION ALL
        SELECT 'Montserrat', array['ms'] UNION ALL
        SELECT 'Morocco', array['ma'] UNION ALL
        SELECT 'Mozambique', array['mz'] UNION ALL
        SELECT 'Myanmar', array['mm'] UNION ALL
        SELECT 'Namibia', array['na'] UNION ALL
        SELECT 'Nauru', array['nr'] UNION ALL
        SELECT 'Nepal', array['np'] UNION ALL
        SELECT 'Netherlands',           array['nl', 'нидерланды', 'the netherlands', 'netherland'] UNION ALL
        SELECT 'New Caledonia', array['nc'] UNION ALL
        SELECT 'New Zealand', array['nz'] UNION ALL
        SELECT 'Nicaragua', array['ni'] UNION ALL
        SELECT 'Niger', array['ne'] UNION ALL
        SELECT 'Nigeria', array['ng'] UNION ALL
        SELECT 'Niue', array['nu'] UNION ALL
        SELECT 'Norfolk Island', array['nf'] UNION ALL
        SELECT 'Northern Mariana Islands', array['mp'] UNION ALL
        SELECT 'Norway', array['no'] UNION ALL
        SELECT 'Oman', array['om'] UNION ALL
        SELECT 'Pakistan', array['pk'] UNION ALL
        SELECT 'Palau',                 array['pw'] UNION ALL
        SELECT 'Palestine, State Of',   array['ps'] UNION ALL
        SELECT 'Panama',                array['pa', 'republic of panama'] UNION ALL
        SELECT 'Papua New Guinea',      array['pg'] UNION ALL
        SELECT 'Paraguay',              array['py'] UNION ALL
        SELECT 'Peru',                  array['pe'] UNION ALL
        SELECT 'Philippines',           array['ph', 'pilipinas'] UNION ALL
        SELECT 'Pitcairn', array['pn'] UNION ALL
        SELECT 'Poland', array['pl'] UNION ALL
        SELECT 'Portugal', array['pt'] UNION ALL
        SELECT 'Puerto Rico', array['pr'] UNION ALL
        SELECT 'Qatar', array['qa'] UNION ALL
        SELECT 'Romania', array['ro'] UNION ALL
        SELECT 'Rwanda', array['rw'] UNION ALL
        SELECT 'Samoa', array['ws'] UNION ALL
        SELECT 'San Marino', array['sm'] UNION ALL
        SELECT 'Sao Tome And Principe', array['st'] UNION ALL
        SELECT 'Saudi Arabia', array['sa'] UNION ALL
        SELECT 'Senegal', array['sn'] UNION ALL
        SELECT 'Serbia', array['rs'] UNION ALL
        SELECT 'Seychelles',            array['sc', 'seuchelles', 'сейшельские о-ва'] UNION ALL
        SELECT 'Sierra Leone', array['sl'] UNION ALL
        SELECT 'Singapore', array['sg'] UNION ALL
        SELECT 'Slovakia', array['sk'] UNION ALL
        SELECT 'Slovenia', array['si'] UNION ALL
        SELECT 'Solomon Islands', array['sb'] UNION ALL
        SELECT 'Somalia', array['so'] UNION ALL
        SELECT 'South Africa', array['za'] UNION ALL
        SELECT 'South Sudan', array['ss'] UNION ALL
        SELECT 'Spain', array['es'] UNION ALL
        SELECT 'Sri Lanka', array['lk'] UNION ALL
        SELECT 'Sudan', array['sd'] UNION ALL
        SELECT 'Suriname', array['sr'] UNION ALL
        SELECT 'Svalbard And Jan Mayen', array['sj'] UNION ALL
        SELECT 'Swaziland', array['sz'] UNION ALL
        SELECT 'Sweden', array['se'] UNION ALL
        SELECT 'Switzerland', array['ch'] UNION ALL
        SELECT 'Syrian Arab Republic', array['sy'] UNION ALL
        SELECT 'Taiwan, Province Of China', array['tw'] UNION ALL
        SELECT 'Tajikistan', array['tj'] UNION ALL
        SELECT 'Tanzania, United Republic Of', array['tz'] UNION ALL
        SELECT 'Thailand', array['th'] UNION ALL
        SELECT 'Timor-Leste', array['tl'] UNION ALL
        SELECT 'Togo', array['tg'] UNION ALL
        SELECT 'Tokelau', array['tk'] UNION ALL
        SELECT 'Tonga', array['to'] UNION ALL
        SELECT 'Trinidad And Tobago', array['tt'] UNION ALL
        SELECT 'Tunisia', array['tn'] UNION ALL
        SELECT 'Turkey', array['tr'] UNION ALL
        SELECT 'Turkmenistan', array['tm'] UNION ALL
        SELECT 'Turks And Caicos Islands', array['tc'] UNION ALL
        SELECT 'Tuvalu', array['tv'] UNION ALL
        SELECT 'Uganda', array['ug'] UNION ALL
        SELECT 'Uruguay', array['uy'] UNION ALL
        SELECT 'Uzbekistan', array['uz'] UNION ALL
        SELECT 'Vanuatu', array['vu'] UNION ALL
        SELECT 'Venezuela, Bolivarian Republic Of', array['ve'] UNION ALL
        SELECT 'Viet Nam', array['vn', 'vietnam'] UNION ALL
        SELECT 'Virgin Islands, British', array['vg', 'british virgin islands', 'virgin islands british'] UNION ALL
        SELECT 'Virgin Islands, U.S.', array['vi'] UNION ALL
        SELECT 'Wallis And Futuna', array['wf'] UNION ALL
        SELECT 'Western Sahara', array['eh'] UNION ALL
        SELECT 'Yemen', array['ye'] UNION ALL
        SELECT 'Zambia', array['zm'] UNION ALL
        SELECT 'Zimbabwe', array['zw']
    )
    SELECT iso FROM u WHERE lower($1 COLLATE "ru_RU.UTF-8")=any(variants) OR lower($1 COLLATE "ru_RU.UTF-8")=lower(iso);
$$ LANGUAGE sql IMMUTABLE STRICT;
