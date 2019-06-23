create or replace procedure parus.p_benefit_type_delete(i_rn      in number) as
begin

  delete benefit_type
   where rn = i_rn;

end;
/

