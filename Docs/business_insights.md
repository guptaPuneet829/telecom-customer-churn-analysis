# Business Insights - Telecom Customer Churn Analysis

## 1. Project Overview

This analysis investigates customer churn patterns in a telecom customer dataset containing 7,043 customer records.

The objective is to identify customer segments and service-related patterns associated with higher customer churn using PostgreSQL.

## 2. Overall Customer Churn

Business Question: What proportion of customers discontinued the service?

| Metric | Result |

| Total Customers | 7,043 |
| Churned Customers | 1,869 |
| Retained Customers | 5,174 |
| Overall Churn Rate | 26.54% |

Insight: Approximately 26.54% of customers discontinued the service, providing a baseline for comparing churn across different customer segments.

## 3. Customer Demographics

Business Question: Does customer gender show a noticeable difference in churn?

Finding:
- Female customers churned: 939
- Male customers churned: 930
- Difference: 9 customers

Insight: The difference in churn counts is small. However, gender-specific churn rates should be compared before concluding whether gender is associated with churn.

## 4. Monthly Charges and Contract Analysis

Business Question: Are monthly charges and contract types associated with customer churn?

Findings:

| Churn Status | Average Monthly Charges |

| Churned | 74.44 |
| Retained | 61.27 |

The average monthly charges of churned customers were 13.17 higher than those of retained customers.

Contract-wise churn rate:

| Contract Type | Churn Rate |

| Month-to-month | 42.71% |
| One year | 11.27% |
| Two year | 2.83% |

Insights:
- Customers who churned had higher average monthly charges.
- Month-to-month customers showed substantially higher churn than customers with longer-term contracts.
- The observed relationship between contract duration and churn is consistent across the contract categories.

## 5. Monthly Price Segmentation

Business Question: How does churn vary across monthly charge segments within different contract types?

Customers were grouped into exploratory price segments:

- Low: Below 40
- Medium: 40 to below 70
- High: 70 to below 100
- Very High: 100 and above

Findings:
- Higher price segments generally showed higher churn rates within contract categories.
- Month-to-month customers in the High and Very High segments showed particularly elevated churn.
- The Very High month-to-month segment did not follow a perfectly increasing pattern.

Insight: Pricing and contract type should be considered together when investigating customer churn rather than evaluating monthly charges independently.

*Note: These price bands are analytical groupings created for this project, not official telecom pricing categories.*

## 6. Customer Tenure Analysis

Business Question: Does customer tenure have a relationship with churn across contract types?

Findings:

For month-to-month customers, churn rates decreased as tenure increased:

| Tenure | Churn Rate |

| 0-12 months | 51.35% |
| 13-24 months | 37.72% |
| 25-48 months | 32.92% |
| 49-72 months | 26.02% |

Insight: Month-to-month customers with shorter tenure showed higher churn rates. This suggests that early customer retention deserves particular attention.

The one-year and two-year contract groups did not show the same consistent decreasing pattern.

## 7. Internet Service Analysis

Business Question: Does the type of internet service show differences in customer churn?

| Internet Service | Customers | Churned | Churn Rate |

| No internet service | 1,526 | 113 | 7.40% |
| DSL | 2,421 | 459 | 18.96% |
| Fiber optic | 3,096 | 1,297 | 41.89% |

Insight: Fiber optic customers showed the highest observed churn rate among the internet service categories.

Further contract-level analysis showed that month-to-month fiber optic customers had a churn rate of 54.61%, compared with 19.29% for one-year contracts and 7.23% for two-year contracts.

## 8. Additional Services: Online Security and Tech Support

Business Question: Are additional services associated with customer retention?

### Online Security

| Online Security | Customers | Churned | Churn Rate |

| No | 3,498 | 1,461 | 41.77% |
| Yes | 2,019 | 295 | 14.61% |
| No internet service | 1,526 | 113 | 7.40% |

### Tech Support

| Tech Support | Customers | Churned | Churn Rate |

| No | 3,473 | 1,446 | 41.64% |
| Yes | 2,044 | 310 | 15.17% |
| No internet service | 1,526 | 113 | 7.40% |

Insights:
- Customers without online security showed a higher churn rate than customers with online security.
- A similar pattern was observed for tech support.
- These patterns were also visible within both DSL and fiber optic customer groups.

### Combined Service Analysis

The highest churn segment in the combined internet service, tech support, and online security analysis was:

| Segment | Customers | Churned | Churn Rate |

| Fiber optic, no tech support, no online security | 1,765 | 971 | 55.01% |

Insight: Fiber optic customers without either online security or tech support formed a particularly high-churn segment.

## 9. Payment Method Analysis

Business Question: Does payment method show differences in customer churn?

| Payment Method | Customers | Churned | Churn Rate |

| Electronic check | 2,365 | 1,071 | 45.29% |
| Credit card (automatic) | 1,522 | 232 | 15.24% |
| Mailed check | 1,612 | 308 | 19.11% |
| Bank transfer (automatic) | 1,544 | 258 | 16.71% |

Insights:
- Electronic check customers had the highest observed churn rate.
- This pattern remained visible when payment methods were compared within each contract category.
- Electronic check customers showed the highest churn rate across month-to-month, one-year, and two-year contracts.

## 10. Paperless Billing Analysis

Business Question: Does paperless billing show an association with customer churn?

| Paperless Billing | Customers | Churned | Churn Rate |

| No | 2,872 | 469 | 16.33% |
| Yes | 4,171 | 1,400 | 33.57% |

Insights:
- Customers using paperless billing showed a higher observed churn rate.
- This pattern was also visible across individual payment methods.
- The difference was present even among customers using automatic payment methods.

Paperless billing should not be interpreted as a cause of churn. Other customer characteristics may help explain this association.

## 11. Combined Analysis: Contract, Paperless Billing and Payment Method

Business Question: Which combinations of contract type, billing preference, and payment method show higher churn?

Key Findings:
- Longer-term contracts consistently showed lower churn than month-to-month contracts across payment methods and paperless billing categories.
- Electronic check customers had the highest churn rate across the contract and billing combinations.
- The most notable segment was month-to-month customers using paperless billing and electronic check payments.

| Customer Segment | Customers | Churned | Churn Rate |

| Month-to-month + Paperless + Electronic check | 1,397 | 806 | 57.70% |

Insight: The combination of month-to-month contracts, paperless billing, and electronic check payments represented a particularly high-churn customer segment in this dataset.

## 12. Key Business Takeaways

Based on the exploratory and business analysis, the following customer segments deserve further investigation:

1. Month-to-month customers: Consistently higher churn compared with longer-term contract customers.
2. High monthly charge customers: Higher average monthly charges were observed among churned customers.
3. Fiber optic customers: Showed a higher churn rate than DSL and customers without internet service.
4. Customers without additional services: Customers without online security and tech support showed higher churn.
5. Electronic check customers: Had the highest churn rate among payment methods.
6. Newer month-to-month customers: Customers with shorter tenure showed higher churn.
7. Combined high-risk segment: Month-to-month, paperless billing, and electronic check customers showed a 57.70% churn rate.

## 13. Analysis Limitations

- The analysis is based on descriptive statistics and customer segmentation.
- Observed associations do not establish causation.
- Some combined customer segments may have smaller sample sizes, making their churn rates less stable.
- The monthly price categories were defined for exploratory analysis.
- Eleven records had missing total charges, which were preserved as NULL during data cleaning.
- Further statistical analysis and additional customer data would be required to establish the reasons behind churn.


Tools Used: PostgreSQL, SQL

Analysis Techniques: Data aggregation, conditional aggregation, CTEs, CASE expressions, window functions, customer segmentation, and churn rate analysis.