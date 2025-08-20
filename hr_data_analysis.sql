-- Questions
-- ============
-- What is the gender breakdown of employees in the company?
-- What is the race/ethnicity breakdown of employees in the company?
-- What is the age distribution of employees in the company?
-- How many employees work at headquarters versus remote locations?
-- What is the average length of employment for employees who have been terminated?
-- How does the gender distribution/count vary across departments and job titles?
-- What is the distribution/count of job titles across the company?
-- Which department has the highest turnover rate?
-- How does the turnover rate compare between Remote and Headquarters employees within the highest turnover department?
-- What is the distribution/count of employees across locations by city and state?
-- How has the company's employee count changed over time based on hire and term dates?
-- What is the attrition rate by age group?
-- What are the hiring trends over time? Which year had the most hires?
-- What is the tenure distribution for current employees by department?
-- What is the gender breakdown at different levels of job titles? (e.g., Trainee, Individual Contributor, Manager, Director)

-- SOLUTIONS
-- What is the gender breakdown of employees in the company?
-- ==========================================================
SELECT gender, COUNT(gender) num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

-- What is the race/ethnicity breakdown of employees in the company?
-- =================================================================
SELECT race, COUNT(race) num_of_employees  
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race;

-- What is the race/ethnicity breakdown of employees in the company?
-- =================================================================
SELECT race, COUNT(race) num_of_employees  
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
;
 
-- What is the age distribution of employees in the company?
-- ==========================================================
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 24 THEN '18-24'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  COUNT(*) AS num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group
ORDER BY age_group
;
-- What is the age distribution of employees(gender) in the company?
-- ==========================================================
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 24 THEN '18-24'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  gender,
  COUNT(*) AS num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY age_group, gender
ORDER BY age_group
;

-- How many employees work at headquarters versus remote locations?
-- ================================================================
SELECT location, COUNT(*) num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location
;

-- What is the average length of employment for employees who have been terminated?
-- =================================================================================
SELECT ROUND(AVG(length_of_employment)) avg_length_of_employment
FROM (SELECT YEAR(FROM_DAYS(DATEDIFF(termdate, hire_date))) length_of_employment 
		FROM hr
		WHERE age >= 18 AND 
			  termdate IS NOT NULL AND
              termdate < CURDATE()) temp
;


-- How does the gender distribution/count vary across departments and job titles?
-- ===============================================================================
SELECT department, jobtitle, gender, COUNT(*) num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender, department, jobtitle
ORDER BY department
;


-- What is the distribution/count of job titles across the company?
-- ======================================================================
SELECT jobtitle, COUNT(*) num_of_employees 
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle
;

-- Which department has the highest turnover rate?
-- =========================================================
SELECT department,
  total_count,
  terminated_count,
  terminated_count/total_count AS termination_rate
FROM (
  SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
  FROM hr
  WHERE age >= 18
  GROUP BY department) AS t
ORDER BY termination_rate DESC
;
-- How does the turnover rate compare between Remote and Headquarters employees within the highest turnover department?
SELECT 
    location,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count,
    ROUND(SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr
WHERE department = 'Support' -- Replace 'Sales' with the actual highest turnover department
GROUP BY location;

-- What is the distribution/count of employees across locations by city and state?
-- ===============================================================================
SELECT location, location_state, location_city, COUNT(*) num_of_employees
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location, location_city, location_state
ORDER BY num_of_employees
;

-- How has the company's employee count changed over time based on hire and term dates?
-- ====================================================================================
SELECT 
	b.year year, 
	a.hire hired, 
    b.term term,
    a.hire - b.term AS net_change,
    ROUND(((a.hire - b.term)/a.hire) * 100, 2) AS net_change_percent
FROM 
	( SELECT YEAR(hire_date) year, 
			 COUNT(*) hire
	  FROM hr
      WHERE age >= 18
      GROUP BY year
      ORDER BY year
	) a RIGHT JOIN 
    ( SELECT YEAR(termdate) year, COUNT(*) term 
      FROM hr
      WHERE age >= 18
      GROUP BY year
      ORDER BY year
	) b 
ON a.year = b.year
WHERE b.year <= YEAR(CURDATE())
;



-- Attrition Rate by Age Group
-- ====================================================================================
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count,
    ROUND(SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr
GROUP BY age_group
ORDER BY age_group;


-- Hiring Trends by Year
-- ====================================================================================
SELECT 
    YEAR(hire_date) AS hire_year,
    COUNT(id) AS number_of_hires
FROM hr
GROUP BY hire_year
ORDER BY hire_year;

-- Tenure Distribution for CURRENT Employees by Department
 -- Only include active employees
 -- ====================================================================================
SELECT 
    department,
    ROUND(AVG(DATEDIFF(CURDATE(), hire_date) / 365), 1) AS avg_tenure_years
FROM hr
WHERE termdate IS NULL OR termdate > CURDATE()
GROUP BY department
ORDER BY avg_tenure_years DESC;

-- Gender Breakdown by Job Level
SELECT 
    CASE
        WHEN jobtitle LIKE '%Manager%' THEN 'Manager'
        WHEN jobtitle LIKE '%Director%' THEN 'Director'
        WHEN jobtitle LIKE '%Trainee%' OR jobtitle LIKE '%Intern%' THEN 'Entry-Level'
        ELSE 'Individual Contributor'
    END AS job_level,
    gender,
    COUNT(*) AS count
FROM hr
GROUP BY job_level, gender
ORDER BY job_level, gender;
