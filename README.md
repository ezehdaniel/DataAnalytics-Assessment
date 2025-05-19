# Data Analytics SQL Assessment

This repository contains solutions to a SQL Proficiency Assessment focused on solving key business problems using SQL. The dataset includes tables related to customers, savings accounts, plans, and withdrawals.

## Repository Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

---

## ✅ Question 1: High-Value Customers with Multiple Products

### Objective:

Identify customers who have both a funded savings plan and a funded investment plan. This is useful for cross-selling opportunities.

### Approach:

* Join `users_customuser`, `plans_plan`, and `savings_savingsaccount`.
* Count savings plans (`is_regular_savings = 1`) and investment plans (`is_a_fund = 1`) per customer.
* Sum all `confirmed_amount` to get total deposits.
* Filter customers who have at least one savings and one investment plan.
* Group and order by total deposits in descending order.

### Challenge:

Some user `name` fields were null.  ensuring proper test data population resolved this.

---

## ✅ Question 2: Transaction Frequency Analysis

### Objective:

Segment customers based on the frequency of their transactions into High, Medium, and Low frequency users.

### Approach:

* From `savings_savingsaccount`, count transactions per customer.
* Calculate active months using the date range between first and last transaction.
* Derive average transactions per month.
* Categorize based on:

  * High: ≥10/month
  * Medium: 3-9/month
  * Low: ≤2/month

### Challenge:

Some users had less than one month of activity. To avoid division by zero, we applied a minimum of 1 to the months count.

---

## ✅ Question 3: Account Inactivity Alert

### Objective:

Identify all active savings or investment plans with no transactions in the last 365 days to flag potential account inactivity.

### Approach:

* Find the latest transaction per plan from `savings_savingsaccount`.
* Join with `plans_plan` to filter only savings or investment plans.
* Calculate `inactivity_days` using the difference between the current date and the last transaction date.
* Filter where `inactivity_days > 365`.

### Challenge:

Plans with no transactions were excluded due to INNER JOIN on transaction history.

---

## ✅ Question 4: Customer Lifetime Value (CLV) Estimation

### Objective:

Estimate Customer Lifetime Value (CLV) based on transaction activity and account tenure.

## Approach:

Calculate tenure in months from signup_date.

Count total transactions and calculate average transaction profit (0.1% of value).

Use formula: (total_transactions / tenure) * 12 * avg_profit_per_transaction

Output includes customer_id, name, tenure, transaction count, and CLV estimate.

## General Challenges Encountered:

Incorrect Function Usage in MySQL

Initially, I used DATE_PART, which is unsupported in MySQL. Replaced with TIMESTAMPDIFF.


Assumed created_at existed, but the field was named created_on. Adjusted query accordingly.

Schema Clarification

Required examining table structure to identify transaction inflow fields (confirmed_amount).

Category Distribution Mismatch

Real result distributions differed from expected due to actual data patterns. Adjusted logic and verified output integrity.

Null User Names

Some records lacked name values. Addressed by refining joins and confirming test data consistency.

Some users had no transactions. Filtering only customers with valid transactions ensured accuracy.

---

## 🏁 Final Notes

* All queries are optimized and commented.
* Complex logic is broken into CTEs for readability.


---

**Submitted by:** Daniel Onuabuchi Ezeh

