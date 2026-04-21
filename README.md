# SaaS Customer Churn & Revenue Risk Analysis

This project analyzes customer churn in a telecommunications SaaS business to identify high-risk segments, quantify the direct revenue impact (MRR), and provide data-driven targets for retention strategies. 

## Business Objective
- Pinpoint the specific operational and demographic segments driving customer churn.
- Quantify the Monthly Recurring Revenue (MRR) at risk.
- Determine the exact tenure lifecycle stage where churn stabilizes to guide the timing of retention interventions.

## Tech Stack & Pipeline
This project executes a complete data pipeline from raw extraction to executive visualization:
- **Python (Pandas):** Data cleaning, type coercion, missing value handling, and exploratory data analysis.
- **Dimensional Modeling:** Engineered a star schema (Fact and Dimension tables) to map operational data to standard SaaS business metrics.
- **Database Ingestion (SQLAlchemy & MySQL):** Automated the ETL process by writing explicit Data Definition Language (DDL) scripts and securely pushing the cleaned data into a local MySQL instance using environment variables (`.env`).
- **SQL Analytics:** Wrote advanced queries (conditional aggregations, CTEs) to extract specific business insights regarding contract churn and revenue risk.
- **Power BI:** Built a Page 1 Executive Summary dashboard with operational slicers and side-by-side visual layouts to present a clean, high-density reporting view.

## Key Insights
- **Contract Type is the Primary Churn Driver:** Month-to-month customers exhibit a 42.7% churn rate, compared to just 2.8% for two-year contracts.
- **Revenue Impact:** The current churn rate results in roughly $139,000 of lost MRR. Month-to-month cancellations account for the vast majority ($120,847) of this lost revenue.
- **The Year 1 Cliff:** Nearly half of all churn occurs within the first 12 months of a customer's lifecycle. Churn risk decreases linearly as tenure increases, stabilizing at around 10% after 48 months.
- **Revenue Concentration Risk:** The top 10 highest-MRR churned customers each represent less than 0.09% of the total churned revenue, indicating the business suffers from highly diffuse churn rather than individual account concentration risk.

## Assumptions & Limitations
- **Lack of Time-Series Precision:** The dataset provides a static cross-sectional snapshot with no exact signup or churn event timestamps. This prevents true seasonal trend analysis or cohort tracking based on market events.
- **Missing Acquisition Metrics:** Marketing spend, customer acquisition cost (CAC), and campaign attribution data are absent, preventing any LTV:CAC profitability analysis.
- **Length Bias in Churn Calculation:** Longer-tenured customers are over-represented in the retained group, while newer customers have had less exposure time to churn, potentially understating true churn risk for recent sign-ups.
- **Blended MRR:** The overall average MRR blends active and churned customers, which overstates current revenue health. Once churned, a customer contributes $0 MRR; including their historical MRR inflates the metric.
- **Static Cohorts:** Tenure cohorts were explicitly binned into standard 12-month B2B SaaS annual contract renewal cycles. These cohorts ignore calendar time, meaning customers reaching the same tenure in different years experienced different pricing and product versions.
- **Perpetual Loss Assumption:** The Revenue at Risk calculation assumes churned customers would continue paying their final MRR indefinitely, which may overstate the true loss by ignoring potential natural downgrades.