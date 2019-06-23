create or replace procedure parus.p_benefit_sum_cond_delete(i_rn      in number) as
begin

  delete BENEFIT_SUM_CONDITIONS
   where rn = i_rn;
 
end;
/

