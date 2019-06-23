create or replace force view parus.v_person_document_value as
select t."RN",
       t."PRN",
       t."TAG_ID",
       l.code tag_code,
       t."VALUE_NUM",
       t."VALUE_STR",
       t."VALUE_DAT",
       nvl(to_char(t.value_num),nvl(t.value_str, to_char(t.value_dat,'dd.mm.yyyy'))) val

  from PERSON_DOCUMENT_VALUE t, tag_list l
  where t.tag_id = l.rn;
grant select on PARUS.V_PERSON_DOCUMENT_VALUE to PUBLIC;


