create or replace procedure parus.udo_ily_gen_kor_atribute_view(class_rn  in number,
                                                                view_name in varchar2) as
  i        number := 0;
  tab_name varchar2(30);
begin

  select l.table_name
    into tab_name
    from unitlist l
   where l.rn = class_rn;

  for rec in (select t.COLUMN_NAME,
                     case
                       when t.DATA_TYPE = 'DATE' then
                        t.DATA_TYPE
                       when t.DATA_TYPE = 'VARCHAR2' then
                        t.DATA_TYPE || '_' || t.DATA_LENGTH
                       when t.DATA_TYPE = 'NUMBER' then
                        t.DATA_TYPE || '_' || t.DATA_PRECISION || '_' || t.DATA_SCALE
                     end domain,
                     t.COLUMN_ID
                from all_tab_columns t
               where t.TABLE_NAME = view_name
                 and t.DATA_TYPE in ('NUMBER',
                                     'VARCHAR2',
                                     'DATE')
               order by t.COLUMN_ID) loop

    i := i + 1;

    begin
      PKG_PROC_BROKER.PROLOGUE;
      PKG_PROC_BROKER.SET_PARAM_NUM('NPRN',
                                    class_rn);
      PKG_PROC_BROKER.SET_PARAM_STR('SCOLUMN_NAME',
                                    rec.column_name);
      PKG_PROC_BROKER.SET_PARAM_STR('SCAPTION',
                                    rec.column_name);
      PKG_PROC_BROKER.SET_PARAM_NUM('NKIND',
                                    1);
      PKG_PROC_BROKER.SET_PARAM_NUM('NPOSITION',
                                    rec.COLUMN_ID);
      PKG_PROC_BROKER.SET_PARAM_STR('SDOMAIN',
                                    rec.domain);
      PKG_PROC_BROKER.SET_PARAM_STR('SREF_LINK',
                                    NULL);
      PKG_PROC_BROKER.SET_PARAM_STR('SREF_ATTRIBUTE',
                                    NULL);
      PKG_PROC_BROKER.SET_PARAM_NUM('NRN');
      PKG_PROC_BROKER.EXECUTE('P_DMSCLATTRS_INSERT',
                              1);
      PKG_PROC_BROKER.EPILOGUE;
    exception
      when others then
        PKG_PROC_BROKER.EPILOGUE;
        null;
    end;

  end loop;
end;
/

