-- =====================================================
-- Credit Card Fraud Analysis
-- Exploratory Data Analysis using SQL
-- =====================================================

-- This file contains exploratory SQL queries used to better understand
-- the credit card fraud dataset before building the machine learning model.
-- The analysis focuses on transaction volume, class imbalance, transaction
-- amounts, and basic fraud patterns.

-- -----------------------------------------------------
-- 1. Total number of transactions
-- -----------------------------------------------------

SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Insight:
-- The dataset contains 284,807 transactions, providing a large sample
-- for fraud detection analysis.


-- -----------------------------------------------------
-- 2. Fraud vs normal transactions
-- -----------------------------------------------------

SELECT
    class,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY class;

-- Insight:
-- The dataset is extremely imbalanced:
-- - Non-fraudulent transactions (class = 0): 284,315
-- - Fraudulent transactions (class = 1): 492
-- This confirms that fraud represents only a very small portion of the data.


-- -----------------------------------------------------
-- 3. Fraud rate
-- -----------------------------------------------------

SELECT
    COUNT(*) AS total_transactions,
    SUM(class) AS fraud_transactions,
    ROUND(SUM(class) * 100.0 / COUNT(*), 3) AS fraud_rate_percent
FROM transactions;

-- Insight:
-- Fraudulent transactions account for only 0.173% of the dataset.
-- This strong class imbalance makes accuracy a misleading evaluation metric
-- and motivates the use of precision, recall, and threshold tuning.


-- -----------------------------------------------------
-- 4. Transaction amount statistics
-- -----------------------------------------------------

SELECT
    class,
    COUNT(*) AS transaction_count,
    AVG(amount) AS avg_amount,
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount
FROM transactions
GROUP BY class;

-- Insight:
-- Fraudulent transactions have a higher average amount (122.21)
-- than non-fraudulent transactions (88.29), suggesting that fraud
-- tends to involve larger transactions on average.
-- Minimum transaction amount is 0 in both classes.
-- Note: maximum values should be interpreted with caution if formatting
-- or transcription issues are present in the exported results.


-- -----------------------------------------------------
-- 5. Largest fraudulent transactions
-- -----------------------------------------------------

SELECT
    amount,
    time
FROM transactions
WHERE class = 1
ORDER BY amount DESC
LIMIT 10;

-- Insight:
-- The largest fraudulent transactions exceed 2000, with several cases above 1000.
-- This confirms that fraud is not limited to small amounts and can involve
-- high-value transactions.
--
-- The corresponding time values are widely distributed across the dataset,
-- suggesting that large fraud events are not concentrated in a specific period.


-- -----------------------------------------------------
-- 6. Fraud transactions above 500
-- -----------------------------------------------------

SELECT
    COUNT(*) AS fraud_above_500
FROM transactions
WHERE class = 1
AND amount > 500;

-- Insight:
-- There are 35 fraudulent transactions above 500.
-- Although fraud is rare overall, a subset of fraud cases involves
-- relatively high transaction amounts.


-- -----------------------------------------------------
-- 7. Percentage of fraud above 500
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

-- Insight:
-- 7.11% of fraudulent transactions are above 500.
-- This suggests that while high-value fraud exists, most fraudulent
-- transactions still occur below that threshold.


-- -----------------------------------------------------
-- 8. Fraud distribution over time
-- -----------------------------------------------------

SELECT
    class,
    AVG(time) AS avg_time,
    MIN(time) AS first_time,
    MAX(time) AS last_time
FROM transactions
GROUP BY class;

-- Insight:
-- Fraudulent transactions occur slightly earlier on average than
-- non-fraudulent ones (≈ 80k vs 94k).
--
-- However, both fraud and normal transactions span almost the entire
-- time range of the dataset, indicating no strong temporal clustering.


-- -----------------------------------------------------
-- 9. Most common fraud transaction amounts
-- -----------------------------------------------------

SELECT
    amount,
    COUNT(*) AS frequency
FROM transactions
WHERE class = 1
GROUP BY amount
ORDER BY frequency DESC
LIMIT 10;

-- Insight:
-- Fraudulent transactions show strong repetition in specific amounts.
-- The value "1" appears very frequently (113 times), along with other
-- repeated values such as 99.99 and 0.
--
-- This suggests that fraud may follow standardized or automated patterns,
-- rather than being randomly distributed across transaction amounts.
--
-- Additionally, many fraudulent transactions involve very small amounts,
-- indicating possible testing or probing behavior before larger fraud attempts.


-- -----------------------------------------------------
-- 10. Fraud by time windows
-- -----------------------------------------------------

SELECT
    FLOOR(time / 3600) AS hour_block,
    COUNT(*) AS fraud_count
FROM transactions
WHERE class = 1
GROUP BY hour_block
ORDER BY fraud_count DESC;

-- Insight:
-- While some time blocks exhibit slightly higher fraud activity,
-- the distribution remains relatively spread out across the dataset.
-- This indicates the absence of a strong temporal pattern,
-- reinforcing that time is a weak standalone predictor of fraud.


-- -----------------------------------------------------
-- 11. Full transaction amount distribution
-- -----------------------------------------------------

SELECT
    width_bucket(amount, 0, 2500, 10) AS bucket,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY bucket
ORDER BY bucket;

-- Insight:
-- Transaction amounts are heavily concentrated in the lowest range,
-- with a sharp decline as amounts increase.
--
-- This right-skewed distribution indicates that the dataset is dominated
-- by small-value transactions, while high-value transactions are rare.
--
-- Such imbalance can impact fraud detection, as fraudulent activity
-- may behave differently across transaction ranges.