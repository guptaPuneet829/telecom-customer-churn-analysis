/*
Database: PostgreSQL
Purpose: Investigate customer churn patterns across pricing,
         contracts, tenure, services, and payment behaviour.
*/

-- =====================================================
-- 1. CUSTOMER DEMOGRAPHICS
-- =====================================================

-- 1.1 Gender-wise customer churn

SELECT gender,COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY gender
ORDER BY gender;

-- =====================================================
-- 2. CHARGES AND CONTRACT ANALYSIS
-- =====================================================

-- 2.1 Monthly and total charges by churn status

SELECT churn,COUNT(*) AS customer_count,
ROUND(AVG(total_charges),2) AS avg_total_charges,
ROUND(AVG(monthly_charges),2) AS avg_monthly_charges,
ROUND(MIN(monthly_charges),2) AS min_monthly_charges,
ROUND(MAX(monthly_charges),2) AS max_monthly_charges
FROM staging.telco_customer_churn
GROUP BY churn
ORDER BY churn;

-- 2.2 Contract-wise churn and average monthly charges

SELECT contract,churn,COUNT(*) AS customer_count,
ROUND(AVG(monthly_charges),2) AS avg_monthly_charges,
ROUND(
COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY contract),2
) AS percentage_with_contact
FROM staging.telco_customer_churn
GROUP BY contract,churn
ORDER BY contract, churn;

-- 2.3 Monthly charge segments across contract types

WITH customer_segment AS(
    SELECT customer_id,contract,churn,monthly_charges,
    CASE
    WHEN monthly_charges < 40 THEN 'Low'
    WHEN monthly_charges < 70 THEN 'Medium'
    WHEN monthly_charges < 100 THEN 'High'
    ELSE 'Very High'
    END AS price_segment
    FROM staging.telco_customer_churn
)
SELECT contract,price_segment,COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE churn='Yes') AS churned_customers,
ROUND(
    COUNT(*) FILTER(WHERE churn='Yes')*100.0/COUNT(*),2
)AS churn_rate
FROM customer_segment
GROUP BY contract,price_segment
ORDER BY contract,price_segment;

-- =====================================================
-- 3. CUSTOMER TENURE ANALYSIS
-- =====================================================

-- 3.1 Tenure-based churn across contract types

WITH tenure_segment AS (
    SELECT contract,churn,\
    CASE
    WHEN tenure <= 12 THEN '0-12 Months'
    WHEN tenure <= 24 THEN '13-24 Months'
    WHEN tenure <= 48 THEN '25-48 Months'
    ELSE '49-72 Months'
    END AS tenure_group
    FROM staging.telco_customer_churn
)
SELECT contract,tenure_group,COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM tenure_segment
GROUP BY contract, tenure_group
ORDER BY contract, tenure_group;

-- =====================================================
-- 4. INTERNET SERVICE ANALYSIS
-- =====================================================

-- 4.1 Churn across internet service types

SELECT internet_service,COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE churn='Yes') AS churned_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2 ) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY internet_service
ORDER BY internet_service

-- 4.2 Internet service and contract-wise churn

SELECT internet_service,contract,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2
) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY internet_service, contract
ORDER BY internet_service, contract;

-- =====================================================
-- 5. ADDITIONAL SERVICE ANALYSIS
-- =====================================================

-- 5.1 Online security and customer churn

SELECT online_security,
COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE churn='Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2 ) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY online_security
ORDER BY online_security;

-- 5.2 Online security and internet service

SELECT internet_service,online_security,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY internet_service,online_security
ORDER BY internet_service,online_security;

-- 5.3 Tech support and customer churn

SELECT tech_support,
COUNT(*) AS total_customers,
COUNT(*) FILTER(WHERE churn='Yes') AS churned_customers,
ROUND(COUNT(*) FILTER(WHERE churn='Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY tech_support
ORDER BY tech_support;

-- 5.4 Tech support and internet service

SELECT internet_service,tech_support,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY internet_service,tech_support
ORDER BY internet_service,tech_support;

-- 5.5 Combined impact of tech support and online security
--     across internet service types

SELECT internet_service,tech_support,online_security,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY internet_service,tech_support,online_security
ORDER BY churn_rate DESC;

-- =====================================================
-- 6. PAYMENT METHOD ANALYSIS
-- =====================================================

-- 6.1 Payment method and customer churn

SELECT payment_method,COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY payment_method
ORDER BY payment_method;

-- 6.2 Payment method and contract-wise churn

SELECT contract,payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY contract,payment_method
ORDER BY contract,payment_method;

-- =====================================================
-- 7. PAPERLESS BILLING ANALYSIS
-- =====================================================

-- 7.1 Paperless billing and customer churn

SELECT paperless_billing,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY paperless_billing
ORDER BY paperless_billing;

-- 7.2 Paperless billing and payment method

SELECT paperless_billing,payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY paperless_billing,payment_method
ORDER BY paperless_billing,payment_method;

-- =====================================================
-- 8. COMBINED CUSTOMER SEGMENT ANALYSIS
-- =====================================================

-- 8.1 Contract, paperless billing, and payment method

SELECT contract,paperless_billing,payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),2
) AS churn_rate
FROM staging.telco_customer_churn
GROUP BY contract,paperless_billing,payment_method
ORDER BY churn_rate DESC;