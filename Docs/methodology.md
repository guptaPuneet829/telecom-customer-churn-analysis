# Project Methodology – Telecom Customer Churn Analysis

## 1. Dataset Collection

- Source: IBM Telco Customer Churn dataset from Kaggle.
- Total records: 7,043 customers.
- Total columns: 21.
- The dataset contains customer demographics, subscribed services, contract details, billing information, and churn status.

## 2. Data Ingestion

The source CSV was imported into PostgreSQL as a raw table.

**Raw Table:** `raw.telco_customer_churn`

All source columns were initially stored as `TEXT` to support reliable CSV ingestion and handle inconsistent or blank numeric values during transformation.

## 3. Data Cleaning and Transformation

A staging table was created from the raw dataset to prepare the data for analysis.

**Staging Table:** `staging.telco_customer_churn`

Key transformations included:

- Removing leading and trailing whitespace.
- Converting blank values into `NULL`.
- Converting numeric columns into appropriate PostgreSQL data types.
- Standardising the structure of the dataset for downstream analysis.

Eleven records contained blank `total_charges` values. These were retained as `NULL` rather than deleting customer records.

## 4. Data Quality Validation

The staging dataset was validated through the following checks:

- Raw and staging record count reconciliation.
- Missing value analysis across columns.
- Duplicate customer ID validation.
- Numeric range validation for tenure and charge columns.
- Categorical value inspection for key customer attributes.

**Validation Results:**

| Check | Result |
|---|---:|
| Raw records | 7,043 |
| Staging records | 7,043 |
| Duplicate customer IDs | 0 |
| Missing total charges | 11 |

## 5. Exploratory Data Analysis

Initial analysis was performed to understand the overall customer distribution.

Key metrics included:

- Total customers.
- Churned customers.
- Retained customers.
- Overall churn rate.

The overall churn rate of 26.54% was used as a baseline for subsequent customer segment comparisons.

## 6. Business Analysis

Seventeen SQL investigations were performed to identify patterns associated with customer churn.

The analysis covered:

- Customer demographics.
- Monthly and total charges.
- Contract types and pricing segments.
- Customer tenure.
- Internet service categories.
- Online security and technical support.
- Payment methods.
- Paperless billing.
- Combined customer segment analysis.

SQL techniques included aggregation, conditional aggregation, CTEs, CASE expressions, window functions, and customer segmentation.

## 7. Business Insights

The findings were consolidated to identify customer segments with comparatively higher churn rates.

The analysis highlighted patterns involving month-to-month contracts, fiber optic services, electronic check payments, monthly charges, and additional service subscriptions.

These findings represent observed associations and should not be interpreted as proof of causation.

## 8. Technology Stack

| Technology | Usage |
|---|---|
| PostgreSQL | Data storage, cleaning, transformation, and analysis |
| SQL | Data quality checks, exploratory analysis, and business investigations |
| GitHub | Project version control and documentation |

## 9. Project Workflow

1. Dataset collection and CSV import.
2. Raw data storage in PostgreSQL.
3. Data cleaning and transformation into the staging layer.
4. Data quality validation.
5. Exploratory data analysis.
6. Business-focused SQL investigations.
7. Documentation of findings and limitations.