
with sample_table as (
  select JSON_QUERY (DATA,'$.date') as ts , (document_id) as num , JSON_VALUE(DATA , "$.amount") AS amount 

 FROM `website.all.invoices_raw_latest`  
  ) 


select count (num) as NumberOfTopupsInTheLastWeek,  sum ( cast (amount as DECIMAL) )as totalamount

  from 
(select    amount , REPLACE ( cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(ts, "$['_seconds']"))as string ) , 'T', ' ')  as new_date ,  num 
from sample_table  
) as new_table
where   cast (cast (new_date as timestamp) AS DATETIME)  >=  DATE_ADD ( CURRENT_DATE() , INTERVAL -1 Week )
