create or replace procedure parus.p_get_person_id_by_snils(i_show_err in number,
                                                     i_snils    in number,
                                                     o_id       out number) as
begin

  select p.rn into o_id from person p where p.snils = i_snils;

exception
  when no_data_found then
    if i_show_err = 1 then
      raise_application_error(-20001,
                              'Не найдена персона со СНИЛС: ' ||
                              nvl(to_char(i_snils), '<null>'));
    else
      o_id := null;
    end if;
end;
/

