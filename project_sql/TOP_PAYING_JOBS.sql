/*
-Identify the top 10 highest paying data analyst roles that are available remotely.
*/

SELECT
    job_id,
    job_location,
    job_schedule_type,
    job_posted_date,
    salary_year_avg,
    job_title,
    name as company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;