
/*
Database: PostgreSQL
Purpose: Raw data preparation, staging transformation, and data quality validation.
Dataset: Telco Customer Churn (Kaggle)
Expected Records : 7043
*/


-- =====================================================
-- 1. RAW DATA LAYER
-- =====================================================

CREATE SCHEMA IF NOT EXISTS raw;

/*
 OBJECTIVE:
   Store the original CSV data in the raw layer.

   WHY TEXT DATA TYPES?
   Source columns are initially imported as TEXT to avoid
   import failures caused by blank or whitespace-only values
   in columns that should eventually be numeric.

   Data type conversion is performed in the staging layer.
*/

CREATE TABLE IF NOT EXISTS raw.telco_customer_churn (
    customer_id TEXT,
    gender TEXT,
    senior_citizen TEXT,
    partner TEXT,
    dependents TEXT,
    tenure TEXT,
    phone_service TEXT,
    multiple_lines TEXT,
    internet_service TEXT,
    online_security TEXT,
    online_backup TEXT,
    device_protection TEXT,
    tech_support TEXT,
    streaming_tv TEXT,
    streaming_movies TEXT,
    contract TEXT,
    paperless_billing TEXT,
    payment_method TEXT,
    monthly_charges TEXT,
    total_charges TEXT,
    churn TEXT
);


-- =====================================================
-- 2. RAW DATA VALIDATION
-- =====================================================

-- Verify imported record count.
SELECT COUNT(*) AS raw_record_count FROM raw.telco_customer_churn;

-- Inspect source records.
SELECT * FROM raw.telco_customer_churn
LIMIT 10;

-- Identify blank TotalCharges values in the source data.
SELECT COUNT(*) AS blank_total_charges FROM raw.telco_customer_churn
WHERE TRIM(total_charges) = '';


-- =====================================================
-- 3. STAGING LAYER: DATA CLEANING & TRANSFORMATION
-- =====================================================

CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.telco_customer_churn;

CREATE TABLE staging.telco_customer_churn AS
SELECT
    NULLIF(TRIM(customer_id), '') AS customer_id,
    NULLIF(TRIM(gender), '') AS gender,
    NULLIF(TRIM(senior_citizen), '')::INTEGER AS senior_citizen,
    NULLIF(TRIM(partner), '') AS partner,
    NULLIF(TRIM(dependents), '') AS dependents,
    NULLIF(TRIM(tenure), '')::INTEGER AS tenure,
    NULLIF(TRIM(phone_service), '') AS phone_service,
    NULLIF(TRIM(multiple_lines), '') AS multiple_lines,
    NULLIF(TRIM(internet_service), '') AS internet_service,
    NULLIF(TRIM(online_security), '') AS online_security,
    NULLIF(TRIM(online_backup), '') AS online_backup,
    NULLIF(TRIM(device_protection), '') AS device_protection,
    NULLIF(TRIM(tech_support), '') AS tech_support,
    NULLIF(TRIM(streaming_tv), '') AS streaming_tv,
    NULLIF(TRIM(streaming_movies), '') AS streaming_movies,
    NULLIF(TRIM(contract), '') AS contract,
    NULLIF(TRIM(paperless_billing), '') AS paperless_billing,
    NULLIF(TRIM(payment_method), '') AS payment_method,
    NULLIF(TRIM(monthly_charges), '')::NUMERIC(10,2) AS monthly_charges,
    NULLIF(TRIM(total_charges), '')::NUMERIC(10,2) AS total_charges,
    NULLIF(TRIM(churn), '') AS churn
FROM raw.telco_customer_churn;


-- =====================================================
-- 4. RECORD COUNT RECONCILIATION
-- =====================================================

SELECT
    (SELECT COUNT(*) FROM raw.telco_customer_churn) AS raw_records,
    (SELECT COUNT(*) FROM staging.telco_customer_churn) AS staging_records,

    (SELECT COUNT(*) FROM raw.telco_customer_churn)
    -
    (SELECT COUNT(*) FROM staging.telco_customer_churn) AS record_difference;


-- =====================================================
-- 5. STAGING SCHEMA VALIDATION
-- =====================================================

SELECT column_name,data_type
FROM information_schema.columns
WHERE table_schema = 'staging' AND table_name = 'telco_customer_churn'
ORDER BY ordinal_position;


-- =====================================================
-- 6. MISSING VALUE ANALYSIS
-- =====================================================

SELECT column_name,
COUNT(*) FILTER (WHERE column_value IS NULL OR TRIM(column_value) = '') AS missing_count
FROM staging.telco_customer_churn AS t
CROSS JOIN LATERAL jsonb_each_text(to_jsonb(t)) AS column_data(column_name,column_value)
GROUP BY column_name
ORDER BY missing_count DESC, column_name;


-- =====================================================
-- 7. DUPLICATE CUSTOMER VALIDATION
-- =====================================================

SELECT customer_id,COUNT(*) AS occurrence_count
FROM staging.telco_customer_churn
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;


-- =====================================================
-- 8. NUMERIC RANGE VALIDATION
-- =====================================================

SELECT MIN(tenure) AS min_tenure,MAX(tenure) AS max_tenure,
MIN(monthly_charges) AS min_monthly_charges,MAX(monthly_charges) AS max_monthly_charges,
MIN(total_charges) AS min_total_charges,MAX(total_charges) AS max_total_charges
FROM staging.telco_customer_churn;


-- =====================================================
-- 9. CATEGORY VALUE VALIDATION
-- =====================================================

SELECT DISTINCT gender
FROM staging.telco_customer_churn
ORDER BY gender;

SELECT DISTINCT contract
FROM staging.telco_customer_churn
ORDER BY contract;

SELECT DISTINCT internet_service
FROM staging.telco_customer_churn
ORDER BY internet_service;

SELECT DISTINCT payment_method
FROM staging.telco_customer_churn
ORDER BY payment_method;

SELECT DISTINCT churn
FROM staging.telco_customer_churn
ORDER BY churn;