CREATE OR REPLACE PACKAGE PARUS.udo_ily_types IS
  /* Create a generic table type for primary keys */
  type rn_unit_doc is record(
    doc_rn   number,
    unit_str varchar2(40));

  TYPE pk_tab IS TABLE OF rn_unit_doc INDEX BY BINARY_INTEGER;

  TYPE gen_curs IS REF CURSOR RETURN udo_ily_rn%ROWTYPE;
  TYPE gen_curs_text IS REF CURSOR RETURN udo_ily_text%ROWTYPE;

  type ddiger_rec is record(
    type_id   number,
    date_from date,
    date_to   date);

  TYPE ddiger IS TABLE OF ddiger_rec INDEX BY BINARY_INTEGER;
  --
  i number := 0;
  function set_i(in_i in number) return number;
  function get_i return number;
  --
  str varchar2(1000);
  function set_str(in_str in varchar2) return varchar2;
  function get_str return varchar2;
  --
  type var_rec is record(
    type_num number,
    type_str varchar2(1000),
    type_dat date);

  TYPE var_tab IS TABLE OF var_rec INDEX BY BINARY_INTEGER;

  var_list var_tab;

  function set_var(in_var   in number,
                   in_index in number) return number;
  function set_var(in_var   in varchar2,
                   in_index in number) return varchar2;
  function set_var(in_var   in date,
                   in_index in number) return date;

  function get_var_num(in_index in number) return number;
  function get_var_str(in_index in number) return varchar2;
  function get_var_dat(in_index in number) return date;
  /* Declare two tables based on this table type */
END udo_ily_types;
/

CREATE OR REPLACE PACKAGE BODY PARUS.udo_ily_types IS

  function set_i(in_i in number) return number as
  begin
    i := in_i;
    return i;

  end;

  function get_i return number as
  begin

    return i;

  end;

  function set_str(in_str in varchar2) return varchar2 as
    pragma autonomous_transaction;
  begin
    str := in_str;

    insert into parus.udo_ily_log_select
      (rn,
       auth,
       tstamp,
       str)
    values
      (gen_id,
       user,
       sysdate,
       str);
       commit;

    return str;

  end;

  function get_str return varchar2 as
  begin

    return str;

  end;

  --
  function set_var(in_var   in number,
                   in_index in number) return number as
  begin

    var_list(in_index).type_num := in_var;

    return in_var;
  end;
  function set_var(in_var   in varchar2,
                   in_index in number) return varchar2 as
  begin
    var_list(in_index).type_str := in_var;
    return in_var;
  end;
  function set_var(in_var   in date,
                   in_index in number) return date as
  begin
    var_list(in_index).type_dat := in_var;
    return in_var;
  end;

  function get_var_num(in_index in number) return number as
  begin
    return var_list(in_index).type_num;
  end;
  function get_var_str(in_index in number) return varchar2 as
  begin
    return var_list(in_index).type_str;
  end;
  function get_var_dat(in_index in number) return date as
  begin
    return var_list(in_index).type_dat;
  end;

end;
/

