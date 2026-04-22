Query 1: Churn Rate by Contract Type
- Business Question: Which contract type exhibits the highest churn rate, indicating where retention and upselling efforts should be focused?
- Tables/Columns: `cleaned_saas_churn` (Contract, customerID, Churn_Flag).
- Expected Output: 3 columns (Contract, Total_Customers, Churn_Rate_Pct) with one row per contract type.
### Contract Type vs Churn Rate

| Contract Type  | Total Customers | Churn Rate (%) |
| -------------- | --------------- | -------------- |
| One year       | 1,473           | 11.27          |
| Month-to-month | 3,875           | 42.71          |
| Two year       | 1,695           | 2.83           |

**Key Insights:**
- Month-to-month customers have the **highest churn rate** at **42.71%**
- Two-year contract customers have the **lowest churn rate** at only **2.83%**

Query 2: Revenue at Risk by Contract Type
- Business Question: How much Monthly Recurring Revenue (MRR) is being lost to churned customers across different contract types?
- Tables/Columns: `cleaned_saas_churn` (Contract, MRR, Churn_Flag).
- Expected Output: 2 columns (Contract, Lost_MRR) filtered strictly to churned customers, ordered by highest lost revenue.
### Contract vs Lost MRR

| Contract       | Lost MRR     |
|----------------|--------------|
| Month-to-month | 120,847.10   |
| One year       | 14,118.45    |
| Two year       | 4,165.30     |

**Highest Lost MRR:** Month-to-month ($120,847.10)  
**Lowest Lost MRR:** Two year ($4,165.30)

Query 3: Top 10 Highest-MRR Churned Customers and Revenue Contribution
- Business Question: Who are the 10 most valuable customers we lost, and what percentage of our total churned revenue do they individually represent?
- Tables/Columns: `cleaned_saas_churn` (customerID, MRR, Churn_Flag).
- Expected Output: 3 columns (customerID, Lost_MRR, Pct_Of_Total_Churn_Rev). Requires a subquery or CTE to calculate the total churned MRR for the percentage math.
### Customer Churn Contribution

| customerID     | Lost_MRR | Pct_Of_Total_Churn_Rev |
|----------------|----------|------------------------|
| 8199-ZLLSA     | 118.35   | 0.0851                 |
| 2889-FPWRM     | 117.80   | 0.0847                 |
| 2302-ANTDP     | 117.45   | 0.0844                 |
| 9053-IZFKV     | 116.20   | 0.0835                 |
| 1444-WVSGW     | 115.65   | 0.0831                 |
| 0201-OAMXR     | 115.55   | 0.0831                 |
| 4361-BKAXE     | 114.50   | 0.0823                 |
| 1555-DJEQW     | 114.20   | 0.0821                 |
| 9158-VCTQB     | 113.60   | 0.0816                 |
| 7279-BUYWN     | 113.20   | 0.0814                 |

Query 4: Churn Rate by Engineered Signup Cohort
- Business Question: How does churn behave across different historical signup cohorts? Are newer cohorts churning faster than older ones?
- Tables/Columns: `cleaned_saas_churn` (MonthsSubscribed, Churn_Flag).
- Expected Output: 3 columns (cohort, Total_Customers, Churn_Rate_Pct). Requires engineering a proxy signup month by subtracting `MonthsSubscribed` from a static anchor date ('2023-12-01').

### Churn by Proxy Signup Cohort

| cohort  | Total_Customers | Churn_Rate_Pct |
| ------- | --------------- | -------------- |
| 2017-12 | 362             | 1.66           |
| 2018-01 | 170             | 3.53           |
| 2018-02 | 119             | 9.24           |
| 2018-03 | 95              | 8.42           |
| 2018-04 | 100             | 9.00           |
| 2018-05 | 98              | 10.20          |

*(Output truncated for brevity. Shows initial stable cohorts before the Year 1 drop-off begins to accelerate.)*

Query 5: Top Decile Churn Rate
- Business Question: What is the churn rate of our highest-revenue decile (top 10% of customers by MRR), and what does this imply for business risk?
- Tables/Columns: `cleaned_saas_churn` (customerID, MRR, Churn_Flag).
- Expected Output: 3 columns (bucket, Total_Customers, Churn_Rate_Pct) filtering strictly to the top revenue decile.

### Churn Rate of Top 10% MRR Customers

| bucket | Total_Customers | Churn_Rate_Pct |
| ------ | --------------- | -------------- |
| 1      | 705             | 24.68          |

## Key Insights
- **Diffuse Revenue Risk, Not Account Concentration:** While the top 10% highest-paying tier churns at an alarming 24.68% (mirroring the 26.5% baseline), the highest individual lost account is only $118/month (<0.09% of total churned revenue). The business does not face enterprise 'whale' concentration risk; the financial bleeding is entirely driven by high-volume, low-MRR cancellations.