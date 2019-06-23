create or replace force view parus.v_family_type as
select RN nrn, CODE scode, rcode srcode from family_type;
grant select on PARUS.V_FAMILY_TYPE to PUBLIC;


