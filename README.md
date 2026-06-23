# Customer Churn Analysis

## Project Overview

Customer retention is a critical business challenge for subscription-based companies, as losing customers directly impacts recurring revenue and long-term profitability.

This project analyzes customer demographics, service subscriptions, billing behavior, contract information, and account tenure to identify the key factors driving customer churn. Using Python, SQL, and Power BI, the project demonstrates an end-to-end analytics workflow from data preparation and exploratory analysis to dashboard development and business recommendations.

**Dataset:** IBM Telco Customer Churn Dataset

**Tools Used:** Python (Pandas, NumPy, Matplotlib, Seaborn), SQL, Power BI, GitHub

---

## Business Problem

This project addresses the following business questions:

- What is the overall customer churn rate?
- Which customer segments are most likely to churn?
- How does contract type influence retention?
- What impact do services and billing behavior have on churn?
- Which factors indicate elevated churn risk?
- What actions can improve customer retention?

---

## Dataset Overview

The dataset contains customer demographic information, account details, service subscriptions, billing behavior, and churn outcomes.

| Metric | Value |
|---------|-------:|
| Original Records | 7,043 |
| Final Records | 7,032 |
| Features | 21 |
| Churned Customers | 1,869 |
| Retained Customers | 5,163 |
| Churn Rate | 26.58% |

---

## Data Preparation & EDA

The dataset was validated, cleaned, and transformed to ensure accurate churn analysis.

Key steps included:

- Converting `TotalCharges` from text to numeric format
- Identifying and removing 11 invalid records with missing lifetime charges
- Verifying customer-level uniqueness and data consistency
- Checking missing values and duplicate records
- Analyzing churn patterns across contract type, tenure, billing behavior, service adoption, and customer demographics

The final analytical dataset contained 7,032 customer records and was used for SQL analysis and Power BI dashboard development.

---

## SQL Analysis

SQL was used to validate business metrics, analyze churn drivers, identify high-risk customer groups, and support business decision-making.

Analysis areas included:

- KPI Analysis
- Contract Analysis
- Customer Tenure Analysis
- Revenue Analysis
- Demographic Analysis
- Service Usage Analysis
- Billing Analysis
- Customer Risk Segmentation

### Sample Query

```sql
SELECT
    Contract,
    ROUND(
        AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
        2
    ) AS churn_rate
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate DESC;
