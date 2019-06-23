create or replace procedure parus.udo_ily_kor_get_view_columb(in_rn in number) as

  f_column varchar2(30);

begin

  for vm in (select *
               from parus.V_DMSCLVIEWS
              where NRN = in_rn) loop

    for atr in (select *
                  from parus.v_dmsclattrs a
                 where a.nprn = vm.nprn) loop

      parus.P_DMSCLVIEWSATTRS_FIND_ATTR(1,
                                        in_rn,
                                        atr.scolumn_name,
                                        f_column);

      if f_column is null then
        f_column := atr.scolumn_name;
      end if;

      for clm in (select *
                    from all_tab_cols c
                   where c.owner = 'PARUS'
                     and c.table_name = vm.sview_name
                     and c.COLUMN_NAME = f_column) loop

        begin
          PKG_PROC_BROKER.PROLOGUE;
          PKG_PROC_BROKER.SET_PARAM_NUM('NPRN',
                                        in_rn);
          PKG_PROC_BROKER.SET_PARAM_STR('SATTR',
                                        atr.scolumn_name);
          PKG_PROC_BROKER.SET_PARAM_STR('SCOLUMN_NAME',
                                        clm.column_name);
          PKG_PROC_BROKER.SET_PARAM_NUM('NRN');
          PKG_PROC_BROKER.EXECUTE('P_DMSCLVIEWSATTRS_INSERT',
                                  1);

          PKG_PROC_BROKER.EPILOGUE;
        exception
          when others then
            PKG_PROC_BROKER.EPILOGUE;
            null;
        end;

      end loop;
    end loop;

  end loop;

end;
/

