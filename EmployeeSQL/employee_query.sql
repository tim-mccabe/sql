--Tables are out of order because of dependencies. Create tables depatments and employees first to avoid any reference errors.

-- Create Departments Table
DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments
(
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

-- Create Department Employees Table
DROP TABLE IF EXISTS dept_emp CASCADE;
CREATE TABLE dept_emp
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Department Managers Table
DROP TABLE IF EXISTS dept_manager CASCADE;
CREATE TABLE dept_manager
(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Employees Table
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees
(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

-- Create Salaries Table
DROP TABLE IF EXISTS salaries CASCADE;
CREATE TABLE salaries
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Titles Table
DROP TABLE IF EXISTS titles CASCADE;
CREATE TABLE titles
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

--Once you have a complete database, do the following:


--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries as s
INNER JOIN employees AS e ON
e.emp_no = s.emp_no;

--List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date LIKE '1986%';

--List the manager of each department with the following information: department number,
--department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments AS d
INNER JOIN dept_manager AS m ON
m.dept_no = d.dept_no
JOIN employees AS e ON
e.emp_no = m.emp_no;

--List the department of each employee with the following information: employee number, last name,
--first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

--List all employees in the Sales and Development departments, including their employee number,
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development'
OR dp.dept_name LIKE 'Sales';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;