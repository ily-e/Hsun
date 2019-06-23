create or replace procedure parus.p_family_type_delete(nrn          in number) as
begin

  delete family_type
   where rn = nrn;
  

end;
/

