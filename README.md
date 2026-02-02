# Sales-Performance-Revenue-Analysis-Using-SQL
This project analyzes sales performance using the Sample Superstore dataset. The goal was to clean the raw data and perform SQL-based exploratory analysis to evaluate revenue, profitability, product performance, regional trends, and the impact of discounts on profit.
## Data Cleaning

The following data cleaning steps were performed using MySQL:

* Removed duplicate records using ROW_NUMBER()

* Standardized categorical and text fields

* Handled missing values in key numeric columns

* Removed unnecessary columns to simplify analysis

A clean staging table was created before analysis to preserve the raw data.

## Sales & Revenue Analysis

Key business questions explored:

* Total revenue and total profit

* Top-performing product sub-categories by sales

* Sales and profit by region

* Impact of discount levels on overall profitability

* Identification of high-sales but low-profit product categories
## Key Insights

* Revenue and profit are unevenly distributed across regions

* Higher discount levels are strongly associated with lower profitability

* Some sub-categories generate high sales volume but operate at a loss

* Product performance varies significantly within each category
