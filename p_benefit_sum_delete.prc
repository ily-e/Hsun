create or replace procedure parus.p_benefit_sum_delete(i_rn      in number) as
begin

  delete benefit_sum
   where rn = i_rn;
 
end;
/

