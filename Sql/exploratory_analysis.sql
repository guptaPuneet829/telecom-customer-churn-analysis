-- Purpose: Exploratory analysis of overall customer churn.

-- =====================================================
-- 1. CUSTOMER DISTRIBUTION BY CHURN STATUS
-- =====================================================

SELECT churn,COUNT(*) AS customer_count,
ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER(),2) AS customer_percentage
FROM staging.telco_customer_churn
GROUP BY churn
ORDER BY churn;

-- =====================================================
-- 2. OVERALL CUSTOMER AND CHURN SUMMARY
-- =====================================================

SELECT COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
COUNT(*) FILTER (WHERE churn = 'No') AS retained_customers,
ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0/COUNT(*),2
) AS overall_churn_rate
FROM staging.telco_customer_churn;