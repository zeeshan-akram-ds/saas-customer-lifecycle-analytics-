# SaaS Customer Churn Analysis

This project analyzes churn behavior in a SaaS subscription business to identify at-risk segments and quantify the revenue impact of churn.

## Objective
- Identify high-risk customer segments using demographic and service-usage data.
- Quantify revenue at risk to prioritize retention interventions.
- Recommend data-driven actions to improve retention within the next 90 days.

## Project Status
- **Data Integrity & Validation:** Completed. Coerced data types, resolved hidden nulls, and verified statistical boundaries (MRR, tenure, LTV).
- **Schema Mapping:** Completed. Mapped operational raw data to SaaS business metrics (MRR, MonthsSubscribed).
- **Baseline KPIs:** Completed. Established baseline churn rates and revenue metrics.
- **Next Steps:** SQL analytical queries, Power BI dashboard development, and final business recommendations.

## Tools Used
- Python (Pandas, NumPy)
- Jupyter Notebook
- SQL (PostgreSQL)
- Power BI (In-progress)

## Key Assumptions & Limitations
* Static cross-sectional data (no time-series/event timestamps).
* Absence of marketing/acquisition cost (CAC) data.
* Length bias: retention data is over-represented by long-tenured customers.
* Active vs. Churned revenue blending in standard metrics.