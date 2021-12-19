-- Deliverable 1: The Number of Retiring Employees by Title
-- Table that holds title of all current employees born between 1/1/52 and 12/31/55 using DISTINCT ON for most current title
-- Then use COUNT() to make table that has number of retirement age employees by most recent job title
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles

--Table to show count of each title in retiring age range
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

--Deliverable 2: The Employees Eligible for the Mentorship Program
--Table that hold the employees eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN title AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.title ASC;

--Table to show count of each title in mentorship age range
SELECT COUNT(me.emp_no), me.title
--INTO retiring_titles
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY COUNT(me.emp_no) DESC;


