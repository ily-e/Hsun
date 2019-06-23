create or replace procedure parus.p_person_update(nrn      in number,
                                            i_agn_f   in varchar2,
                                            i_agn_i   in varchar2,
                                            i_agn_o   in varchar2,
                                            i_agnburn in date,
                                            i_snils   in number,
                                            i_inn     in number,
                                            i_sex     in number) as
begin

  update person
     set agn_f   = i_agn_f,
         agn_i   = i_agn_i,
         agn_o   = i_agn_o,
         agnburn = i_agnburn,
         snils   = i_snils,
         inn     = i_inn,
         sex     = i_sex
   where rn = nrn;

end;
/

