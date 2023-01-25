with sample_table as (
  select JSON_QUERY (DATA,'$.date') as ts , (document_id) as num ,JSON_VALUE(DATA , "$.amount") AS amount 

 FROM `website.all.payout_requests_raw_latest`
  ) 


select count (num) as NumberOfWithdrawsInTheLas24tHour , sum ( cast (amount as DECIMAL) )as TotalAmountOfWithdrawsInTheLas24tHour 

  from 
(select    amount, REPLACE ( cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(ts, "$['_seconds']"))as string ) , 'T', ' ')  as new_date ,  num 
from sample_table  
) as new_table
where cast (new_date as timestamp) >=  TIMESTAMP_ADD ( CURRENT_TIMESTAMP() , INTERVAL -24 HOUR )







