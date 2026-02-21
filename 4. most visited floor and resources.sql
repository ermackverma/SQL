--create table entries ( 
--name varchar(20),
--address varchar(20),
--email varchar(20),
--floor int,
--resources varchar(10));

--insert into entries 
--values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
--,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

--select * from entries;

-- solution 1:

with tv as
(
select name, count(floor) as total_visited 
from entries
group by name
)
,
 mv as (
select name, floor as most_visited from (
select name, floor, count(*) as most_visited , rank() over (partition by name order by count(floor) desc) as rankno
from entries 
group by name,floor ) A
where rankno=1
),
res as (
select name, string_agg(res, ', ') as resources_used from (
select distinct name, resources as res from entries
) A
group by name
)


select t.name, total_visited,most_visited, r.resources_used from tv t join mv m on t.name = m.name join res r on r.name = m.name and r.name = t.name


-- solution 2:
WITH ranked AS (
    SELECT 
        name,
        floor,
        COUNT(*) AS floor_visits,
        ROW_NUMBER() OVER (
            PARTITION BY name 
            ORDER BY COUNT(*) DESC
        ) rn
    FROM entries
    GROUP BY name, floor
),

visits AS (
    SELECT 
        name,
        COUNT(*) total_visits
    FROM entries
    GROUP BY name
),

resources AS (
    SELECT 
        name,
        STRING_AGG(resources, ',') resources_used
    FROM (
        SELECT DISTINCT name, resources
        FROM entries
    ) d
    GROUP BY name
)

SELECT 
    v.name,
    v.total_visits,
    r.floor AS most_visited_floor,
    res.resources_used
FROM visits v
JOIN ranked r 
    ON v.name = r.name AND r.rn = 1
JOIN resources res 
    ON v.name = res.name;