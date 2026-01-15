# Data Contract – Paid Ads Marketing Dataset

## 1. Overview
This document defines the **data contract, grain, assumptions, and known data quality issues**
for the Paid Ads dataset used in the Marketing Analytics ETL project.

This dataset represents **ad-level marketing performance data** and is treated as a
source-of-truth input into the analytics pipeline.

---

## 2. Data Source
- Source Type: CSV (Simulated Google Ads Export)
- File Name: GoogleAds_DataAnalytics_Sales_Uncleaned.csv
- Update Frequency: Daily (assumed)

---

## 3. Data Grain
**One row represents:**

> **One Ad (Ad_ID) per day per device per location per keyword**

Formally:


This grain enables:
- Time-series analysis
- Device and geo-level performance
- Keyword-level ROI analysis
- Incremental data loading

---

## 4. Column Definitions

| Column Name | Description | Expected Type |
|------------|------------|---------------|
| Ad_ID | Unique identifier for each ad | STRING |
| Campaign_Name | Marketing campaign name | STRING |
| Clicks | Number of clicks | INTEGER |
| Impressions | Number of impressions | INTEGER |
| Cost | Ad spend (currency) | FLOAT |
| Leads | Number of leads generated | INTEGER |
| Conversions | Completed conversions | INTEGER |
| Conversion Rate | Conversions / Clicks | FLOAT (Derived) |
| Sale_Amount | Revenue attributed to ad | FLOAT |
| Ad_Date | Date of ad activity | DATE |
| Location | Geographic location | STRING |
| Device | Device type (Mobile/Desktop/Tablet) | STRING |
| Keyword | Keyword triggering the ad | STRING |

---

## 5. Known Data Quality Issues
The following issues were identified during raw data profiling:

1. **Currency stored as strings**
   - Cost and Sale_Amount include currency symbols (e.g. `$231.88`)

2. **Inconsistent date formats**
   - Examples: `2024-11-16`, `20-11-2024`, `2024/11/16`

3. **Inconsistent casing and spelling**
   - Campaign names contain spelling variations
   - Device and Location values vary in casing

4. **Unreliable derived metric**
   - Conversion Rate is partially missing and will NOT be trusted

---

## 6. Data Assumptions
- Sale_Amount represents revenue attributed to the ad
- Conversions represent completed purchases
- Leads may not always convert to purchases
- Conversion Rate will be recalculated downstream
- Campaign_Name will be standardized using mapping logic

---

## 7. Trusted Metrics (Computed Downstream)

The following metrics will be computed in the transformation layer:

- CTR = Clicks / Impressions
- Conversion Rate = Conversions / Clicks
- ROAS = Sale_Amount / Cost
- CAC = Cost / Conversions

Source-derived metrics will not be trusted.

---

## 8. Data Quality Rules
The following rules must always hold true:

- Clicks ≤ Impressions
- Conversions ≤ Clicks
- Cost ≥ 0
- Sale_Amount ≥ 0
- Ad_ID must not be NULL
- Ad_Date must be valid

---

## 9. Ownership
- Data Owner: Marketing Analytics Team
- Pipeline Owner: Analytics Engineering
- Last Updated: YYYY-MM-DD
