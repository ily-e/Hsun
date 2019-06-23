create or replace function parus.UDO_F_TYPE_BENEFIT_RES_SUM(nrn in number) return number is
  Res number;
begin
  select sum(s.summ) into res from PERSON_BENEFITS_RES s, benefit_sum t 
  where s.benefits_sum=t.rn
  and t.rn_b=nrn;
  return(Res);
end UDO_F_TYPE_BENEFIT_RES_SUM;
/
grant execute on PARUS.UDO_F_TYPE_BENEFIT_RES_SUM to PUBLIC;


