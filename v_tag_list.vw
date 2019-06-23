create or replace force view parus.v_tag_list as
select "RN","CODE","NOTE" from TAG_LIST t;
grant select on PARUS.V_TAG_LIST to PUBLIC;


