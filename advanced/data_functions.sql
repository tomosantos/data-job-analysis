SELECT 
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;

-- converting
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE as date
FROM job_postings_fact;


-- time zone
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM job_postings_fact
LIMIT 10;

-- extract
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM job_postings_fact
LIMIT 10;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY date_month
ORDER BY job_posted_count DESC;

-- practice problem
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;
