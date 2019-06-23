create or replace function parus.udo_ily_transpond(rec   in udo_ily_types.gen_curs,
                                                   delim in varchar2)
  return varchar2 as

  in_rec rec%ROWTYPE;
  res    varchar2(4000);
begin

  loop
    FETCH rec
      INTO in_rec;
    EXIT WHEN rec%NOTFOUND;

    res := res || in_rec.rn || delim;

  end loop;
  close rec;
  return substr(res, 1, length(res) - length(delim));
end udo_ily_transpond;
/

