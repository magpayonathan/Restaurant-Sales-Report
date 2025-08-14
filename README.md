# Restaurant-Sales-Report

This project assesses the performance of an Indian restaurant using key performance indicators (KPIs) such as total revenue, total sales, and the most-sold product. The dataset, which is from Kaggle, is based on an Indian restaurant. The data was first cleaned in PostgreSQL (pgAdmin 4), and then Power BI was used to create the dashboard.

# Tools & Dataset
- Tools: PostgreSQL (pgAdmin 4), Power BI Desktop
-	Dataset: Kaggle

# Data Cleaning in PostgreSQL
The csv file from Kaggle was cleaned in PostgreSQL to ensure accuracy and consistency. This included:
-	Changing `NULL` values to “Unknown”
-	Checked for and deleting duplicate rows while keeping the first occurrence
-	Standardized text using `TRIM()` and `INITCAP()`
