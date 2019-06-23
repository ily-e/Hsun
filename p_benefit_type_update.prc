create or replace procedure parus.p_benefit_type_update(i_rn      in number,
                                            i_benefit_name   in varchar2,
                                            i_level_b   in number,
                                            i_region   in number) as
begin
update benefit_type
   set benefit_name = i_benefit_name,
       level_b = i_level_b,
       region = i_region
 where rn = i_rn;
  
end;
/

