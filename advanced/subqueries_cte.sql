-- CTE
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;


-- subquery
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
)


-- CTEs
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS job_postings
    FROM 
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    cd.name AS company_name,
    cj.job_postings
FROM 
    company_dim cd
LEFT JOIN 
    company_job_count cj
    ON cd.company_id = cj.company_id
ORDER BY
    job_postings DESC;

-- practice problem
WITH remote_job_skills AS (
    SELECT
        sj.skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS sj
    INNER JOIN job_postings_fact AS jp ON jp.job_id = sj.job_id
    WHERE
        jp.job_work_from_home = True
        AND jp.job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)

SELECT 
    sk.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills rm
INNER JOIN skills_dim AS sk ON sk.skill_id = rm.skill_id
ORDER BY skill_count DESC
LIMIT 10;