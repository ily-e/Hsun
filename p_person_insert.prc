create or replace procedure parus.p_person_insert(i_agn_f   in varchar2,
                                            i_agn_i   in varchar2,
                                            i_agn_o   in varchar2,
                                            i_agnburn in date,
                                            i_snils   in number,
                                            i_inn     in number,
                                            i_sex     in number,
                                            o_id      out number) as
begin

  o_id := gen_idd;

  insert into person
    (rn, agn_f, agn_i, agn_o, agnburn, snils, inn, sex)
  values
    (o_id, i_agn_f, i_agn_i, i_agn_o, i_agnburn, i_snils, i_inn, i_sex);

end;
/

