-- =====================================================
-- Credit Card Fraud Analysis
-- Exploratory Data Analysis using SQL
-- =====================================================

-- -----------------------------------------------------
-- Total number of transactions
-- -----------------------------------------------------

SELECT COUNT(*) AS total_transactions
FROM transactions;



-- -----------------------------------------------------
-- Fraud vs normal transactions
-- -----------------------------------------------------

SELECT
    class,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY class;



-- -----------------------------------------------------
-- 3. Fraud rate
-- -----------------------------------------------------

SELECT
    COUNT(*) AS total_transactions,
    SUM(class) AS fraud_transactions,
    ROUND(SUM(class) * 100.0 / COUNT(*), 3) AS fraud_rate_percent
FROM transactions;



-- -----------------------------------------------------
-- Transaction amount statistics
-- -----------------------------------------------------

SELECT
    class,
    COUNT(*) AS transaction_count,
    AVG(amount) AS avg_amount,
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount
FROM transactions
GROUP BY class;



-- -----------------------------------------------------
-- Largest fraudulent transactions
-- -----------------------------------------------------

SELECT
    amount,
    time
FROM transactions
WHERE class = 1
ORDER BY amount DESC
LIMIT 10;



-- -----------------------------------------------------
-- Fraud transactions above 500
-- -----------------------------------------------------

SELECT
    COUNT(*) AS fraud_above_500
FROM transactions
WHERE class = 1
AND amount > 500;




-- -----------------------------------------------------
-- Percentage of fraud above 500
-- -----------------------------------------------------

SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM transactions WHERE class = 1),
        2
    ) AS percent_fraud_above_500
FROM transactions
WHERE class = 1
AND amount > 500;



-- -----------------------------------------------------
-- Fraud distribution over time
-- -----------------------------------------------------

SELECT
    class,
    AVG(time) AS avg_time,
    MIN(time) AS first_time,
    MAX(time) AS last_time
FROM transactions
GROUP BY class;


-- -----------------------------------------------------
-- Most common fraud transaction amounts
-- -----------------------------------------------------

SELECT
    amount,
    COUNT(*) AS frequency
FROM transactions
WHERE class = 1
GROUP BY amount
ORDER BY frequency DESC
LIMIT 10;


-- -----------------------------------------------------
-- Fraud by time windows
-- -----------------------------------------------------

SELECT
    FLOOR(time / 3600) AS hour_block,
    COUNT(*) AS fraud_count
FROM transactions
WHERE class = 1
GROUP BY hour_block
ORDER BY fraud_count DESC;


-- -----------------------------------------------------
-- Distribution complète des montants
-- -----------------------------------------------------

SELECT
    width_bucket(amount, 0, 2500, 10) AS bucket,
    COUNT(*)
FROM transactions
GROUP BY bucket
ORDER BY bucket;
