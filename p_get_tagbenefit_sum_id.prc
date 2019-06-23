create or replace procedure parus.p_get_tagbenefit_sum_id(i_show_err in number,
                                                 i_numb     in number,
                                                 o_id       out number) as
  res number;
begin

  select t.rn into o_id from benefit_sum t where t.num_bs = i_numb;
exception
  when no_data_found then
    if i_show_err = 1 then
      raise_application_error(-20001,
                              'Не найдена сумма пособия: ' ||
                              nvl(i_numb, '<null>'));
    else
      o_id := null;
    end if;
end;
/

