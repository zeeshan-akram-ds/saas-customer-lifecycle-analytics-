# SaaS Customer Churn Analysis

This project analyzes customer churn in a telco SaaS business to find high-risk segments and measure the revenue impact.

## Objective
- Identify high-risk customer segments using usage and contract data.
- Quantify revenue at risk from churn.
- Provide clear insights to support retention efforts.

## Project Status
- **Data Integrity & Validation:** Completed. Fixed data types, handled hidden nulls in TotalCharges, and confirmed no anomalies in key metrics.
- **Schema Mapping:** Completed. Renamed columns to standard SaaS terms (MRR, LTV, MonthsSubscribed).
- **Baseline KPIs & Visualizations:** Completed. Calculated churn rate, average MRR (overall + active), revenue at risk, and built churn-by-contract chart.
- **Next Steps:** SQL queries, Power BI dashboard, and final retention recommendations.

## Tools Used
- Python (Pandas, Matplotlib)
- Jupyter Notebook

## Key Assumptions & Limitations
- Dataset is a single static snapshot with no event timestamps, so time-series or cohort analysis by signup date is not possible.
- No marketing spend or CAC data, which limits LTV:CAC or acquisition channel analysis.
- Churn rate has length bias: long-tenured customers dominate the retained group, making overall churn look lower than the risk for new sign-ups.
- Overall average MRR mixes active and churned customers, which overstates current revenue health.
- Tenure cohorts are static and ignore calendar time (product changes, pricing shifts, etc.).
- Revenue at Risk assumes churned customers would have kept their final MRR forever, which may overstate the loss.
- Churn rate chart by contract type does not show customer counts per contract, so high % on small groups can look more serious than they are.