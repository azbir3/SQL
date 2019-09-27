--2 - display districts for the noted cities
-- store nick names for the tables (city=gorod; address=koliba)
select koliba.district, gorod.city from city gorod
join address koliba on gorod.city_id=koliba.city_id
where city in ('Qalyub', 'Qinhuangdao', 'Qomsheh', 'Quilmes')

select narod.emp_no, narod.last_name, narod.first_name, narod.gender, groshi.salary from "Employees" narod
join "Salaries" groshi on narod.emp_no=groshi.emp_no

--query 4- List the department of each employee with the following information:
--                                      employee number, last name, first name, and department name.

select * from "Employees"
select * from "Departments"
select * from "Department_Employees"

select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name from
"Employees" join "Department_Employees" on "Employees".emp_no="Department_Employees".emp_no
join "Departments" on "Department_Employees".dept_no="Departments".dept_no;


--look into view as must pull data from Emp and Dep with Dep_emp as an intermediary
-- create nicknames for two tables involved (employees=narod; deparments=lager; )
select narod.emp_no, narod.last_name, narod.first_name, lager.dept_names from "Employees" narod
join "Departments" lager on narod.emp_no=groshi.emp_no