create or replace procedure parus.p_benefit_sum_update(i_rn      in number,
                                           i_sum_b   in number,
                                            i_date_f   in date,
                                            i_date_t   in date) as
begin
update benefit_sum
   set sum_b = i_sum_b,
       date_f = i_date_f,
       date_t = i_date_t
 where rn = i_rn;
  
end;
/

