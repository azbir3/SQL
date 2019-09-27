--query 3- List the manager of each department with the following information: department number,
-- department name, the manager's employee number, last name, first name, and start and end employment dates.

select * from "Department_Manager"
select * from "Departments"
select * from "Employees"

select "Departments".dept_no, "Departments".dept_name, "Department_Manager".emp_no, "Employees".last_name, "Employees".first_name, "Department_Manager".from_date, "Department_Manager".to_date from
"Departments" join "Department_Manager" on "Departments".dept_no="Department_Manager".dept_no
join "Employees" on "Department_Manager".emp_no="Employees".emp_no;




select a.dept_no, a.dept_name, b.emp_no, c.last_name, c.first_name, b.from_date, b.to_date from
"Departments" a, "Department_Manager" b, "Employees" c
where a.dept_no=b.dept_no

select a.dept_no, a.dept_name, b.emp_no
from "Departments" a, "Department_Manager" b
where a.dept_no=b.dept_no