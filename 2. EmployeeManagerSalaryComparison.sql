--create table emp(emp_id int,emp_name varchar(10),salary int ,manager_id int);

--insert into emp values(1,'Ankit',10000,4);
--insert into emp values(2,'Mohit',15000,5);
--insert into emp values(3,'Vikas',10000,4);
--insert into emp values(4,'Rohit',5000,2);
--insert into emp values(5,'Mudit',12000,6);
--insert into emp values(6,'Agam',12000,2);
--insert into emp values(7,'Sanjay',9000,2);
--insert into emp values(8,'Ashish',5000,2);

--select * from emp;

-- find employees who have greater salary than their managers
--select * from emp;
select
empl.emp_id as employee_id, empl.emp_name as employee_name, empl.salary as employee_salary,
mngr.emp_id as manager_id, mngr.emp_name as manager_name, mngr.salary as manager_salary
from emp empl
join emp mngr
on empl.manager_id = mngr.emp_id
where empl.salary > mngr.salary


