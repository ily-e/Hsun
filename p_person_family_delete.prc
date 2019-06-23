create or replace procedure parus.p_person_family_delete(nrn in number) as
  v_second_person person.rn%type;
  v_family_type   family_type.rn%type;
begin

  delete from PERSON_FAMILY f
   where (f.first_person, f.family_type) in
         (select t.second_person, fft.rn
            from PERSON_FAMILY t, family_type ft, family_type fft
           where t.rn = nrn
             and t.family_type = ft.rn
             and ft.code = fft.rcode);

  delete person_family where rn = nrn;

end;
/
grant execute on PARUS.P_PERSON_FAMILY_DELETE to PUBLIC;


