-- ============================================================
--   HR Analytics — Attrition Intelligence
--   SQL Analysis Queries
--   Author  : Mohd Faij
--   Dataset : IBM HR Analytics Employee Attrition (1,470 rows)
--   Engine  : MySQL 8.0+ / Compatible with PostgreSQL
-- ============================================================
--
--   SECTION INDEX
--   ─────────────────────────────────────────────────────────
--   1. Basic Counts & Overall Attrition        (Q01 – Q03)
--   2. Attrition by Demographics               (Q04 – Q07)
--   3. Attrition by Job & Department           (Q08 – Q13)
--   4. Attrition by Compensation               (Q14 – Q17)
--   5. Attrition by Tenure & Promotions        (Q18 – Q21)
--   6. Attrition by Performance & Relations    (Q22 – Q24)
--   7. Advanced Multi-Condition Analysis       (Q25 – Q32)
--   8. Dashboard Validation Queries            (Q33 – Q35)
-- ============================================================


-- ============================================================
-- SECTION 1 — Basic Counts & Overall Attrition
-- ============================================================

-- Q01. Total employees in the dataset
SELECT COUNT(*) AS total_employees
FROM hr_attrition;

-- ──────────────────────────────────────────────────────────

-- Q02. Attrition count — Yes vs No
SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q03. Overall attrition rate (%)
SELECT
    CONCAT(
        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2),
    '%') AS overall_attrition_rate
FROM hr_attrition;


-- ============================================================
-- SECTION 2 — Attrition by Demographics
-- ============================================================

-- Q04. Attrition by gender — count and rate
SELECT
    Gender,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY Gender;

-- ──────────────────────────────────────────────────────────

-- Q05. Attrition by age group — count and rate
SELECT
    CASE
        WHEN Age < 25            THEN '<25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END                                                                               AS age_group,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY age_group
ORDER BY age_group;

-- ──────────────────────────────────────────────────────────

-- Q06. Attrition by marital status — count and rate
SELECT
    MaritalStatus,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY MaritalStatus
ORDER BY attrition_count DESC;

-- ──────────────────────────────────────────────────────────

-- Q07. Attrition by education field — count and rate
SELECT
    EducationField,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY EducationField
ORDER BY attrition_count DESC;


-- ============================================================
-- SECTION 3 — Attrition by Job & Department
-- ============================================================

-- Q08. Attrition by department — count and rate
SELECT
    Department,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY Department
ORDER BY attrition_rate DESC;

-- ──────────────────────────────────────────────────────────

-- Q09. Attrition by job role — count and rate
SELECT
    JobRole,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY JobRole
ORDER BY attrition_count DESC;

-- ──────────────────────────────────────────────────────────

-- Q10. Attrition by job level — count and rate
SELECT
    JobLevel,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY JobLevel
ORDER BY JobLevel;

-- ──────────────────────────────────────────────────────────

-- Q11. Attrition by overtime status — count and rate
SELECT
    OverTime,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY OverTime;

-- ──────────────────────────────────────────────────────────

-- Q12. Attrition by job satisfaction score (1–4)
SELECT
    JobSatisfaction,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- ──────────────────────────────────────────────────────────

-- Q13. Attrition by work-life balance score (1–4)
SELECT
    WorkLifeBalance,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;


-- ============================================================
-- SECTION 4 — Attrition by Compensation
-- ============================================================

-- Q14. Average monthly income — leavers vs stayers
SELECT
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q15. Attrition by salary bracket — Low / Medium / High
--      Uses NTILE(3) for MySQL compatibility
--      (Replace with PERCENTILE_CONT if using PostgreSQL)
WITH salary_tiles AS (
    SELECT
        MonthlyIncome,
        NTILE(3) OVER (ORDER BY MonthlyIncome) AS salary_tier
    FROM hr_attrition
),
salary_brackets AS (
    SELECT
        h.*,
        CASE
            WHEN s.salary_tier = 1 THEN 'Low'
            WHEN s.salary_tier = 2 THEN 'Medium'
            ELSE 'High'
        END AS salary_bracket
    FROM hr_attrition h
    JOIN salary_tiles s ON h.MonthlyIncome = s.MonthlyIncome
)
SELECT
    salary_bracket,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM salary_brackets
GROUP BY salary_bracket
ORDER BY FIELD(salary_bracket, 'Low', 'Medium', 'High');

-- ──────────────────────────────────────────────────────────

-- Q16. Attrition by stock option level (0–3)
SELECT
    StockOptionLevel,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY StockOptionLevel
ORDER BY StockOptionLevel;

-- ──────────────────────────────────────────────────────────

-- Q17. Average percent salary hike — leavers vs stayers
SELECT
    Attrition,
    ROUND(AVG(PercentSalaryHike), 2) AS avg_percent_salary_hike
FROM hr_attrition
GROUP BY Attrition;


-- ============================================================
-- SECTION 5 — Attrition by Tenure & Promotions
-- ============================================================

-- Q18. Average years at company — leavers vs stayers
SELECT
    Attrition,
    ROUND(AVG(YearsAtCompany), 2) AS avg_years_at_company
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q19. Attrition by years-at-company bracket
SELECT
    CASE
        WHEN YearsAtCompany < 1            THEN '<1'
        WHEN YearsAtCompany BETWEEN 1 AND 2 THEN '1-2'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5'
        ELSE '5+'
    END                                                                               AS years_bracket,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY years_bracket
ORDER BY FIELD(years_bracket, '<1', '1-2', '3-5', '5+');

-- ──────────────────────────────────────────────────────────

-- Q20. Average years since last promotion — leavers vs stayers
SELECT
    Attrition,
    ROUND(AVG(YearsSinceLastPromotion), 2) AS avg_years_since_last_promotion
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q21. Attrition by number of companies previously worked at
SELECT
    NumCompaniesWorked,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY NumCompaniesWorked
ORDER BY NumCompaniesWorked;


-- ============================================================
-- SECTION 6 — Attrition by Performance & Relationships
-- ============================================================

-- Q22. Attrition by performance rating (1–4)
SELECT
    PerformanceRating,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY PerformanceRating
ORDER BY PerformanceRating;

-- ──────────────────────────────────────────────────────────

-- Q23. Attrition by relationship satisfaction (1–4)
SELECT
    RelationshipSatisfaction,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY RelationshipSatisfaction
ORDER BY RelationshipSatisfaction;

-- ──────────────────────────────────────────────────────────

-- Q24. Attrition by environment satisfaction (1–4)
SELECT
    EnvironmentSatisfaction,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;


-- ============================================================
-- SECTION 7 — Advanced Multi-Condition Analysis
-- ============================================================

-- Q25. Top 5 job roles by attrition count
SELECT
    JobRole,
    COUNT(*) AS attrition_count
FROM hr_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY attrition_count DESC
LIMIT 5;

-- ──────────────────────────────────────────────────────────

-- Q26. Department with the single highest attrition rate (CTE)
WITH dept_rates AS (
    SELECT
        Department,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
    FROM hr_attrition
    GROUP BY Department
)
SELECT
    Department,
    CONCAT(ROUND(attrition_rate, 2), '%') AS attrition_rate
FROM dept_rates
ORDER BY attrition_rate DESC
LIMIT 1;

-- ──────────────────────────────────────────────────────────

-- Q27. Most common OverTime × JobSatisfaction combinations among leavers
SELECT
    OverTime,
    JobSatisfaction,
    COUNT(*) AS count
FROM hr_attrition
WHERE Attrition = 'Yes'
GROUP BY OverTime, JobSatisfaction
ORDER BY count DESC
LIMIT 5;

-- ──────────────────────────────────────────────────────────

-- Q28. Average income and average tenure by department and attrition status
SELECT
    Department,
    Attrition,
    ROUND(AVG(MonthlyIncome), 2)  AS avg_income,
    ROUND(AVG(YearsAtCompany), 2) AS avg_years
FROM hr_attrition
GROUP BY Department, Attrition
ORDER BY Department, Attrition;

-- ──────────────────────────────────────────────────────────

-- Q29. High attrition risk profile — overtime + low satisfaction
SELECT
    COUNT(*)                                                                                        AS high_risk_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                                             AS left_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%')  AS attrition_rate
FROM hr_attrition
WHERE OverTime = 'Yes'
  AND JobSatisfaction <= 2;

-- ──────────────────────────────────────────────────────────

-- Q30. Correlation base — average satisfaction scores: leavers vs stayers
SELECT
    Attrition,
    ROUND(AVG(JobSatisfaction),          2) AS avg_job_satisfaction,
    ROUND(AVG(WorkLifeBalance),          2) AS avg_work_life_balance,
    ROUND(AVG(RelationshipSatisfaction), 2) AS avg_relationship_satisfaction,
    ROUND(AVG(EnvironmentSatisfaction),  2) AS avg_environment_satisfaction
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q31. Attrition rate by tenure bracket × top 5 job roles (CTE + JOIN)
WITH top_roles AS (
    SELECT JobRole
    FROM hr_attrition
    WHERE Attrition = 'Yes'
    GROUP BY JobRole
    ORDER BY COUNT(*) DESC
    LIMIT 5
)
SELECT
    tr.JobRole,
    CASE
        WHEN YearsAtCompany < 2              THEN '0-2'
        WHEN YearsAtCompany BETWEEN 2 AND 5  THEN '2-5'
        ELSE '5+'
    END                                                                               AS tenure_bracket,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition h
JOIN top_roles tr ON h.JobRole = tr.JobRole
GROUP BY tr.JobRole, tenure_bracket
ORDER BY tr.JobRole, tenure_bracket;

-- ──────────────────────────────────────────────────────────

-- Q32. Department-wise attrition rate + average monthly income
SELECT
    Department,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate,
    ROUND(AVG(MonthlyIncome), 2)                                                      AS avg_monthly_income
FROM hr_attrition
GROUP BY Department
ORDER BY attrition_rate DESC;


-- ============================================================
-- SECTION 8 — Dashboard Validation Queries
-- (Directly validates Power BI Key Influencers findings)
-- ============================================================

-- Q33. Triple compound high-risk segment:
--      Overtime + Low Satisfaction + Early Tenure (≤2 yrs)
--      Validates the "High Risk Category" definition used in Power BI
SELECT
    JobRole,
    Department,
    COUNT(*)  AS high_risk_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
WHERE OverTime       = 'Yes'
  AND JobSatisfaction <= 2
  AND YearsAtCompany  <= 2
GROUP BY JobRole, Department
ORDER BY high_risk_count DESC;

-- ──────────────────────────────────────────────────────────

-- Q34. Promotion gap analysis — validates dashboard finding:
--      "Employees forgotten for years leave at higher rates"
SELECT
    Attrition,
    ROUND(AVG(YearsAtCompany - YearsSinceLastPromotion), 2) AS avg_promotion_gap,
    ROUND(AVG(YearsSinceLastPromotion), 2)                  AS avg_years_since_promotion,
    ROUND(AVG(YearsAtCompany), 2)                           AS avg_years_at_company
FROM hr_attrition
GROUP BY Attrition;

-- ──────────────────────────────────────────────────────────

-- Q35. Income threshold validation — $13,758/mo
--      Directly validates Power BI AI Key Influencers finding:
--      "MonthlyIncome > 13,758 → 1.17× more likely to stay"
SELECT
    CASE
        WHEN MonthlyIncome >= 13758 THEN 'Above $13,758'
        ELSE 'Below $13,758'
    END                                                                               AS income_segment,
    COUNT(*)                                                                          AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                               AS attrition_count,
    CONCAT(ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2), '%') AS attrition_rate
FROM hr_attrition
GROUP BY income_segment
ORDER BY income_segment DESC;


-- ============================================================
-- END OF FILE
-- HR Analytics — Attrition Intelligence | SQL Analysis
-- Author: Mohd Faij
-- ============================================================
