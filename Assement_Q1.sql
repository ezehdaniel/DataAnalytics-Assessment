-- Assessment_Q1.sql
-- Find customers who have at least one funded savings plan and one funded investment plan
-- Total deposits are calculated from the savings_savingsaccount table

SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT i.id) AS investment_count,
    ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser u
JOIN plans_plan s ON s.owner_id = u.id AND s.is_regular_savings = 1
JOIN plans_plan i ON i.owner_id = u.id AND i.is_a_fund = 1
JOIN savings_savingsaccount sa ON sa.plan_id = s.id
GROUP BY u.id, u.name
HAVING savings_count >= 1 AND investment_count >= 1
ORDER BY total_deposits DESC;
