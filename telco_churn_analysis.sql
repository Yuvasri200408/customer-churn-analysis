USE customer_churn_analysis;

-- DATA VALIDATION

SELECT COUNT(*) AS total_customers
FROM telco_churn;

SELECT COUNT(DISTINCT customerID) AS unique_customers
FROM telco_churn;

SELECT *
FROM telco_churn
LIMIT 10;

-- KPI ANALYSIS

SELECT
Churn,
COUNT(*) AS customers
FROM telco_churn
GROUP BY Churn;

SELECT
ROUND(
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
2
) AS churn_rate
FROM telco_churn;

SELECT
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
SUM(CASE WHEN Churn='No' THEN 1 ELSE 0 END) AS retained_customers
FROM telco_churn;

-- CONTRACT ANALYSIS

SELECT
Contract,
COUNT(*) AS customers
FROM telco_churn
GROUP BY Contract;

SELECT
Contract,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- TENURE ANALYSIS

SELECT
Churn,
ROUND(AVG(tenure),2) AS avg_tenure
FROM telco_churn
GROUP BY Churn;

SELECT
CASE
WHEN tenure <= 12 THEN 'First Year'
ELSE 'Long Term'
END AS tenure_group,
COUNT(*) AS customers,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY tenure_group;

SELECT
CASE
WHEN tenure <= 12 THEN 'New'
WHEN tenure <= 36 THEN 'Established'
ELSE 'Loyal'
END AS customer_segment,
COUNT(*) AS customers,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY customer_segment;

-- REVENUE ANALYSIS

SELECT
Churn,
ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge
FROM telco_churn
GROUP BY Churn;

SELECT
Churn,
ROUND(AVG(TotalCharges),2) AS avg_total_charge
FROM telco_churn
GROUP BY Churn;

SELECT
Churn,
ROUND(SUM(TotalCharges),2) AS total_revenue
FROM telco_churn
GROUP BY Churn;

SELECT
customerID,
TotalCharges
FROM telco_churn
ORDER BY TotalCharges DESC
LIMIT 10;

SELECT
customerID,
MonthlyCharges
FROM telco_churn
ORDER BY MonthlyCharges DESC
LIMIT 10;

-- DEMOGRAPHIC ANALYSIS

SELECT
gender,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY gender;

SELECT
SeniorCitizen,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY SeniorCitizen;

SELECT
Partner,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY Partner;

SELECT
Dependents,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY Dependents;

-- SERVICE ANALYSIS

SELECT
InternetService,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;

SELECT
TechSupport,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY TechSupport
ORDER BY churn_rate DESC;

SELECT
OnlineSecurity,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY OnlineSecurity
ORDER BY churn_rate DESC;

SELECT
OnlineBackup,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY OnlineBackup
ORDER BY churn_rate DESC;

SELECT
DeviceProtection,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY DeviceProtection
ORDER BY churn_rate DESC;

SELECT
StreamingTV,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY StreamingTV
ORDER BY churn_rate DESC;

SELECT
StreamingMovies,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY StreamingMovies
ORDER BY churn_rate DESC;


-- BILLING ANALYSIS

SELECT
PaymentMethod,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT
PaperlessBilling,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY PaperlessBilling;

-- ADVANCED SQL ANALYSIS

WITH contract_churn AS
(
SELECT
Contract,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY Contract
)
SELECT *
FROM contract_churn
ORDER BY churn_rate DESC;

SELECT
Contract,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate,
RANK() OVER
(
ORDER BY
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) DESC
) AS churn_rank
FROM telco_churn
GROUP BY Contract;

SELECT
customerID,
TotalCharges,
DENSE_RANK() OVER
(
ORDER BY TotalCharges DESC
) AS revenue_rank
FROM telco_churn;

SELECT
customerID,
MonthlyCharges,
NTILE(4) OVER
(
ORDER BY MonthlyCharges
) AS charge_quartile
FROM telco_churn;

SELECT
Contract,
PaymentMethod,
COUNT(*) AS customers,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;

SELECT
InternetService,
ROUND(AVG(MonthlyCharges),2) AS avg_monthly_charge,
ROUND(
AVG(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) * 100,
2
) AS churn_rate
FROM telco_churn
GROUP BY InternetService;

SELECT
customerID,
Contract,
TechSupport,
MonthlyCharges,
CASE
WHEN Contract='Month-to-month'
AND TechSupport='No'
AND MonthlyCharges > 70
THEN 'High Risk'
ELSE 'Low Risk'
END AS risk_level
FROM telco_churn;

CREATE OR REPLACE VIEW churn_summary AS
SELECT
    customerID,
    tenure,
    MonthlyCharges,
    TotalCharges,
    Churn
FROM telco_churn;
