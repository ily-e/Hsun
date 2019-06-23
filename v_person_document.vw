create or replace force view parus.v_person_document as
select d.RN,
       d.PERSON_ID,
       d.SERIA,
       d.NUMB,
       d.DATE_DOC,
       d.DATE_FROM,
       d.DATE_TO,
       d.DOC_TYPE,
       t.code sdoc_type,
       d.FACTDOC
  from PERSON_DOCUMENT d, document_type t
  where d.doc_type = t.rn;
grant select on PARUS.V_PERSON_DOCUMENT to PUBLIC;


