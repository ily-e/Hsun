create or replace function parus.UDO_F_TYPE_BENEFIT_KOL(nrn in number) return integer is
  Res integer;
begin
  select count(0) into res from PERSON_BENEFITS s where s.benefit_rn=nrn;
  return(Res);
end UDO_F_TYPE_BENEFIT_KOL;
/
grant execute on PARUS.UDO_F_TYPE_BENEFIT_KOL to PUBLIC;


