create or replace function parus.UDO_F_TYPE_BENEFIT_RES_KOL(nrn in number) return integer is
  Res integer;
begin
  select count(0) into res from PERSON_BENEFITS_RES s, benefit_sum t 
  where s.benefits_sum=t.rn
  and t.rn_b=nrn;
  return(Res);
end UDO_F_TYPE_BENEFIT_RES_KOL;
/
grant execute on PARUS.UDO_F_TYPE_BENEFIT_RES_KOL to PUBLIC;


