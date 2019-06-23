create or replace procedure parus.p_benefit_sum_cond_insert(numb_benefit_sum in number,
                                                      code_tag         in varchar2,
                                                      i_cond_date      in date,
                                                      i_cond_numb      in number,
                                                      i_cond_str       in varchar2,
                                                      i_cond_sign      in varchar2,                                                       
                                                      o_id             out number) as

i_rn_tag number(17);
i_rn_benefit_sum number(17);
begin

  o_id := gen_idd;
   p_get_tag_id(0,code_tag,i_rn_tag);
  p_get_tagbenefit_sum_id(0,numb_benefit_sum,i_rn_benefit_sum);
  insert into benefit_sum_conditions
    (rn, rn_benefit_sum, rn_tag, cond_date, cond_numb, cond_str, cond_sign)
  values
    (o_id,
     i_rn_benefit_sum,
     i_rn_tag,
     i_cond_date,
     i_cond_numb,
     i_cond_str,
     i_cond_sign);

end;
/
grant execute on PARUS.P_BENEFIT_SUM_COND_INSERT to PUBLIC;


