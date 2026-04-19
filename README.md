# Introduction
Take a closer look at the data job market with a focus on Data Analyst roles. 
This project uncvoers the highest-paying opportunities, the most in-demand skills, and the areas where market demand and salary potential intersect in data analytics.
SQL queries? Have a look here: [project_sql folder](/project_sql/)

# The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated wtih higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
- **SQL** served as the foundation of my analysis, enabling me to query the database and uncover meaningful insights.
- **PostgreSQL** was used as the database management system, providing a reliable and efficient way to store and manage job posting data.
- **Visual Studio Code** was my primary workspace for database management and writing SQL queries.
- **Git and GitHub** played a key role in version control, helping me manage SQL scripts, track changes, and collaborate effectively throughout the project

# The Analysis

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary
and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```SQL
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
```

Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184.000 to $650,000 indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](/assets/top10_data_analyst_salary_ranking_dark_en.png)

### 2. Skills for Top Paying Jobs

To understand which skills are associated with the highest-paying Data Analyst roles, I analyzed the average salary linked to individual skills
across job postings. This query highlights the tools and technologies that appear most valuable in the martet and reveals which skills are connected to the strongest salary potential in data analytics

```SQL
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
```
Here’s the breakdown of the top-paying skills for data analysts in 2023:

- **Wide Salary Gap:** The ranking shows a significant gap between the top skill and the rest, with **SVN** standing out as a major outlier at **$400,000**, while most other skills fall into a much lower salary range.
- **Specialized Technical Stack:** The highest-paying skills include a mix of **machine learning**, **data engineering**, and **infrastructure-related** tools such as PyTorch, TensorFlow, Terraform, Kafka, and Airflow.
- **High-Value Niche Skills:** Many of the top-paying skills are not basic analyst tools, but rather more specialized or less common technologies, suggesting that niche expertise can lead to stronger salary potential.

![Skills for Top Paying Jobs](/assets/top25_skills_salary_dark_en.png)

### 3. In-Demand Skills for Data Analysts

To indentify the most in-demand skills for Data Analyst roles in Poland, I analyzed how often specific skills appeared across job postings.
This query highlights the core tools and technologies most frequently requested by employers in the Polish data analytics market

```SQL
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
```
| Skill     | Demand Count |
|-----------|-------------:|
| SQL       | 131 |
| Python    | 85  |
| Excel     | 73  |
| Tableau   | 56  |
| Power BI  | 46  |

Here's the breakdown of In-demand skills for data analysts on Polish market in 2023:

The results show that **SQL** is the most in-demand skill, followed by **Python** and **Excel**, confirming their importance in Data Analyst roles
in Poland. Tools such as **Tableau** and **Power BI** also appear frequently, showing that data visualization and reporting remain highly valued in
the Polish job market.

### 4. Skills Based on Salary

To identify which skills are associated with the highest salaries for Data Analyst roles, I analyzed the average salary linked to individual skills across job postings. This query highlights the technologies that appear to offer the strongest earning potential in the data analytics field.
```SQL
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
```

| Skill        | Average Salary (USD) |
|--------------|---------------------:|
| svn          | 400,000 |
| solidity     | 179,000 |
| couchbase    | 160,515 |
| datarobot    | 155,486 |
| golang       | 155,000 |
| mxnet        | 149,000 |
| dplyr        | 147,633 |
| vmware       | 147,500 |
| terraform    | 146,734 |
| twilio       | 138,500 |
| gitlab       | 134,126 |
| kafka        | 129,999 |
| puppet       | 129,820 |
| keras        | 127,013 |
| pytorch      | 125,226 |
| perl         | 124,686 |
| ansible      | 124,370 |
| hugging face | 123,950 |
| tensorflow   | 120,647 |
| cassandra    | 118,407 |
| notion       | 118,092 |
| atlassian    | 117,966 |
| bitbucket    | 116,712 |
| airflow      | 116,387 |
| scala        | 115,480 |


### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development

```SQL
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Poland'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
```

| Skill ID | Skill      | Demand Count | Average Salary (USD) |
|---------:|------------|-------------:|---------------------:|
| 0        | sql        | 3,083        | 96,435 |
| 181      | excel      | 2,143        | 86,419 |
| 1        | python     | 1,840        | 101,512 |
| 182      | tableau    | 1,659        | 97,978 |
| 5        | r          | 1,073        | 98,708 |
| 183      | power bi   | 1,044        | 92,324 |
| 188      | word       | 527          | 82,941 |
| 196      | powerpoint | 524          | 88,316 |
| 186      | sas        | 500          | 93,707 |

# What I Learned

- **Complex Query Crafting:** Learned more about advanced SQL, merging tables and wielding WITH clauses.
- **Data Aggregation:** Get more confident with GROUP BY, COUNT(), AVG().
- **Understand and solving a real problems:** Leveled up my skills in turning questions into actionable, insightful SQL queries.

### Closing Thoughts

Through this project, I improved my SQL skills and gained valuable insight into the data analyst job market.
The findings can server as a useful reference for prioritizing skill development and making more informed career decisions.
For aspiring data analysts, focusing on skills that are both in demand and well paid can create a stronger position in a competitive industry.
