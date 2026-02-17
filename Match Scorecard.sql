--create table icc_world_cup
--(
--Team_1 Varchar(20),
--Team_2 Varchar(20),
--Winner Varchar(20)
--);
--INSERT INTO icc_world_cup values('India','SL','India');
--INSERT INTO icc_world_cup values('SL','Aus','Aus');
--INSERT INTO icc_world_cup values('SA','Eng','Eng');
--INSERT INTO icc_world_cup values('Eng','NZ','NZ');
--INSERT INTO icc_world_cup values('Aus','India','India');
--INSERT INTO icc_world_cup values('Aus','NZ','Aus');
--INSERT INTO icc_world_cup values('Ind','Pak','Ind');

--select * from icc_world_cup;


select 
Teamname, Count(*) as Total_Matches_Played, sum(winflag) as Matches_Won,
count(*) - sum(winflag) as Matches_Lost, sum(winflag) * 2 as Points_Earned
,CAST(ROUND(SUM(winflag) * 100.0 / COUNT(*), 2) AS float) AS [win%] 
from 
(
select
Team_1 as Teamname, 
case when Team_1 = Winner then 1 else 0 end as winflag 
from icc_world_cup
union all
select
Team_2 as Teamname, 
case when Team_2 = Winner then 1 else 0 end as winflag 
from icc_world_cup
) A
group by Teamname
order by 5 desc,2 asc