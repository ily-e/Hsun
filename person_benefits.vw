create or replace force view parus.person_benefits as
select rownum rn,
       p.nrn person_rn,
       p.sagn_f,
       p.sagn_i,
       p.sagn_o,
       p.dagn_burn,
       p.ssnils,
       p.ninn,
       p.nsex,
       p.age,
       p.dohod,
       p.count_document,
       bft.benefit_name,
       bft.rn benefit_rn,
       bft.period_,
       bs.sum_b,
       bs.rn benefit_sum_rn,
       (select decode(count(0),0,bs.sum_b,0) from PERSON_BENEFITS_RES r where r.prn = p.nrn and r.benefits_sum = bs.rn) need_benefit
  from v_person p, benefit_sum bs, benefit_type bft
 where 1 = udo_get_eval_pdoc_benefit(p.nrn, bs.rn)
   and bs.rn_b = bft.rn;
grant select on PARUS.PERSON_BENEFITS to PUBLIC;


