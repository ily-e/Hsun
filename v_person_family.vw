create or replace force view parus.v_person_family as
select t.rn            nrn,
       t.first_person  nfirst_person,
       t.second_person nsecond_person,
       p.agn_f,
       p.agn_i,
       p.agn_o,
       p.agnburn,
       t.family_type   nfamily_type,
       f.code sfamily_type,
       p.inn
  from PERSON_FAMILY t, person p, family_type f
 where t.second_person = p.rn
   and t.family_type = f.rn;
grant select on PARUS.V_PERSON_FAMILY to PUBLIC;


