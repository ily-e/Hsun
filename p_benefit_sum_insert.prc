create or replace procedure parus.p_benefit_sum_insert(code_b   in number,
                                                 i_sum_b  in number,
                                                 i_date_f in date,
                                                 i_date_t in date,
                                                 o_id out number) as
numb_ number(17);
i_rn_b number(17);
begin
select nvl(max(bs.num_bs),0)+1 into numb_ from benefit_sum bs;
  o_id := gen_idd;
  p_get_benefit_type_id(0,code_b,i_rn_b);
  insert into benefit_sum
    (rn, rn_b, sum_b, date_f, date_t, num_bs)
  values
    (o_id, i_rn_b, i_sum_b, i_date_f, i_date_t, numb_);

end;
/

