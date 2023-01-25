

with sample_table as (
select JSON_QUERY (DATA,'$.issuedAt') as ts ,
JSON_VALUE(DATA , "$.amount") as Amount ,
JSON_VALUE(DATA , "$.docId") as docId,
JSON_VALUE(DATA , "$.fee") as Fee ,
JSON_VALUE(DATA , "$.receiverId") as receiverId ,
JSON_VALUE(DATA , "$.senderId") as senderId ,
JSON_VALUE(DATA , "$.type") as type ,

 FROM `website.all.transactions_raw_latest`
  ) 
select Date , cast (amount as DECIMAL)  as Amount  , 
docId ,
Fee ,receiverId,senderId , type 
  from 
(select    Amount , REPLACE ( cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(ts, "$['_seconds']"))as string ) , 'T', ' ')  as Date ,
  docId ,
  Fee ,receiverId,senderId , type 
from sample_table  
) as new_table




