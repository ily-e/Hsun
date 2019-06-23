create or replace force view parus.v_benefit_type as
select t."RN",t."BENEFIT_NAME",t."LEVEL_B",t."REGION",t."PERIOD_", f.geogrname from BENEFIT_TYPE t, geografy f
where t.region=f.rn(+);
grant select on PARUS.V_BENEFIT_TYPE to PUBLIC;


