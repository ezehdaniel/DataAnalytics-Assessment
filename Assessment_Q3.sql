-- Assessment_Q3.sql

-- Find active plans (savings or investment) with no inflow transaction in over 365 days

WITH last_txn AS (
    SELECT 
        sa.plan_id,
        MAX(sa.created_on) AS last_transaction_date
    FROM savings_savingsaccount sa
    WHERE sa.confirmed_amount > 0  -- Only consider inflows
    GROUP BY sa.plan_id
),
plan_summary AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        l.last_transaction_date,
        DATEDIFF(CURDATE(), l.last_transaction_date) AS inactivity_days
    FROM plans_plan p
    JOIN last_txn l ON l.plan_id = p.id
    WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1
)
SELECT *
FROM plan_summary
WHERE inactivity_days > 365
ORDER BY inactivity_days DESC;
