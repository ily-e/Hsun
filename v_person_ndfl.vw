create or replace force view parus.v_person_ndfl as
select RN         nrn,
       PERSON_RN  nPERSON_RN,
       NDFL_MONTH nNDFL_MONTH,
       NDFL_YEAR  nNDFL_YEAR,
       SUMMA      nSUMMA,
       NDFL_CODE  sNDFL_CODE
  from PERSON_NDFL;
grant select on PARUS.V_PERSON_NDFL to PUBLIC;


