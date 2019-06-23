create or replace procedure parus.udo_ily_gen_metod_param(in_rn in number) as
  n_overload      dbms_describe.number_table;
  n_position      dbms_describe.number_table;
  n_level         dbms_describe.number_table;
  s_argument_name dbms_describe.varchar2_table;
  n_datatype      dbms_describe.number_table;
  n_default_value dbms_describe.number_table;
  n_in_out        dbms_describe.number_table;
  n_length        dbms_describe.number_table;
  n_precision     dbms_describe.number_table;
  n_scale         dbms_describe.number_table;
  n_radix         dbms_describe.number_table;
  n_spare         dbms_describe.number_table;
  proc_not_found exception;
  pragma exception_init(proc_not_found,
                        -06564);
  proc_name varchar2(60);

  prm_row parus.v_DMSCLMETPARMS%rowtype;
begin
  for rec in (select t.OWNER,
                     t.OBJECT_NAME,
                     m.rn,
                     m.prn
                from all_objects        t,
                     parus.DMSCLMETHODS m
               where t.object_type = 'PROCEDURE'
                 and t.owner = 'PARUS'
                 and t.OBJECT_NAME = m.name
                 and t.status = 'VALID'
                 and m.rn = in_rn) loop
    proc_name := rec.owner || '.' || rec.object_name;
    begin
      dbms_describe.describe_procedure(proc_name,
                                       null,
                                       null,
                                       n_overload,
                                       n_position,
                                       n_level,
                                       s_argument_name,
                                       n_datatype,
                                       n_default_value,
                                       n_in_out,
                                       n_length,
                                       n_precision,
                                       n_scale,
                                       n_radix,
                                       n_spare);
    exception
      when proc_not_found then
        raise_application_error(-20001,
                                '’ранима€ процедура "' || proc_name ||
                                '" не существует в базе данных или находитс€ в неработоспособном состо€нии.');
      when others then
        dbms_output.put_line(proc_name || ' ERR:' || sqlcode);
        goto end_p;
    end;

    for i in s_argument_name.first .. s_argument_name.last loop
      --if n_position(1) != 1 then
      dbms_output.put_line(n_position(i) || ' - ' || s_argument_name(i) || ' - ' || n_datatype(i) || ' - ' ||
                           n_in_out(i));

      prm_row.nprn       := rec.rn;
      prm_row.sdomain    := case n_datatype(i)
                              when 1 then
                               'VARCHAR2_20'
                              when 2 then
                               'NUMBER_17_0'
                              when 12 then
                               'DATE'
                            end;
      prm_row.sname      := s_argument_name(i);
      prm_row.scaption   := s_argument_name(i);
      prm_row.nposition  := n_position(i);
      prm_row.ninout     := case n_in_out(i)
                              when 0 then
                               1
                              when 1 then
                               2
                              when 2 then
                               0
                            end;
      prm_row.slink_attr := null;
      prm_row.nlink_type := 0;

      for pr in (select *
                   from parus.V_DMSCLATTRS t
                  where NPRN = rec.prn
                    and n_in_out(i) = 0
                    and ('I_' || t.scolumn_name = s_argument_name(i) or 'O_' || t.scolumn_name = s_argument_name(i))) loop

        prm_row.sdomain    := pr.sdomain;
        prm_row.scaption   := pr.scaption;
        prm_row.slink_attr := pr.scolumn_name;
        prm_row.nlink_type := 1;

      end loop;

      begin
        PKG_PROC_BROKER.PROLOGUE;
        PKG_PROC_BROKER.SET_PARAM_NUM('NPRN',
                                      prm_row.nprn);
        PKG_PROC_BROKER.SET_PARAM_STR('SDOMAIN',
                                      prm_row.sdomain);
        PKG_PROC_BROKER.SET_PARAM_STR('SNAME',
                                      prm_row.sname);
        PKG_PROC_BROKER.SET_PARAM_STR('SCAPTION',
                                      prm_row.scaption);
        PKG_PROC_BROKER.SET_PARAM_NUM('NPOSITION',
                                      prm_row.nposition);
        PKG_PROC_BROKER.SET_PARAM_NUM('NINOUT',
                                      prm_row.ninout);
        PKG_PROC_BROKER.SET_PARAM_STR('SDEF_STRING',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_NUM('NDEF_NUMBER',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_DAT('DDEF_DATE',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_STR('SLINK_ATTR',
                                      prm_row.slink_attr);
        PKG_PROC_BROKER.SET_PARAM_NUM('NLINK_TYPE',
                                      prm_row.nlink_type);
        PKG_PROC_BROKER.SET_PARAM_NUM('NCONTEXT',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_STR('SLINKED_FUNCTION',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_NUM('NMANDATORY',
                                      0);
        PKG_PROC_BROKER.SET_PARAM_STR('SACTION_PARAM',
                                      NULL);
        PKG_PROC_BROKER.SET_PARAM_NUM('NRN');
        PKG_PROC_BROKER.EXECUTE('P_DMSCLMETPARMS_INSERT',
                                1);
        PKG_PROC_BROKER.EPILOGUE;
      exception
        when others then
          PKG_PROC_BROKER.EPILOGUE;
          null;--raise;
      end;
    end loop;
    <<end_p>>
    null;
  end loop;
end;
/

