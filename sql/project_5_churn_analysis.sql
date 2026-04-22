/*
## Assumptions & Limitations
- Lack of Time-Series Precision: The dataset only provides `MonthsSubscribed` (tenure) rather than exact signup and cancellation dates. This prevents true seasonal trend analysis or exact cohort tracking based on market events.
- Missing Behavioral Telemetry: Churn is analyzed solely on billing demographics and static service flags. Real business contexts require product usage data (e.g., login frequency, specific feature adoption) to accurately identify churn intent before the billing cycle ends.
- Revenue vs. Profit: The data tracks Monthly Recurring Revenue (MRR) but lacks Customer Acquisition Cost (CAC) or cost-to-serve metrics. Any lifetime value derived from this data represents gross revenue, not actual business profitability.
*/

/*
Query 1: Churn Rate by Contract Type
- Business Question: Which contract type exhibits the highest churn rate, indicating where retention and upselling efforts should be focused?
- Tables/Columns: `cleaned_saas_churn` (Contract, customerID, Churn_Flag).
- Expected Output: 3 columns (Contract, Total_Customers, Churn_Rate_Pct) with one row per contract type.
*/

SELECT 
	Contract,
    COUNT(customerID) AS Total_Customers,
    ROUND(AVG(CASE WHEN Churn_Flag = 1 THEN 1 else 0 END) * 100, 2) AS Churn_Rate_Pct
FROM cleaned_saas_churn
GROUP BY Contract;

/*
Query 2: Revenue at Risk by Contract Type
- Business Question: How much Monthly Recurring Revenue (MRR) is being lost to churned customers across different contract types?
- Tables/Columns: `cleaned_saas_churn` (Contract, MRR, Churn_Flag).
- Expected Output: 2 columns (Contract, Lost_MRR) filtered strictly to churned customers, ordered by highest lost revenue.
*/

SELECT 
	Contract,
    SUM(MRR) AS Lost_MRR
FROM cleaned_saas_churn
WHERE Churn_Flag = 1
GROUP BY Contract
ORDER BY Lost_MRR DESC;

/*
Query 3: Top 10 Highest-MRR Churned Customers and Revenue Contribution
- Business Question: Who are the 10 most valuable customers we lost, and what percentage of our total churned revenue do they individually represent?
- Tables/Columns: `cleaned_saas_churn` (customerID, MRR, Churn_Flag).
- Expected Output: 3 columns (customerID, Lost_MRR, Pct_Of_Total_Churn_Rev). Requires a subquery or CTE to calculate the total churned MRR for the percentage math.
*/

WITH lost_mrr AS (
	SELECT 
		SUM(MRR) AS Lost_MRR
	FROM cleaned_saas_churn
    WHERE Churn_Flag = 1
)

SELECT 
	customerID,
    SUM(MRR) AS Lost_MRR,
    ROUND((SUM(MRR) / (SELECT Lost_MRR FROM lost_mrr)) * 100, 4) AS Pct_Of_Total_Churn_Rev
FROM cleaned_saas_churn
WHERE Churn_Flag = 1
GROUP BY customerID
ORDER BY Lost_MRR DESC LIMIT 10;

/*
Query 4: Churn Rate by Engineered Signup Cohort
- Business Question: How does churn behave across different historical signup cohorts? Are newer cohorts churning faster than older ones?
- Tables/Columns: `cleaned_saas_churn` (MonthsSubscribed, Churn_Flag).
- Expected Output: 3 columns (cohort, Total_Customers, Churn_Rate_Pct). Requires engineering a proxy signup month by subtracting `MonthsSubscribed` from a static anchor date ('2023-12-01').
*/

SELECT
    DATE_FORMAT(DATE_SUB('2023-12-01', INTERVAL MonthsSubscribed MONTH), '%Y-%m') AS cohort,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) * 100, 2) AS Churn_Rate_Pct
FROM cleaned_saas_churn
GROUP BY cohort
ORDER BY cohort;

/*
Query 5: Top Decile Churn Rate
- Business Question: What is the churn rate of our highest-revenue decile (top 10% of customers by MRR), and what does this imply for business risk?
- Tables/Columns: `cleaned_saas_churn` (customerID, MRR, Churn_Flag).
- Expected Output: 3 columns (bucket, Total_Customers, Churn_Rate_Pct) filtering strictly to the top revenue decile.
*/

WITH ranking AS (
	SELECT
		customerID,
        NTILE(10) OVER(ORDER BY MRR DESC) AS bucket,
        MRR,
        Churn_Flag
	FROM cleaned_saas_churn
)

SELECT
    bucket,
    COUNT(customerID) AS Total_Customers,
    ROUND(AVG(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) * 100, 2) AS Churn_Rate_Pct
FROM ranking
WHERE bucket = 1
GROUP BY bucket;