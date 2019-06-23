create or replace procedure parus.p_family_type_update(nrn          in number,
                                                 i_code        in varchar2,
                                                 i_rcode        in varchar2) as
  famity_type_id number := null;
begin

  update family_type
     set code = i_code,
         rcode = i_rcode
   where rn = nrn;
  

end;
/

