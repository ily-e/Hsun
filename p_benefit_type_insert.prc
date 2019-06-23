create or replace procedure parus.p_benefit_type_insert(i_benefit_name   in varchar2,
                                            i_level_b   in number,
                                            i_region   in number,
                                            o_id      out number) as

begin

  o_id := gen_idd;
insert into benefit_type
  (rn, benefit_name, level_b, region)
values
  (o_id, i_benefit_name, i_level_b, i_region);


end;
/

