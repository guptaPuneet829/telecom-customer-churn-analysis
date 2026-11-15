# Data Dictionary - Telecom Customer Churn Analysis

## Dataset Overview

+---------------+------------------------------+
| Attribute     | Details                      |
+---------------+------------------------------+
| Dataset       | IBM Telco Customer Churn     |
+---------------+------------------------------+
| Source        | Kaggle                       |
+---------------+------------------------------+
| Total Records | 7,043                        |
+---------------+------------------------------+
| Total Columns | 21                           |
+---------------+------------------------------+
| Database      | PostgreSQL                   |
+---------------+------------------------------+
| Raw Table     | raw.telco_customer_churn     |
+---------------+------------------------------+
| Staging Table | staging.telco_customer_churn |
+---------------+------------------------------+

## Column Definitions

+-------------------+---------------+-----------------------------------------------------------------------+
| Column Name       | Data Type     | Description                                                           |
+-------------------+---------------+-----------------------------------------------------------------------+
| customer_id       | TEXT          | Unique identifier assigned to each customer.                          |
+-------------------+---------------+-----------------------------------------------------------------------+
| gender            | TEXT          | Customer's gender.                                                    |
+-------------------+---------------+-----------------------------------------------------------------------+
| senior_citizen    | INTEGER       | Indicates whether the customer is a senior citizen (1 = Yes, 0 = No). |
+-------------------+---------------+-----------------------------------------------------------------------+
| partner           | TEXT          | Indicates whether the customer has a partner.                         |
+-------------------+---------------+-----------------------------------------------------------------------+
| dependents        | TEXT          | Indicates whether the customer has dependents.                        |
+-------------------+---------------+-----------------------------------------------------------------------+
| tenure            | INTEGER       | Number of months the customer has been with the company.              |
+-------------------+---------------+-----------------------------------------------------------------------+
| phone_service     | TEXT          | Indicates whether the customer has phone service.                     |
+-------------------+---------------+-----------------------------------------------------------------------+
| multiple_lines    | TEXT          | Indicates whether the customer has multiple phone lines.              |
+-------------------+---------------+-----------------------------------------------------------------------+
| internet_service  | TEXT          | Type of internet service subscribed to by the customer.               |
+-------------------+---------------+-----------------------------------------------------------------------+
| online_security   | TEXT          | Indicates whether the customer has online security service.           |
+-------------------+---------------+-----------------------------------------------------------------------+
| online_backup     | TEXT          | Indicates whether the customer has online backup service.             |
+-------------------+---------------+-----------------------------------------------------------------------+
| device_protection | TEXT          | Indicates whether the customer has device protection service.         |
+-------------------+---------------+-----------------------------------------------------------------------+
| tech_support      | TEXT          | Indicates whether the customer has technical support service.         |
+-------------------+---------------+-----------------------------------------------------------------------+
| streaming_tv      | TEXT          | Indicates whether the customer has streaming TV service.              |
+-------------------+---------------+-----------------------------------------------------------------------+
| streaming_movies  | TEXT          | Indicates whether the customer has streaming movie service.           |
+-------------------+---------------+-----------------------------------------------------------------------+
| contract          | TEXT          | Customer's contract type.                                             |
+-------------------+---------------+-----------------------------------------------------------------------+
| paperless_billing | TEXT          | Indicates whether the customer uses paperless billing.                |
+-------------------+---------------+-----------------------------------------------------------------------+
| payment_method    | TEXT          | Payment method used by the customer.                                  |
+-------------------+---------------+-----------------------------------------------------------------------+
| monthly_charges   | NUMERIC(10,2) | Monthly amount charged to the customer.                               |
+-------------------+---------------+-----------------------------------------------------------------------+
| total_charges     | NUMERIC(10,2) | Total amount charged to the customer.                                 |
+-------------------+---------------+-----------------------------------------------------------------------+
| churn             | TEXT          | Indicates whether the customer discontinued the service (Yes/No).     |
+-------------------+---------------+-----------------------------------------------------------------------+


## Data Preparation Notes

- All source columns were initially imported as `TEXT` in the raw layer.
- Numeric columns were converted into appropriate PostgreSQL data types in the staging layer.
- Leading and trailing whitespace was removed during transformation.
- Blank values were converted to `NULL`.
- Eleven records contained missing `total_charges` values, which were preserved as `NULL`.
- All 7,043 source records were retained in the staging table.

## Important Notes

- `customer_id` is used as the customer identifier.
- `tenure` is measured in months.
- `senior_citizen` uses binary values (0 and 1).
- `total_charges` may contain NULL values due to missing source data.
- The `churn` column is the target variable used throughout the customer churn analysis.