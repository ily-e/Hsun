create or replace function parus.UDO_F_PERSON_DOHOD(rn_p in number)
  return number is
  Res        number(15, 2);
  count_f    number(17);
  sum_chel   number(15, 2);
  sum_rod    number(15, 2) := 0;
  count_c number(17);
begin
  select count(0)
    into count_f
    from person_family f
   where (f.first_person = rn_p /*or f.second_person = rn_p*/);
  select nvl(sum(n.summa),0)
    into sum_chel
    from PERSON_NDFL n
   where n.person_rn = rn_p
     and to_date('01.' || lpad(n.ndfl_month,2,'0') ||'.'|| n.ndfl_year, 'dd.mm.yyyy') between
         add_months(trunc(sysdate), -12) and add_months(trunc(sysdate), -1);

  
    select nvl(sum(n.summa),0)
      into sum_rod
      from PERSON_NDFL n
     where n.person_rn in (select f.second_person
              from person_family f
             where f.first_person = rn_p)
       and to_date('01.' || lpad(n.ndfl_month,2,'0') ||'.'|| n.ndfl_year, 'dd.mm.yyyy') between
           add_months(trunc(sysdate), -12) and add_months(trunc(sysdate), -1);
    
 if count_f=0 then count_c:=1;
 else count_c:=count_f+1;
 end if;
  res := (sum_rod + sum_chel) / (count_c*12);
  return(Res);
end UDO_F_PERSON_DOHOD;
/
grant execute on PARUS.UDO_F_PERSON_DOHOD to PUBLIC;


