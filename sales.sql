SELECT *
FROM samplesuperstore;
-- creating a copy to save the original data
CREATE TABLE samplesuperstore_copy
LIKE samplesuperstore;

INSERT INTO samplesuperstore_copy
SELECT * FROM samplesuperstore;
SELECT COUNT(*) FROM sales_copy;
-- removing duplicate 
-- standardizing the data
--  removing null values
-- remove uncessary data
CREATE TABLE samplesuperstore_nodup AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   `Ship Mode`, Segment, Country, City, State,
                   `Postal Code`, Region, Category, `Sub-Category`,
                   Sales, Quantity, Discount, Profit
           ) AS row_num
    FROM samplesuperstore_copy
) t
WHERE row_num = 1;


SELECT *
FROM samplesuperstore_nodup;

-- Standarizing data
UPDATE samplesuperstore_nodup
SET
    `Ship Mode` = TRIM(`Ship Mode`),
    Segment = TRIM(Segment),
    Country = TRIM(Country),
    City = TRIM(City),
    State = TRIM(State),
    Region = TRIM(Region),
    Category = TRIM(Category),
    `Sub-Category` = TRIM(`Sub-Category`);
SELECT *
FROM samplesuperstore_nodup;
-- the data is fairly clean so far
ALTER TABLE samplesuperstore_nodup
DROP COLUMN `Postal Code`;
--
SELECT *
FROM samplesuperstore_nodup;

-- EDA
-- total revenue and total profit
SELECT 
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM samplesuperstore_nodup;
-- most profitable categories
SELECT 
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_revenue
FROM samplesuperstore_nodup
GROUP BY Category, `Sub-Category`
ORDER BY total_revenue DESC;
-- regional profit
 SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS total_revenue,
    ROUND(SUM(Profit), 2) AS total_profit
FROM samplesuperstore_nodup
GROUP BY Region
ORDER BY total_revenue DESC;
-- Discount Impact on Profit
SELECT 
    Discount,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM samplesuperstore_nodup
GROUP BY Discount
ORDER BY Discount;
-- Products Rank

SELECT 
    Category,
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS total_sales,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY SUM(Sales) DESC
    ) AS sales_rank
FROM samplesuperstore_nodup
GROUP BY Category, `Sub-Category`;
-- segement profits
SELECT 
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM samplesuperstore_nodup
GROUP BY Segment;
select *
from samplesuperstore_nodup;

