# hiqdev/reodb commits history

## [Under development]

    - [f948529] 2017-06-23 Added `prepare_replace` for jsonb [d.naumenko.a@gmail.com]
    - [abd394a] 2017-04-20 csfixed [sol@hiqdev.com]
    - [8b1a60a] 2017-04-20 improved `check_too_long_queries`: `allowed_long_queries`, 2 minutes [sol@hiqdev.com]
    - [e3fc46b] 2017-04-11 added show scripts: `pg_stat_activity`, relpages, reltables [sol@hiqdev.com]
    - [ac97406] 2017-04-11 improved query for `check_too_long_queries` [sol@hiqdev.com]
    - [7127d41] 2017-04-10 added periodic for too long queries and too many connections [sol@hiqdev.com]
    - [81814f7] 2017-03-28 added `refresh_zref` statement level trigger [sol@hiqdev.com]
    - [ca44469] 2017-03-24 added `to_cents(text)` [sol@hiqdev.com]
    - [53458d2] 2017-02-20 added `str2smallint()` [sol@hiqdev.com]
    - [9806d42] 2016-12-15 Added `set_statuses` with `subject_id` param [d.naumenko.a@gmail.com]
    - [aaffda5] 2016-11-21 + `interval_table` [sol@hiqdev.com]
    - [a6128ba] 2016-11-04 add `guess_country_code_name_pkey` [sol@hiqdev.com]
    - [f20c27d] 2016-11-03 added `guess_country_code` [sol@hiqdev.com]
    - [41ddfde] 2016-11-03 splitted out `guess_country` [sol@hiqdev.com]
    - [c083045] 2016-07-01 + `guess_country` function [sol@hiqdev.com]
- Fixed code organization
    - [4a05785] 2015-11-18 improved package description [sol@hiqdev.com]
    - [d3867de] 2015-10-15 fixed `update_time_trigger`: used is not distinct from [sol@hiqdev.com]
    - [a3f1971] 2015-10-14 moved to src & bin [sol@hiqdev.com]
    - [becb9c6] 2015-10-14 removed translit junk [sol@hiqdev.com]
    - [c2aa079] 2015-10-14 - Lang [sol@hiqdev.com]
    - [88ac62d] 2015-10-14 retabed [sol@hiqdev.com]
    - [8873506] 2015-10-14 retabed [sol@hiqdev.com]
    - [9ebe2a9] 2015-10-14 retabed functions.sql [sol@hiqdev.com]
    - [1810fba] 2015-10-12 redone `prepare_replace` functions without INOUT [sol@hiqdev.com]
    - [4bc7d54] 2015-10-12 improved code style for nonempty() [sol@hiqdev.com]
- Added packaging: hidev, README, CHANGELOG, LICENSE
    - [bec8b17] 2015-10-14 improved readme [sol@hiqdev.com]
    - [6d3a5cc] 2015-10-14 added packaging [sol@hiqdev.com]
    - [bb793c7] 2015-10-14 + hidev config [sol@hiqdev.com]
- Added history
    - [3e41575] 2015-10-09 + `integer_value` [sol@hiqdev.com]
    - [d4f59de] 2015-10-09 + str2bigint/s [sol@hiqdev.com]
    - [43216e5] 2015-10-09 + zref [sol@hiqdev.com]
    - [5f8932c] 2015-10-09 + str2inets, improved str2interval, + `period_from/till` + `to_1` to be used instead of `to_t` + `prepare_replace` for inet[] + `raise_notice` [sol@hiqdev.com]
    - [c33a432] 2015-09-18 + `tie_id_pkey` [sol@hiqdev.com]
    - [3733b6c] 2015-07-20 merged [sol@hiqdev.com]
    - [9aafb65] 2015-07-20 + `email_hash` function [sol@hiqdev.com]
    - [03f0a87] 2015-03-18 merged [andrii.vasyliev@gmail.com]
    - [a4b064f] 2015-03-18 + `ref_after_change_trigger` [andrii.vasyliev@gmail.com]
    - [fde2987] 2015-03-18 + `obj_client_id_idx` [andrii.vasyliev@gmail.com]
    - [3f17082] 2015-03-18 many [andrii.vasyliev@gmail.com]
    - [60ac367] 2015-03-18 + first/last for integer,integer [andrii.vasyliev@gmail.com]
    - [f8d06a4] 2014-10-28 * `is_status`: VOLATILE -> STABLE [andrii.vasyliev@gmail.com]
    - [2060241] 2014-10-27 + `prepare_replace` for macaddr type [fursin.v@gmail.com]
    - [76a60b1] 2014-10-27 + str2macaddr [fursin.v@gmail.com]
    - [1c7e68f] 2014-10-21 * `actualize_migration` [fursin.v@gmail.com]
    - [899d191] 2014-10-21 * `actualize_migration` [fursin.v@gmail.com]
    - [6d3f414] 2014-10-17 + function `get_obj_label`, `get_obj_label` [fursin.v@gmail.com]
    - [ba15f6e] 2014-10-02 + str2integers + `add_ties`, `del_ties` * `set_ties` with use of `add_ties` [andrii.vasyliev@gmail.com]
    - [e374806] 2014-09-19 + ip2int, int2ip functions [andrii.vasyliev@gmail.com]
    - [2e930fe] 2014-09-13 + first/last (integer,text) [andrii.vasyliev@gmail.com]
    - [bd0e170] 2014-09-10 * drop index status [fursin.v@gmail.com]
    - [1aea912] 2014-09-09 * rebuild index (status,value) [fursin.v@gmail.com]
    - [6397a9b] 2014-09-09 + `lock_table` [fursin.v@gmail.com]
    - [92a9a5b] 2014-09-04 + str2numeric, `get_obj_create/update_time` [andrii.vasyliev@gmail.com]
    - [0816005] 2014-09-03 + `tie_h` [andrii.vasyliev@gmail.com]
    - [5513341] 2014-09-03 redone order [andrii.vasyliev@gmail.com]
    - [3551e9e] 2014-08-28 improved pgsdump.sql [andrii.vasyliev@gmail.com]
    - [bc5f970] 2014-08-28 improved `set_ties` [andrii.vasyliev@gmail.com]
    - [64ef289] 2014-08-20 + `ref_ids` with text + `set_ties` not finished [andrii.vasyliev@gmail.com]
    - [f252bfb] 2014-06-12 `timing_off` [andrii.vasyliev@gmail.com]
    - [1b1aaf6] 2014-06-12 migration [andrii.vasyliev@gmail.com]
    - [7e6768b] 2014-06-04 fixed `prev_month` (timestamp) + `ref_id` (4 x text) + `type_id` (4 x text) [andrii.vasyliev@gmail.com]
    - [7aa726e] 2014-05-26 minor:retab [andrii.vasyliev@gmail.com]
    - [01ef7df] 2014-05-26 fixes for recreateability [andrii.vasyliev@gmail.com]
    - [92a7f78] 2014-05-26 minor:retab [andrii.vasyliev@gmail.com]
    - [17548b2] 2014-05-23 REMOVED change to ahcore because of `client_id` [andrii.vasyliev@gmail.com]
    - [2f39509] 2014-05-19 * `reodb_before_delete_trigger`: delete temporary instanty [andrii.vasyliev@gmail.com]
    - [c53c366] 2014-05-19 + scalar,systempath [andrii.vasyliev@gmail.com]
    - [84204a3] 2014-05-19 renamed `get_obj_full/name` <- `obj_full/name` [andrii.vasyliev@gmail.com]
    - [54d2a8d] 2014-05-19 fixed `prepare_replace` for inet + `collapse_spaces` + str2inet + today + `get_obj_class/_id/state,state_id` [andrii.vasyliev@gmail.com]
    - [decb0ab] 2014-04-24 - blacklist/ed: moved to ahcore [andrii.vasyliev@gmail.com]
    - [bd8848a] 2014-04-24 + str2interval [andrii.vasyliev@gmail.com]
    - [d22ab2a] 2014-04-21 * change functions [andrii.vasyliev@gmail.com]
    - [24a2e28] 2014-04-21 + type,change,api [andrii.vasyliev@gmail.com]
    - [5a4812c] 2014-04-18 BIG * change [andrii.vasyliev@gmail.com]
    - [267b249] 2014-04-11 + 'change' table and everything [andrii.vasyliev@gmail.com]
    - [00caf89] 2014-04-11 minor:restyled [andrii.vasyliev@gmail.com]
    - [fde0ccc] 2014-04-11 minor:restyled [andrii.vasyliev@gmail.com]
    - [838f63e] 2014-04-11 renamed tag2 -> tie [andrii.vasyliev@gmail.com]
    - [b417636] 2014-04-11 minor:restyled [andrii.vasyliev@gmail.com]
    - [5565ab2] 2014-04-11 minor:retabed [andrii.vasyliev@gmail.com]
    - [52ccb57] 2014-04-11 + reodb/nonobj triggers [andrii.vasyliev@gmail.com]
    - [df276e7] 2014-04-08 + profile class [andrii.vasyliev@gmail.com]
    - [95cc8b7] 2014-04-08 * blacklist -> blacklisted [andrii.vasyliev@gmail.com]
    - [ecf3e4d] 2014-04-08 * tag2 -> tie * renamed blacklist -> blacklisted and redone [andrii.vasyliev@gmail.com]
    - [2aa084e] 2014-04-08 * `type_ids` [andrii.vasyliev@gmail.com]
    - [442ee5c] 2014-04-07 * renamed tag2 -> tie + profile functions: profile_id,new/set_profile + date/monthdiff functions for renew_expires [andrii.vasyliev@gmail.com]
    - [ca69d1a] 2014-03-13 + reodb triggers [andrii.vasyliev@gmail.com]
    - [3007d2f] 2014-02-28 + shorten + type_ids + get_param + class_tag_id [andrii.vasyliev@gmail.com]
    - [1f66905] 2014-01-18 + next_year, ref_parent_id, prev_state_id, is_status fixed prop_id: + limit 1 [andrii.vasyliev@gmail.com]
    - [b4b9659] 2014-01-18 improved prop_h view [andrii.vasyliev@gmail.com]
    - [31ce45e] 2013-12-24 + FIRST/LAST timestamp,text [andrii.vasyliev@gmail.com]
    - [1a2cabe] 2013-10-11 CHANGED set_status to reset <- add [andrii.vasyliev@gmail.com]
    - [0a07dcc] 2013-10-04 + onetime password + to_epoch [andrii.vasyliev@gmail.com]
    - [59be1d2] 2013-09-26 improved obj_id functions: suppress exception [andrii.vasyliev@gmail.com]
    - [29fb59d] 2013-09-26 minor:spacing [andrii.vasyliev@gmail.com]
    - [cf944d9] 2013-09-05 fixed set_value functions [andrii.vasyliev@gmail.com]
    - [2d644aa] 2013-07-22 improved state_ids to return array which is faster in further work [andrii.vasyliev@gmail.com]
    - [82790dc] 2013-04-19 + first/last for integer,text [andrii.vasyliev@gmail.com]
    - [90fb348] 2013-04-09 merged conflicts [andrii.vasyliev@gmail.com]
    - [dd6e263] 2013-04-09 + integer_value table [andrii.vasyliev@gmail.com]
    - [ce17414] 2013-04-09 + odb_mark_deleted_trigger + odb_forbid_delete_trigger [andrii.vasyliev@gmail.com]
    - [a391bcb] 2013-04-09 renamed to last <- latest [andrii.vasyliev@gmail.com]
    - [ee0c7e2] 2013-04-09 improved csvit: + dbname arg [andrii.vasyliev@gmail.com]
    - [e2b2f66] 2013-04-09 + safe_execute + smart_str2num + set_integer_value + set_uniq_tag2 [andrii.vasyliev@gmail.com]
    - [b099cc6] 2013-04-09 + str2int + state_ids [andrii.vasyliev@gmail.com]
    - [68fd309] 2013-04-09 + first [andrii.vasyliev@gmail.com]
    - [8304004] 2013-02-08 + first/last [andrii.vasyliev@gmail.com]
    - [481a9f9] 2013-02-08 + ref_in, state_ids improved set_status [andrii.vasyliev@gmail.com]
    - [e1f7a34] 2012-12-17 + abs(interval) + short_interval + this_month + next_month + ref_page_id ??? [andrii.vasyliev@gmail.com]
    - [b9fbb1f] 2012-12-17 renamed: latest->last + last (integer,integer) [andrii.vasyliev@gmail.com]
    - [d23d9a1] 2012-10-24 +get_props_values fn [telran.aka.lp@gmail.com]
    - [987c842] 2012-09-18 + inc_years(time,years double precision) + age_since_new_year + top_ref_id (2 args) [andrii.vasyliev@gmail.com]
    - [10ca35a] 2012-09-18 - wrong_login,log,log_var [andrii.vasyliev@gmail.com]
    - [3713aa0] 2012-09-10 improved status functions: get/has/check * add_errors for array input other minor [andrii.vasyliev@gmail.com]
    - [666666c] 2012-09-10 + errors [andrii.vasyliev@gmail.com]
    - [9d3549b] 2012-08-15 +set_tag2 fns [telran.aka.lp@gmail.com]
    - [1d3f962] 2012-07-27 + pgsdump/pgsdiff [andrii.vasyliev@gmail.com]
    - [0af1dc0] 2012-07-27 fixed value_prop_id_fkey ON DELETE CASCADE -> RESTRICT [andrii.vasyliev@gmail.com]
    - [ca98258] 2012-07-27 + str2int * increase/decrease_years -> inc/dec_years + pg_typename [andrii.vasyliev@gmail.com]
    - [e04d422] 2012-07-02 fixes [telran.aka.lp@gmail.com]
    - [773e6dd] 2012-06-21 merged [telran.aka.lp@gmail.com]
    - [142a96e] 2012-06-21 prepare_replace with fourth argument [telran.aka.lp@gmail.com]
    - [f69a9af] 2012-06-21 + sub_ref_id, ref_pname [andrii.vasyliev@gmail.com]
    - [f93efd1] 2012-06-18 + ignore translit o,so files [andrii.vasyliev@gmail.com]
    - [1c59012] 2012-06-18 improved statusz type showing [andrii.vasyliev@gmail.com]
    - [9f52531] 2012-06-18 + error branch [andrii.vasyliev@gmail.com]
    - [2951343] 2012-06-18 + csvit [andrii.vasyliev@gmail.com]
    - [6800c9f] 2012-06-11 + ERROR functions [andrii.vasyliev@gmail.com]
    - [e652c6d] 2012-06-07 + fPIC [andrii.vasyliev@gmail.com]
    - [4a0c530] 2012-06-07 + many functions and improvements [andrii.vasyliev@gmail.com]
    - [2a334c4] 2012-04-23 + translit [andrii.vasyliev@gmail.com]
    - [5ef655b] 2012-04-11 + extend_years fixed get_value usage [andrii.vasyliev@gmail.com]
    - [23279e8] 2012-04-03 improved get_value funcs: - get_XXX_value (obj_id,clas,prop) [andrii.vasyliev@gmail.com]
    - [9923fc4] 2012-04-03 improved update_time_trigger: let change update_time [andrii.vasyliev@gmail.com]
    - [e8476a4] 2012-03-30 + prepare_replace (inet) improved get_value funcs removed get_text_value functions [andrii.vasyliev@gmail.com]
    - [fe69827] 2012-03-28 improved statusz [andrii.vasyliev@gmail.com]
    - [292cde9] 2012-03-26 + cjoin (integer) [andrii.vasyliev@gmail.com]
    - [0283baa] 2012-03-26 + paramz view [andrii.vasyliev@gmail.com]
    - [ab8801f] 2012-03-26 + class,param [andrii.vasyliev@gmail.com]
    - [1812287] 2012-03-26 + get/check_status + param functions [andrii.vasyliev@gmail.com]
    - [2d04f79] 2012-03-26 fixed status_type_id_object_id_uniq [andrii.vasyliev@gmail.com]
    - [1c68ee5] 2012-01-19 improved `old_` table and trigger [andrii.vasyliev@gmail.com]
    - [d8275e1] 2012-01-19 + str2inet [andrii.vasyliev@gmail.com]
    - [aaba758] 2011-12-21 * all IDs bigint -> integer + sequences [andrii.vasyliev@gmail.com]
    - [f3b890e] 2011-11-09 improved status [andrii.vasyliev@gmail.com]
    - [11c5b0a] 2011-07-27 fixed pg_diff [andrii.vasyliev@gmail.com]
    - [eda9b17] 2011-06-02 * set_ref: - 0 default for no [andrii.vasyliev@gmail.com]
    - [5b7dacc] 2011-06-02 improved value triggers [andrii.vasyliev@gmail.com]
    - [48e248f] 2011-06-02 * prop:insert/update/delete_trigger [andrii.vasyliev@gmail.com]
    - [a356897] 2011-06-02 improved ref_h [andrii.vasyliev@gmail.com]
    - [5c34a4e] 2011-06-02 * ref: no can be null, no default [andrii.vasyliev@gmail.com]
    - [f271d8b] 2011-06-02 renamed genpass->passgen + password/crypt functions: crypt,gen_salt,is_crypted,check_password,crypt_password + to_date/time_usa improved set_ref to save label,descr into ref table + set_tag (bigint,text) [andrii.vasyliev@gmail.com]
    - [80b8cfa] 2011-06-02 * ref: + label,descr improved prop: trigger info moved from table to props [andrii.vasyliev@gmail.com]
    - [8c748e2] 2010-11-23 many improvements about is_t/n/s/r -> is_in_table and so on [andrii.vasyliev@gmail.com]
    - [c3fc18f] 2010-10-14 ! * integer -> bigint: now do_all works witout errors [andrii.vasyliev@gmail.com]
    - [6b57a34] 2010-10-14 + ignore vim temporary files: `.*.swp` [andrii.vasyliev@gmail.com]
    - [36b04c3] 2010-10-13 ! * integer -> bigint + status [andrii.vasyliev@gmail.com]
    - [168902f] 2010-10-13 + tag2,status [andrii.vasyliev@gmail.com]
    - [0ad38c8] 2010-10-13 + domains [andrii.vasyliev@gmail.com]
    - [3931429] 2010-10-13 + o.label [andrii.vasyliev@gmail.com]
    - [be988d2] 2010-09-09 * prop_h: * def -> '' [andrii.vasyliev@gmail.com]
    - [71ad7de] 2010-09-09 + hidden [andrii.vasyliev@gmail.com]
    - [ec9091a] 2010-09-08 + old_value [andrii.vasyliev@gmail.com]
    - [782a799] 2010-09-08 + prop:save_history,separator [andrii.vasyliev@gmail.com]
    - [8e06203] 2010-09-08 many [andrii.vasyliev@gmail.com]
    - [b82c796] 2010-03-04 + sjoin [andrii.vasyliev@gmail.com]
    - [99a58c8] 2010-02-26 + more nonempty functions [andrii.vasyliev@gmail.com]
    - [47e9f71] 2010-02-26 + prop:readonly,admin_only,owner_only,disabled [andrii.vasyliev@gmail.com]
    - [0b4a726] 2009-10-26 renamed: input_additional_html -> comment [andrii.vasyliev@gmail.com]
    - [136b6fa] 2009-10-09 + latest [andrii.vasyliev@gmail.com]
    - [6db2126] 2009-10-09 + status functions + set_value(integer,text,integer) [andrii.vasyliev@gmail.com]
    - [fe325d3] 2009-10-09 + status [andrii.vasyliev@gmail.com]
    - [8eafc7c] 2009-09-25 + nonempty(3args) [andrii.vasyliev@gmail.com]
    - [253c450] 2009-05-22 + simple genpass [andrii.vasyliev@gmail.com]
    - [d220fed] 2009-04-01 + order [andrii.vasyliev@gmail.com]
    - [f2dd7df] 2009-04-01 + blacklist [andrii.vasyliev@gmail.com]
    - [53e6c22] 2009-04-01 + tag2, blacklist [andrii.vasyliev@gmail.com]
    - [1e81926] 2009-04-01 + prepare_replace * set_prop user prepare_replace improved set_ref + tag_id [andrii.vasyliev@gmail.com]
    - [ab50706] 2009-04-01 + blacklist, wrong_login, log, log_var, tag2, user_value [andrii.vasyliev@gmail.com]
    - [dc6e5ed] 2009-04-01 + user_value, blacklist, log [andrii.vasyliev@gmail.com]
    - [4f2d35a] 2009-04-01 + tag tree + nets scalar + prop:asterisk, prop:input_additional_html + priorities, grades [andrii.vasyliev@gmail.com]
    - [5a407ff] 2008-12-01 + prev_month [andrii.vasyliev@gmail.com]
    - [3f2f365] 2008-12-01 + aggregate [andrii.vasyliev@gmail.com]
    - [c2adea3] 2008-11-10 inited [andrii.vasyliev@gmail.com]

## [Development started] - 2008-11-10

[4a05785]: https://github.com/hiqdev/reodb/commit/4a05785
[d3867de]: https://github.com/hiqdev/reodb/commit/d3867de
[a3f1971]: https://github.com/hiqdev/reodb/commit/a3f1971
[becb9c6]: https://github.com/hiqdev/reodb/commit/becb9c6
[c2aa079]: https://github.com/hiqdev/reodb/commit/c2aa079
[88ac62d]: https://github.com/hiqdev/reodb/commit/88ac62d
[8873506]: https://github.com/hiqdev/reodb/commit/8873506
[9ebe2a9]: https://github.com/hiqdev/reodb/commit/9ebe2a9
[1810fba]: https://github.com/hiqdev/reodb/commit/1810fba
[4bc7d54]: https://github.com/hiqdev/reodb/commit/4bc7d54
[bec8b17]: https://github.com/hiqdev/reodb/commit/bec8b17
[6d3a5cc]: https://github.com/hiqdev/reodb/commit/6d3a5cc
[bb793c7]: https://github.com/hiqdev/reodb/commit/bb793c7
[3e41575]: https://github.com/hiqdev/reodb/commit/3e41575
[d4f59de]: https://github.com/hiqdev/reodb/commit/d4f59de
[43216e5]: https://github.com/hiqdev/reodb/commit/43216e5
[5f8932c]: https://github.com/hiqdev/reodb/commit/5f8932c
[c33a432]: https://github.com/hiqdev/reodb/commit/c33a432
[3733b6c]: https://github.com/hiqdev/reodb/commit/3733b6c
[9aafb65]: https://github.com/hiqdev/reodb/commit/9aafb65
[03f0a87]: https://github.com/hiqdev/reodb/commit/03f0a87
[a4b064f]: https://github.com/hiqdev/reodb/commit/a4b064f
[fde2987]: https://github.com/hiqdev/reodb/commit/fde2987
[3f17082]: https://github.com/hiqdev/reodb/commit/3f17082
[60ac367]: https://github.com/hiqdev/reodb/commit/60ac367
[f8d06a4]: https://github.com/hiqdev/reodb/commit/f8d06a4
[2060241]: https://github.com/hiqdev/reodb/commit/2060241
[76a60b1]: https://github.com/hiqdev/reodb/commit/76a60b1
[1c7e68f]: https://github.com/hiqdev/reodb/commit/1c7e68f
[899d191]: https://github.com/hiqdev/reodb/commit/899d191
[6d3f414]: https://github.com/hiqdev/reodb/commit/6d3f414
[ba15f6e]: https://github.com/hiqdev/reodb/commit/ba15f6e
[e374806]: https://github.com/hiqdev/reodb/commit/e374806
[2e930fe]: https://github.com/hiqdev/reodb/commit/2e930fe
[bd0e170]: https://github.com/hiqdev/reodb/commit/bd0e170
[1aea912]: https://github.com/hiqdev/reodb/commit/1aea912
[6397a9b]: https://github.com/hiqdev/reodb/commit/6397a9b
[92a9a5b]: https://github.com/hiqdev/reodb/commit/92a9a5b
[0816005]: https://github.com/hiqdev/reodb/commit/0816005
[5513341]: https://github.com/hiqdev/reodb/commit/5513341
[3551e9e]: https://github.com/hiqdev/reodb/commit/3551e9e
[bc5f970]: https://github.com/hiqdev/reodb/commit/bc5f970
[64ef289]: https://github.com/hiqdev/reodb/commit/64ef289
[f252bfb]: https://github.com/hiqdev/reodb/commit/f252bfb
[1b1aaf6]: https://github.com/hiqdev/reodb/commit/1b1aaf6
[7e6768b]: https://github.com/hiqdev/reodb/commit/7e6768b
[7aa726e]: https://github.com/hiqdev/reodb/commit/7aa726e
[01ef7df]: https://github.com/hiqdev/reodb/commit/01ef7df
[92a7f78]: https://github.com/hiqdev/reodb/commit/92a7f78
[17548b2]: https://github.com/hiqdev/reodb/commit/17548b2
[2f39509]: https://github.com/hiqdev/reodb/commit/2f39509
[c53c366]: https://github.com/hiqdev/reodb/commit/c53c366
[84204a3]: https://github.com/hiqdev/reodb/commit/84204a3
[54d2a8d]: https://github.com/hiqdev/reodb/commit/54d2a8d
[decb0ab]: https://github.com/hiqdev/reodb/commit/decb0ab
[bd8848a]: https://github.com/hiqdev/reodb/commit/bd8848a
[d22ab2a]: https://github.com/hiqdev/reodb/commit/d22ab2a
[24a2e28]: https://github.com/hiqdev/reodb/commit/24a2e28
[5a4812c]: https://github.com/hiqdev/reodb/commit/5a4812c
[267b249]: https://github.com/hiqdev/reodb/commit/267b249
[00caf89]: https://github.com/hiqdev/reodb/commit/00caf89
[fde0ccc]: https://github.com/hiqdev/reodb/commit/fde0ccc
[838f63e]: https://github.com/hiqdev/reodb/commit/838f63e
[b417636]: https://github.com/hiqdev/reodb/commit/b417636
[5565ab2]: https://github.com/hiqdev/reodb/commit/5565ab2
[52ccb57]: https://github.com/hiqdev/reodb/commit/52ccb57
[df276e7]: https://github.com/hiqdev/reodb/commit/df276e7
[95cc8b7]: https://github.com/hiqdev/reodb/commit/95cc8b7
[ecf3e4d]: https://github.com/hiqdev/reodb/commit/ecf3e4d
[2aa084e]: https://github.com/hiqdev/reodb/commit/2aa084e
[442ee5c]: https://github.com/hiqdev/reodb/commit/442ee5c
[ca69d1a]: https://github.com/hiqdev/reodb/commit/ca69d1a
[3007d2f]: https://github.com/hiqdev/reodb/commit/3007d2f
[1f66905]: https://github.com/hiqdev/reodb/commit/1f66905
[b4b9659]: https://github.com/hiqdev/reodb/commit/b4b9659
[31ce45e]: https://github.com/hiqdev/reodb/commit/31ce45e
[1a2cabe]: https://github.com/hiqdev/reodb/commit/1a2cabe
[0a07dcc]: https://github.com/hiqdev/reodb/commit/0a07dcc
[59be1d2]: https://github.com/hiqdev/reodb/commit/59be1d2
[29fb59d]: https://github.com/hiqdev/reodb/commit/29fb59d
[cf944d9]: https://github.com/hiqdev/reodb/commit/cf944d9
[2d644aa]: https://github.com/hiqdev/reodb/commit/2d644aa
[82790dc]: https://github.com/hiqdev/reodb/commit/82790dc
[90fb348]: https://github.com/hiqdev/reodb/commit/90fb348
[dd6e263]: https://github.com/hiqdev/reodb/commit/dd6e263
[ce17414]: https://github.com/hiqdev/reodb/commit/ce17414
[a391bcb]: https://github.com/hiqdev/reodb/commit/a391bcb
[ee0c7e2]: https://github.com/hiqdev/reodb/commit/ee0c7e2
[e2b2f66]: https://github.com/hiqdev/reodb/commit/e2b2f66
[b099cc6]: https://github.com/hiqdev/reodb/commit/b099cc6
[68fd309]: https://github.com/hiqdev/reodb/commit/68fd309
[8304004]: https://github.com/hiqdev/reodb/commit/8304004
[481a9f9]: https://github.com/hiqdev/reodb/commit/481a9f9
[e1f7a34]: https://github.com/hiqdev/reodb/commit/e1f7a34
[b9fbb1f]: https://github.com/hiqdev/reodb/commit/b9fbb1f
[d23d9a1]: https://github.com/hiqdev/reodb/commit/d23d9a1
[987c842]: https://github.com/hiqdev/reodb/commit/987c842
[10ca35a]: https://github.com/hiqdev/reodb/commit/10ca35a
[3713aa0]: https://github.com/hiqdev/reodb/commit/3713aa0
[666666c]: https://github.com/hiqdev/reodb/commit/666666c
[9d3549b]: https://github.com/hiqdev/reodb/commit/9d3549b
[1d3f962]: https://github.com/hiqdev/reodb/commit/1d3f962
[0af1dc0]: https://github.com/hiqdev/reodb/commit/0af1dc0
[ca98258]: https://github.com/hiqdev/reodb/commit/ca98258
[e04d422]: https://github.com/hiqdev/reodb/commit/e04d422
[773e6dd]: https://github.com/hiqdev/reodb/commit/773e6dd
[142a96e]: https://github.com/hiqdev/reodb/commit/142a96e
[f69a9af]: https://github.com/hiqdev/reodb/commit/f69a9af
[f93efd1]: https://github.com/hiqdev/reodb/commit/f93efd1
[1c59012]: https://github.com/hiqdev/reodb/commit/1c59012
[9f52531]: https://github.com/hiqdev/reodb/commit/9f52531
[2951343]: https://github.com/hiqdev/reodb/commit/2951343
[6800c9f]: https://github.com/hiqdev/reodb/commit/6800c9f
[e652c6d]: https://github.com/hiqdev/reodb/commit/e652c6d
[4a0c530]: https://github.com/hiqdev/reodb/commit/4a0c530
[2a334c4]: https://github.com/hiqdev/reodb/commit/2a334c4
[5ef655b]: https://github.com/hiqdev/reodb/commit/5ef655b
[23279e8]: https://github.com/hiqdev/reodb/commit/23279e8
[9923fc4]: https://github.com/hiqdev/reodb/commit/9923fc4
[e8476a4]: https://github.com/hiqdev/reodb/commit/e8476a4
[fe69827]: https://github.com/hiqdev/reodb/commit/fe69827
[292cde9]: https://github.com/hiqdev/reodb/commit/292cde9
[0283baa]: https://github.com/hiqdev/reodb/commit/0283baa
[ab8801f]: https://github.com/hiqdev/reodb/commit/ab8801f
[1812287]: https://github.com/hiqdev/reodb/commit/1812287
[2d04f79]: https://github.com/hiqdev/reodb/commit/2d04f79
[1c68ee5]: https://github.com/hiqdev/reodb/commit/1c68ee5
[d8275e1]: https://github.com/hiqdev/reodb/commit/d8275e1
[aaba758]: https://github.com/hiqdev/reodb/commit/aaba758
[f3b890e]: https://github.com/hiqdev/reodb/commit/f3b890e
[11c5b0a]: https://github.com/hiqdev/reodb/commit/11c5b0a
[eda9b17]: https://github.com/hiqdev/reodb/commit/eda9b17
[5b7dacc]: https://github.com/hiqdev/reodb/commit/5b7dacc
[48e248f]: https://github.com/hiqdev/reodb/commit/48e248f
[a356897]: https://github.com/hiqdev/reodb/commit/a356897
[5c34a4e]: https://github.com/hiqdev/reodb/commit/5c34a4e
[f271d8b]: https://github.com/hiqdev/reodb/commit/f271d8b
[80b8cfa]: https://github.com/hiqdev/reodb/commit/80b8cfa
[8c748e2]: https://github.com/hiqdev/reodb/commit/8c748e2
[c3fc18f]: https://github.com/hiqdev/reodb/commit/c3fc18f
[6b57a34]: https://github.com/hiqdev/reodb/commit/6b57a34
[36b04c3]: https://github.com/hiqdev/reodb/commit/36b04c3
[168902f]: https://github.com/hiqdev/reodb/commit/168902f
[0ad38c8]: https://github.com/hiqdev/reodb/commit/0ad38c8
[3931429]: https://github.com/hiqdev/reodb/commit/3931429
[be988d2]: https://github.com/hiqdev/reodb/commit/be988d2
[71ad7de]: https://github.com/hiqdev/reodb/commit/71ad7de
[ec9091a]: https://github.com/hiqdev/reodb/commit/ec9091a
[782a799]: https://github.com/hiqdev/reodb/commit/782a799
[8e06203]: https://github.com/hiqdev/reodb/commit/8e06203
[b82c796]: https://github.com/hiqdev/reodb/commit/b82c796
[99a58c8]: https://github.com/hiqdev/reodb/commit/99a58c8
[47e9f71]: https://github.com/hiqdev/reodb/commit/47e9f71
[0b4a726]: https://github.com/hiqdev/reodb/commit/0b4a726
[136b6fa]: https://github.com/hiqdev/reodb/commit/136b6fa
[6db2126]: https://github.com/hiqdev/reodb/commit/6db2126
[fe325d3]: https://github.com/hiqdev/reodb/commit/fe325d3
[8eafc7c]: https://github.com/hiqdev/reodb/commit/8eafc7c
[253c450]: https://github.com/hiqdev/reodb/commit/253c450
[d220fed]: https://github.com/hiqdev/reodb/commit/d220fed
[f2dd7df]: https://github.com/hiqdev/reodb/commit/f2dd7df
[53e6c22]: https://github.com/hiqdev/reodb/commit/53e6c22
[1e81926]: https://github.com/hiqdev/reodb/commit/1e81926
[ab50706]: https://github.com/hiqdev/reodb/commit/ab50706
[dc6e5ed]: https://github.com/hiqdev/reodb/commit/dc6e5ed
[4f2d35a]: https://github.com/hiqdev/reodb/commit/4f2d35a
[5a407ff]: https://github.com/hiqdev/reodb/commit/5a407ff
[3f2f365]: https://github.com/hiqdev/reodb/commit/3f2f365
[c2adea3]: https://github.com/hiqdev/reodb/commit/c2adea3
[f948529]: https://github.com/hiqdev/reodb/commit/f948529
[abd394a]: https://github.com/hiqdev/reodb/commit/abd394a
[8b1a60a]: https://github.com/hiqdev/reodb/commit/8b1a60a
[e3fc46b]: https://github.com/hiqdev/reodb/commit/e3fc46b
[ac97406]: https://github.com/hiqdev/reodb/commit/ac97406
[7127d41]: https://github.com/hiqdev/reodb/commit/7127d41
[81814f7]: https://github.com/hiqdev/reodb/commit/81814f7
[ca44469]: https://github.com/hiqdev/reodb/commit/ca44469
[53458d2]: https://github.com/hiqdev/reodb/commit/53458d2
[9806d42]: https://github.com/hiqdev/reodb/commit/9806d42
[aaffda5]: https://github.com/hiqdev/reodb/commit/aaffda5
[a6128ba]: https://github.com/hiqdev/reodb/commit/a6128ba
[f20c27d]: https://github.com/hiqdev/reodb/commit/f20c27d
[41ddfde]: https://github.com/hiqdev/reodb/commit/41ddfde
[c083045]: https://github.com/hiqdev/reodb/commit/c083045
[Under development]: https://github.com/hiqdev/reodb/releases
