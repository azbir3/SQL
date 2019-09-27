select * from "Department_Employees"
select * from "Department_Manager"
select * from "Departments"
select * from "Employees"
select * from "Salaries"
select * from "Titles"

--#1 create a querie to pull emp no, names, gender and salary
--store nicknames ("Salaries"=groshi; "Employees"=narod) to be used in join query
select narod.emp_no, narod.last_name, narod.first_name, narod.gender, groshi.salary
from "Employees" narod
join "Salaries" groshi on narod.emp_no=groshi.emp_no

--2 list all employees hired in 1986
select * from "Employees" where
(hire_date between '1986-01-01' and '1986-12-31')

--#3 List the manager of each department with the following information:
-- department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.
select "Departments".dept_no, "Departments".dept_name, "Department_Manager".emp_no, "Employees".last_name, "Employees".first_name, "Department_Manager".from_date, "Department_Manager".to_date from
"Departments" join "Department_Manager" on "Departments".dept_no="Department_Manager".dept_no
join "Employees" on "Department_Manager".emp_no="Employees".emp_no;

--#4 List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
from "Employees" join "Department_Employees" on "Employees".emp_no="Department_Employees".emp_no
join "Departments" on "Department_Employees".dept_no="Departments".dept_no;

--#5 List all employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name from "Employees"
where
        first_name='Hercules'
        and last_name like 'B%';

--#6 List all employees in the Sales department, including their employee number,
-- last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" e
join "Departments" d
join "Department_Employees" de
on (de.dept_no=d.dept_no)
on (e.emp_no=de.emp_no)
where d.dept_name='Sales';

--#7 List all employees in the Sales and Development departments, including their
-- employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" e
join "Departments" d
join "Department_Employees" de
on (de.dept_no=d.dept_no)
on (e.emp_no=de.emp_no)
where d.dept_name in ('Sales', 'Development');

--#8 In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
select last_name, count(last_name) from "Employees"
group by last_name
order by "count" desc;

--Epilogue.  "Search ID number 499942."
select e.emp_no, e.last_name, e.first_name, d.dept_name
from "Employees" e
join "Departments" d
join "Department_Employees" de
on (de.dept_no=d.dept_no)
on (e.emp_no=de.emp_no)
where e.emp_no=499942;

select narod.emp_no, narod.last_name, narod.first_name, narod.gender, groshi.salary
from "Employees" narod
join "Salaries" groshi on narod.emp_no=groshi.emp_no
where narod.emp_no=499942;