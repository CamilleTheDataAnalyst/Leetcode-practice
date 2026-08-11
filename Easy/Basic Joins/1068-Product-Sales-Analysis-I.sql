-- 1068. Product Sales Analysis I
-- https://leetcode.com/problems/product-sales-analysis-i/

SELECT product_name, year, price
FROM Sales
INNER JOIN Product ON Sales.product_id = Product.product_id;

  Notes:
  SELECT product_name, year, price → "Show the product's name, the year, and the price." (The name comes from one notebook, year and price from the other.)
  FROM Sales → "Start with the sales notebook."
  INNER JOIN Product → "Staple the Product notebook onto it."
  ON Sales.product_id = Product.product_id → "Match them by product number — so number 100 gets turned into 'Nokia'." 
