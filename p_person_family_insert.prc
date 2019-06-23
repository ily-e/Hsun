create or replace procedure parus.p_person_family_insert(i_first_person_id   in number,
                                                   i_second_person_inn in number,
                                                   i_family_type       in varchar2) as
  v_second_person person.rn%type;
  v_family_type   family_type.rn%type;
  v_family_rtype  family_type.rn%type;
begin

  p_get_person_id_by_inn(i_show_err => 0,
                         i_inn      => i_second_person_inn,
                         o_id       => v_second_person);

  p_get_family_type_id(i_show_err => 0,
                       i_code     => i_family_type,
                       o_id       => v_family_type);
  p_get_family_type_idz(i_show_err => 0,
                        i_code     => i_family_type,
                        o_id       => v_family_rtype);

  insert into person_family
    (rn, first_person, second_person, family_type)
  values
    (gen_idd, i_first_person_id, v_second_person, v_family_type);

  insert into person_family
    (rn, first_person, second_person, family_type)
  values
    (gen_idd, v_second_person, i_first_person_id, v_family_rtype);

end;
/
grant execute on PARUS.P_PERSON_FAMILY_INSERT to PUBLIC;


