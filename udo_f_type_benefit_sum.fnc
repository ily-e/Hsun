create or replace function parus.UDO_F_TYPE_BENEFIT_SUM(nrn in number) return number is
  Res number;
begin
  select sum(s.sum_b) into res from PERSON_BENEFITS s where s.benefit_rn=nrn;
  return(Res);
end UDO_F_TYPE_BENEFIT_SUM;
/
grant execute on PARUS.UDO_F_TYPE_BENEFIT_SUM to PUBLIC;


