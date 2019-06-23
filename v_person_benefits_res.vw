create or replace force view parus.v_person_benefits_res as
select t.rn,t.prn, t.benefits_sum, b.benefit_name, t.summ, s.sum_b from PERSON_BENEFITS_RES t, benefit_sum s, benefit_type b
where t.benefits_sum = s.rn
and s.rn_b = b.rn;
grant select on PARUS.V_PERSON_BENEFITS_RES to PUBLIC;


