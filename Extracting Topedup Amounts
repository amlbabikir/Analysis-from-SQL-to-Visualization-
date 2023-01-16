with sample_table as (
  select JSON_QUERY (DATA,'$.date') as ts , (document_id) as num  , JSON_VALUE(DATA , "$.amount") AS amount 
 FROM `website.all.invoices_raw_latest`  
 where JSON_VALUE(DATA , "$.status") = 'paid'
  ) 
select Date , cast (amount as DECIMAL)  as AmountofTopup 
  from 
(select    amount , REPLACE ( cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(ts, "$['_seconds']"))as string ) , 'T', ' ')  as Date ,
  num 
from sample_table  
) as new_table
