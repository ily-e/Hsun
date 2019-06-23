create or replace procedure parus.udo_ily_class_gen_key(i_rn in number) as

  ctable_name varchar2(30);
  a_count     number;
  a_rn        number;
  k_rn        number;
  c_rn        number;
  l_rn        number;

begin

  begin
    select upper(l.table_name)
      into ctable_name
      from unitlist l
     where l.rn = i_rn;
  exception
    when no_data_found then
      return;
  end;

  for k in (select *
              from all_constraints c
             where c.OWNER = 'PARUS'
               and c.TABLE_NAME = ctable_name
               and c.CONSTRAINT_TYPE in ('P', 'U')) loop

    select count(0)
      into a_count
      from DMSMESSAGES d
     where d.code = k.constraint_name;

    if a_count = 0 then
      P_DMSMESSAGES_INSERT(sCODE => k.constraint_name,
                           nKIND => 0,
                           sTEXT => 'Нарушение ' || case k.constraint_type
                                      when 'P' then
                                       'первичного ключа'
                                      when 'U' then
                                       'ключа уникальности'
                                    end || ' ' || k.constraint_name ||
                                    ' таблицы ' || k.owner || '.' ||
                                    k.table_name,
                           nRN   => a_rn);
    end if;

    begin
      select rn
        into k_rn
        from DMSCLCONSTRS kk
       where kk.prn = i_rn
         and kk.constraint_name = k.constraint_name;
    exception
      when no_data_found then
        P_DMSCLCONSTRS_INSERT_ADV(nPRN             => i_rn,
                                  sNAME            => k.constraint_name,
                                  sCONSTRAINT_NAME => k.constraint_name,
                                  nCONSTRAINT_TYPE => case k.constraint_type
                                                        when 'P' then
                                                         1
                                                        when 'U' then
                                                         0
                                                      end,
                                  sCHECK_FUNCTION  => null,
                                  sMESSAGE         => k.constraint_name,
                                  sCONSTRAINT_TEXT => null,
                                  cCONSTRAINT_INIT => null,
                                  nLINKS_SIGN      => 0,
                                  nRN              => k_rn);
    end;

    delete from DMSCLCONATTRS a where a.prn = k_rn;

    for c in (select *
                from ALL_CONS_COLUMNS t
               where t.OWNER = 'PARUS'
                 and t.CONSTRAINT_NAME = k.constraint_name
                 and t.TABLE_NAME = k.table_name) loop

      P_DMSCLCONATTRS_INSERT(nPRN       => k_rn,
                             nPOSITION  => c.position,
                             sATTRIBUTE => c.column_name,
                             nRN        => c_rn);

    end loop;

  end loop;

  for k in (select t.OWNER,
                   t.CONSTRAINT_NAME,
                   t.DELETE_RULE,
                   t.R_CONSTRAINT_NAME,
                   t.R_OWNER,
                   --c.constraint_name,
                   u.unitcode,
                   u.rn u_rn,
                   u.unitname,
                   (select l.parentcode
                      from unitlist l
                     where l.table_name = t.TABLE_NAME) p_code
              from SYS.ALL_CONSTRAINTS t, DMSCLCONSTRS c, unitlist u
             where t.TABLE_NAME = ctable_name
               and t.OWNER = 'PARUS'
               and t.CONSTRAINT_TYPE = 'R'
               and t.R_CONSTRAINT_NAME = c.constraint_name
               and c.prn = u.rn) loop

    P_DMSCLLINKS_INSERT(sSOURCE_CODE     => k.unitcode,
                        nDESTINATION     => k.u_rn,
                        sSTEREOTYPE      => case
                                              when k.unitcode = k.p_code then
                                               'Master-Detail'
                                              else
                                               'Связь со словарем'
                                            end,
                        nFOREIGN_KEY     => 0,
                        sSRC_CONSTRAINT  => k.r_constraint_name,
                        sCONSTRAINT_NAME => k.constraint_name,
                        sNAME            => k.constraint_name,
                        nRULE            => case
                                              when k.delete_rule = 'CASCADE' then
                                               1
                                              else
                                               0
                                            end,
                        sMESSAGE1        => null,
                        sMESSAGE2        => null,
                        sLEVEL_ATTR      => null,
                        sPATH_ATTR       => null,
                        sMASTER_LINK     => null,
                        nRN              => l_rn);

  end loop;

end;
/

