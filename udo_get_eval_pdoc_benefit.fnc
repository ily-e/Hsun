create or replace function parus.udo_get_eval_pdoc_benefit(i_person in number,
                                                     i_bsum   in number)
  return number as
  res number;
  v_cnt number;
  v_good number;
  income number := UDO_F_PERSON_DOHOD(i_person);
begin  

  select count(0), sum(good)
    into v_cnt, v_good
    from (select /*b.rn,
                 b.benefit_name,
                 bs.rn,
                 bs.sum_b,
                 bsc.rn_tag,
                 tl.code,
                 sum(bsc.cond_numb),
                 income p_dohod,
                 (select sum(spdv.value_num)
                    from v_person              sp,
                         person_document       spd,
                         PERSON_DOCUMENT_VALUE spdv,
                         tag_list              stl
                   where sp.count_document > 0
                     and sp.nrn = spd.person_id
                     and spd.rn = spdv.prn
                     and spdv.tag_id = stl.rn
                     and nvl(spd.date_from, spd.date_doc) <= sysdate
                     and (spd.date_to >= sysdate or spd.date_to is null)
                     and spd.person_id = i_person
                     and stl.rn = tl.rn) val,
                 bsc.cond_sign,*/
                 
                 calc_eval(case
                             when tl.code = 'Доход на 1 чел' then
                              income
                             else
                              (select sum(spdv.value_num)
                                 from v_person              sp,
                                      person_document       spd,
                                      PERSON_DOCUMENT_VALUE spdv,
                                      tag_list              stl
                                where sp.count_document > 0
                                  and sp.nrn = spd.person_id
                                  and spd.rn = spdv.prn
                                  and spdv.tag_id = stl.rn
                                  and nvl(spd.date_from, spd.date_doc) <= sysdate
                                  and (spd.date_to >= sysdate or spd.date_to is null)
                                  and spd.person_id = i_person
                                  and stl.rn = tl.rn)
                           end,
                           sum(bsc.cond_numb),
                           bsc.cond_sign) good
          
            from benefit_type           b,
                 benefit_sum            bs,
                 benefit_sum_conditions bsc,
                 tag_list               tl
           where b.rn = bs.rn_b
             and bs.rn = bsc.rn_benefit_sum
             and bsc.rn_tag = tl.rn
             and bsc.cond_numb is not null
             and bs.rn = i_bsum
           group by b.rn,
                    b.benefit_name,
                    bs.rn,
                    bs.sum_b,
                    bsc.rn_tag,
                    tl.code,
                    tl.rn,
                    bsc.cond_sign);
  if v_cnt = v_good and v_cnt > 0 and income > 0  then
    return 1;
  else
    return 0;
  end if;
end;
/

