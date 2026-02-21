--select  * from pivotted_table

-- manual unpivot way
select emp_id, category, val from (
select emp_id,'salary' as category, salary as val from pivotted_table 
union all
select emp_id,'bonus' as category, bonus as val from pivotted_table
union all
select emp_id,'hike_percent' as category, hike_percent as val from pivotted_table
) A
order by 1


-- using unpivot option 
select emp_id, category, vals
from pivotted_table
unpivot (vals for category in (salary, bonus, hike_percent))A