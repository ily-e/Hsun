create or replace force view parus.v_person as
select rn nrn,
       AGN_F sagn_f,
       AGN_I sagn_i,
       AGN_O sagn_o,
       AGNBURN dagn_burn,
       SNILS nsnils,
       substr(to_char(snils), 1, 3) || '-' || substr(to_char(snils), 4, 3) || '-' ||
       substr(to_char(snils), 7, 3) || ' ' || substr(to_char(snils), 10) ssnils,
       INN ninn,
       SEX nsex,
       trunc(months_between(sysdate, agnburn) / 12) age,
       UDO_F_PERSON_DOHOD(rn) dohod,
       (select count(0) c
          from person_document d
         where d.person_id = p.rn
           and nvl(d.date_from, d.date_doc) <= sysdate
           and (d.date_to >= sysdate or d.date_to is null)) count_document
  from person p;
grant select on PARUS.V_PERSON to PUBLIC;


