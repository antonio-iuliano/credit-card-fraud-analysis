-- =====================================================
-- Credit Card Fraud Analysis
-- Exploratory Data Analysis using SQL
-- =====================================================


-- 1. Dataset overview
-- Total number of transactions

SELECT COUNT(*) AS total_transactions
FROM transactions;


-- 2. Fraud vs normal transactions

SELECT
    class,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY class;


-- 3. Fraud rate

SELECT
    COUNT(*) AS total_transactions,
    SUM(class) AS fraud_transactions,
    ROUND(SUM(class) * 100.0 / COUNT(*), 3) AS fraud_rate_percent
FROM transactions;