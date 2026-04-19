/*
Here we want something similar to "MOST IMPORTANT SKILLS" but we focus on ALL job postings.
Our goal here is to get better picture of valuable skills for job seekers
*/
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Poland'
GROUP BY
    skills
ORDER BY
    demand_count DESC
limit 5
