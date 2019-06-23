create or replace function parus.calc_eval(i_a    in number,
                                     i_b    in number,
                                     i_sign in varchar2) return number as
begin

case i_sign
  when '=' then if i_a = i_b then return 1; else return 0; end if;
  when '<' then if i_a < i_b then return 1; else return 0; end if;
  when '>' then if i_a > i_b then return 1; else return 0; end if;
  when '<=' then if i_a <= i_b then return 1; else return 0; end if;
  when '>=' then if i_a >= i_b then return 1; else return 0; end if;
  else return 0;
  end case;


end;
/

