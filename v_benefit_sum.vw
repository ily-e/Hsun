create or replace force view parus.v_benefit_sum as
select t."RN",
       t."RN_B",
       t."SUM_B",
       t."DATE_F",
       t."DATE_T",
       t."NUM_BS",
       to_char(t.date_f, 'dd.mm.yyyy') || ' - ' ||
       nvl(to_char(t.date_t, 'dd.mm.yyyy'), 'по наст.время') period,
       udo_ily_transpond(cursor
                         (select l.code || ' ' || b.cond_sign || ' ' ||
                                 nvl(b.cond_str,
                                     nvl(to_char(b.cond_numb),
                                         to_char(b.cond_date, 'dd.mm.yyyy')))
                            from benefit_sum_conditions b, tag_list l
                           where b.rn_tag = l.rn
                             and b.rn_benefit_sum = t.rn),
                         '; ') cond_list
  from BENEFIT_SUM t;
grant select on PARUS.V_BENEFIT_SUM to PUBLIC;


