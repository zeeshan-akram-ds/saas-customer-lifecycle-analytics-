# SaaS Customer Churn & Revenue Risk Analysis

This project analyzes customer churn in a telecommunications SaaS business to identify high-risk segments, quantify the direct revenue impact, and provide data-driven targets for retention strategies.

## Dashboard Previews
*(Insert screenshots below)*

**Page 1: Executive Summary**
![Executive Summary](screenshots/page_1_dashboard.png)

**Page 2: Segment Targeting & Action**
![Segment Targeting](screenshots/page_2_dashboard.png)

## Business Objective
- Pinpoint the specific operational and demographic segments driving customer churn.
- Quantify the Monthly Recurring Revenue (MRR) at risk and project the 90-day financial penalty of inaction.
- Determine the exact tenure lifecycle stage where churn stabilizes to guide the timing of retention interventions.

## Tech Stack & Pipeline
This project executes a complete data pipeline from raw extraction to executive visualization:
- **Python (Pandas):** Data cleaning, type coercion, missing value handling, and exploratory data analysis.
- **Dimensional Modeling:** Engineered a star schema (Fact and Dimension tables) to map operational data to standard SaaS business metrics.
- **Database Ingestion (SQLAlchemy & MySQL):** Automated the ETL process by writing explicit Data Definition Language (DDL) scripts and securely pushing the cleaned data into a local MySQL instance using environment variables (`.env`).
- **SQL Analytics:** Wrote advanced queries (conditional aggregations, CTEs) to extract specific business insights regarding contract churn and revenue risk.
- **Power BI:** Built a 2-page executive dashboard with operational slicers, conditional formatting, and custom DAX measures for dynamic text generation.

## Key Insights
- **Contract Type is the Primary Churn Driver:** Month-to-month customers exhibit a 42.7% churn rate, compared to just 11.3% for one-year and 2.8% for two-year contracts.
- **Immediate Revenue Impact:** The current churn rate results in $139,130 of lost MRR. Month-to-month cancellations account for 86.9% ($121K) of this lost revenue.
- **90-Day Projected Risk:** If no action is taken, the business risks losing ~$417,000 in unrealized revenue over the next three months.
- **The Year 1 Cliff:** Nearly 50% of all churn occurs within the first 12 months of a customer's lifecycle. Churn risk decreases linearly as tenure increases, stabilizing at around 10% after 48 months.
- **Diffuse Revenue Risk, Not Account Concentration:** While the top 10% highest-paying tier churns at an alarming 24.68% (mirroring the 26.5% baseline), the highest individual lost account is only $118/month (<0.09% of total churned revenue). The business does not face enterprise 'whale' concentration risk; the financial bleeding is entirely driven by high-volume, low-MRR cancellations.
- **Highest Risk Cross-Section:** Month-to-month customers using Fiber Optic internet carry the highest localized churn rate in the business at 54.6%.

## Strategic Recommendations
1. **Shift Acquisition Strategy:** Stop incentivizing month-to-month signups. Reallocate marketing spend to acquire 1-year contracts, even at a higher Customer Acquisition Cost (CAC), to stabilize the Year 1 retention cliff.
2. **Targeted Intervention:** Execute an immediate retention campaign specifically targeting active Month-to-Month Fiber Optic users to address the 54.6% segment churn rate.

## Assumptions & Limitations
- **Lack of Time-Series Precision:** The dataset provides a static cross-sectional snapshot with no exact signup or churn event timestamps. This prevents true seasonal trend analysis or cohort tracking based on market events.
- **Missing Acquisition Metrics:** Marketing spend, customer acquisition cost (CAC), and campaign attribution data are absent, preventing any LTV:CAC profitability analysis.
- **Length Bias in Churn Calculation:** Longer-tenured customers are over-represented in the retained group, while newer customers have had less exposure time to churn, potentially understating true churn risk for recent sign-ups.
- **Blended MRR:** The overall average MRR blends active and churned customers, which overstates current revenue health. Once churned, a customer contributes $0 MRR; including their historical MRR inflates the metric.
- **Static Cohorts:** Tenure cohorts were explicitly binned into standard 12-month B2B SaaS annual contract renewal cycles. These cohorts ignore calendar time, meaning customers reaching the same tenure in different years experienced different pricing and product versions.
- **Perpetual Loss Assumption:** The Revenue at Risk calculation assumes churned customers would continue paying their final MRR indefinitely, which may overstate the true loss by ignoring potential natural downgrades.