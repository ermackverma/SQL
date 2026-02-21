--create table emp_compensation (
--emp_id int,
--salary_component_type varchar(20),
--val int
--);

--insert into emp_compensation
--values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
--, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
--, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);

--select * from emp_compensation;

-- copying one table to another

--select * into new_emp_compensation from emp_compensation


--select * from new_emp_compensation
--select * from emp_compensation
--drop table new_emp_compensation

-- pivot without using inbuilt func.
select emp_id, sum(salary) as salary, sum(bonus) as bonus, sum(hike_percent) as hike_percent from (
select
emp_id, 
case when salary_component_type = 'salary' then val end as salary
,case when salary_component_type = 'bonus' then val end as bonus
,case when salary_component_type = 'hike_percent' then val end as hike_percent
from emp_compensation
) A
group by emp_id

-- pivot using func.
select emp_id, salary, bonus, hike_percent -- add all the columns needed along with the new columns needed
from emp_compensation -- from table
pivot ( sum(val) for salary_component_type in (salary, bonus, hike_percent)) as pivot_table
-- pivot ( sum of the value column and then for + column name in (new column names by , )) then as name


select  * from pivotted_table

-- saving the pivot table into a new table
--select * into pivotted_table from (

--select emp_id, sum(salary) as salary, sum(bonus) as bonus, sum(hike_percent) as hike_percent from (
--select
--emp_id, 
--case when salary_component_type = 'salary' then val end as salary
--,case when salary_component_type = 'bonus' then val end as bonus
--,case when salary_component_type = 'hike_percent' then val end as hike_percent
--from emp_compensation
--) A
--group by emp_id
--)AAZ