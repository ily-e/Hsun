create or replace force view parus.v_benefit_type as
select t."RN",t."BENEFIT_NAME",t."LEVEL_B",t."REGION",t."PERIOD_", f.geogrname,
UDO_F_TYPE_BENEFIT_KOL(t.rn) b_kol,
UDO_F_TYPE_BENEFIT_SUM(t.rn) b_sum,
UDO_F_TYPE_BENEFIT_RES_KOL(t.rn) fakt_kol,
UDO_F_TYPE_BENEFIT_RES_SUM(t.rn)  fakt_sum
from BENEFIT_TYPE t, geografy f
where t.region=f.rn(+);
grant select on PARUS.V_BENEFIT_TYPE to PUBLIC;


