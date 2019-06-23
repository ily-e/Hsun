create or replace force view parus.v_benefit_sum_conditions as
select c."RN",c."RN_BENEFIT_SUM",c."RN_TAG",c."COND_DATE",c."COND_NUMB",c."COND_STR",c."COND_SIGN", t.code, t.note from BENEFIT_SUM_CONDITIONS c, tag_list t
where c.rn_tag=t.rn;
grant select on PARUS.V_BENEFIT_SUM_CONDITIONS to PUBLIC;


