create or replace procedure parus.p_family_type_insert(i_code        in varchar2,
                                                 i_rcode        in varchar2,
                                                 o_id          out number) as
  famity_type_id number := null;
begin
  o_id := gen_idd;

  insert into family_type
    (rn, code, rcode)
  values
    (o_id, i_code, i_rcode);

end;
/

