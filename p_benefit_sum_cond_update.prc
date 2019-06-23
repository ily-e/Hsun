create or replace procedure parus.p_benefit_sum_cond_update(i_rn             in number,
                                                      numb_benefit_sum in number,
                                                      code_tag         in varchar2,
                                                      i_cond_date      in date,
                                                      i_cond_numb      in number,
                                                      i_cond_str       in varchar2,
                                                      i_cond_sign      in varchar2) as
i_rn_tag number(17);
i_rn_benefit_sum number(17);
begin
  p_get_tag_id(0,code_tag,i_rn_tag);
  p_get_tagbenefit_sum_id(0,numb_benefit_sum,i_rn_benefit_sum);
  update benefit_sum_conditions
     set rn_benefit_sum = i_rn_benefit_sum,
         rn_tag         = i_rn_tag,
         cond_date      = i_cond_date,
         cond_numb      = i_cond_numb,
         cond_str       = i_cond_str,
         cond_sign      = i_cond_sign
   where rn = i_rn;

end;
/

