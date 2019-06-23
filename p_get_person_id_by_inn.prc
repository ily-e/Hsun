create or replace procedure parus.p_get_person_id_by_inn(i_show_err in number,
                                                   i_inn      in number,
                                                   o_id       out number) as
begin

  select p.rn into o_id from person p where p.inn = i_inn;

exception
  when no_data_found then
    if i_show_err = 1 then
      raise_application_error(-20001,
                              'Не найдена персона с ИНН: ' ||
                              nvl(to_char(i_inn), '<null>'));
    else
      o_id := null;
    end if;
end;
/

