# Credit Card Fraud Detection

## Overview
End-to-end machine learning project to detect fraudulent credit card transactions using logistic regression.

The project focuses on handling **class imbalance** and optimizing the **decision threshold** to improve fraud detection performance.

---

## Dataset
Kaggle dataset:  
https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud  

Download the dataset and place it in: data/creditcard.csv


---

## Approach

### SQL Analysis
- Exploratory analysis using SQL
- Understanding transaction distributions
- Identifying class imbalance

### Machine Learning
- Logistic Regression (baseline model)
- Feature scaling using StandardScaler
- Train/test split with stratification
- Model evaluation (precision, recall, F1-score, ROC-AUC)

### Improvements
- Class weighting (`class_weight="balanced"`)
- Threshold tuning (from 0.1 to 0.5)

---

## Final Results (Threshold = 0.1)

- Precision (fraud): **0.83**
- Recall (fraud): **0.74**
- F1-score: **0.78**

Confusion Matrix:

[[56637 14]
[ 25 70]]


---

## Key Insight

Fraud detection requires balancing:
- catching fraudulent transactions (recall)
- limiting false alarms (precision)

Threshold tuning significantly improved this trade-off, making the model more usable in a real-world setting.

---

## Tech Stack
- Python (Pandas, NumPy, Scikit-learn)
- SQL
- Matplotlib
- Jupyter Notebook (VS Code)

---

## 👤 Author
Antonio Iuliano
