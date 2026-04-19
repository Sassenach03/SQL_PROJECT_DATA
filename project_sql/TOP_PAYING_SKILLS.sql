/*
Here we want have better look at the top skills based on salary.
It reveals how different skills impact salary
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    

GROUP BY
    skills
ORDER BY
    avg_salary DESC
limit 25