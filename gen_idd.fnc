create or replace function parus.gen_idd return number as
  id number;
begin
  select h_id.nextval into id from dual;
  return id;
end;
/

