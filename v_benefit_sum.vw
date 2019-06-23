create or replace force view parus.v_benefit_sum as
select t."RN",t."RN_B",t."SUM_B",t."DATE_F",t."DATE_T",t."NUM_BS",
to_char(t.date_f,'dd.mm.yyyy')||' - '||nvl(to_char(t.date_t,'dd.mm.yyyy'),'по наст.время') period
from BENEFIT_SUM t;
grant select on PARUS.V_BENEFIT_SUM to PUBLIC;


