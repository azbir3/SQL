create table departments (
        dept_no character varying (5) not null,
        primary key(dept_no),
        dept_name character varying (25) not null);
create table dept_emp (
        emp_no integer not null,
        primary key(emp_no),
        dept_no character varying (5) not null,
        from_date timestamp without time zone NOT NULL,
        to_date timestamp without time zone NOT NULL,
        foreign key(dept_no) references departments(dept_no));
create table dept_manager (
        dept_no character varying (5) not null,
        primary key (dept_no),
        emp_no integer not null,
        foreign key (emp_no) references dept_emp (emp_no),
        from_date timestamp without time zone NOT NULL,
        to_date timestamp without time zone NOT NULL);
create table employees (
        emp_no integer not null,
        birth_date timestamp without time zone NOT NULL,
        first_name character varying (30) NOT NULL,
        last_name character varying (30) NOT NULL,
        gender text,
        hire_date timestamp without time zone NOT NULL);
create table salaries (
        emp_no integer not null,
        salary integer not null,
        from_date timestamp without time zone NOT NULL,
        to_date timestamp without time zone NOT NULL);
create table titles (
        emp_no integer not null,
        title character varying (30),
        from_date timestamp without time zone NOT NULL,
        to_date timestamp without time zone NOT NULL);

-- to verify table set up
select * from departments
select * from dept_emp
select * from dept_manager
select * from employees
select * from salaries
select * from titles

-- delete tables
drop table departments;
drop table dept_emp;
drop table dept_manager;
drop table employees;
drop table salaries;
drop table titles;