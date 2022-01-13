-- Dev 1

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.

SELECT emp_no, first_name, last_name
FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.

SELECT title, from_date, to_date
FROM title;

-- Create a new table using the INTO clause.
-- Join both tables on the primary key.'
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
-- Take note empl and titl are references to the tables 'employees' and 'title'

SELECT empl.emp_no, empl.first_name, empl.last_name, titl.title, titl.from_date, titl.to_date
INTO retirement_titles
FROM employees as empl
INNER JOIN title as titl
ON empl.emp_no = titl.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY empl.emp_no;

-- Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
-- Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
-- Create a Unique Titles table using the INTO clause.
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
-- Take note "rettitl" is a reference to the table retirement_titles

SELECT DISTINCT ON (rettitl.emp_no) rettitl.emp_no,
rettitl.first_name,
rettitl.last_name,
rettitl.title
INTO unique_titles
FROM retirement_titles as rettitl
ORDER BY rettitl.emp_no, rettitl.to_date DESC;

-- First, retrieve the number of titles from the Unique Titles table. (count)
-- Then, create a Retiring Titles table to hold the required information. (into)
-- Group the table by title, then sort the count column in descending order. (group by and order by)
-- Take note "unititl" is a reference to the table unique_titles

SELECT COUNT(unititl.emp_no), unititl.title
INTO retiring_titles
FROM unique_titles as unititl
GROUP BY unititl.title
ORDER BY COUNT(unititl.emp_no) DESC;

-- Dev 2

-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table. (Select)
-- Retrieve the from_date and to_date columns from the Department Employee table. (Select)
-- Retrieve the title column from the Titles table. (Select)
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause. (Select Distinct ON)
-- Create a new table using the INTO clause. (Into)
-- Join the Employees and the Department Employee tables on the primary key. (Inner Join)
-- Join the Employees and the Titles tables on the primary key. (Inner Join)
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965. (Where)
-- Order the table by the employee number. (Order By)

SELECT DISTINCT ON (empl.emp_no) empl.emp_no,
empl.first_name,
empl.last_name,
empl.birth_date,
dept.from_date,
dept.to_date,
titl.title	
INTO mentorship_eligibilty
FROM employees as empl
INNER JOIN dept_emp as dept
ON empl.emp_no = dept.emp_no
INNER JOIN title as titl
ON empl.emp_no = titl.emp_no
WHERE ((birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (dept.to_date = '9999-01-01'))
ORDER BY empl.emp_no;