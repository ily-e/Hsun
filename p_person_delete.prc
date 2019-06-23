create or replace procedure parus.p_person_delete(nrn      in number) as
begin

  delete person
   where rn = nrn;

end;
/

