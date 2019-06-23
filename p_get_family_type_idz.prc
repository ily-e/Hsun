create or replace procedure parus.p_get_family_type_idz(i_show_err in number,
                                                 i_code     in varchar2,
                                                 o_id       out number) as
  res number;
begin

  select t.rn into o_id from family_type t where t.rcode = i_code;
exception
  when no_data_found then
    if i_show_err = 1 then
      raise_application_error(-20001,
                              'Не найден тип семейных отношений: ' ||
                              nvl(i_code, '<null>'));
    else
      o_id := null;
    end if;
end;
/

