-- 1251. Average Selling Price
-- https://leetcode.com/problems/average-selling-price/submissions/2118464527/?envType=study-plan-v2&envId=top-sql-50

SELECT p.product_id,
       ROUND(IFNULL(SUM(u.units * p.price) / SUM(u.units), 0), 2) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id
  AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;

  Notes:
  Each product's price changes over time — it's one price for one date range, a different price for another. Meanwhile, sales happen on specific dates. To find the average selling price, you match each sale to whatever price was active on the day it sold, then do a weighted average.
  
  The story:
  
  1. Match each sale to the price active on that day (LEFT JOIN with a date range). 
  ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date — this is the clever part. You link a sale to a price row only if it's the same product AND the sale's date falls inside that price's window. BETWEEN x AND y is a handy shortcut for "≥ x and ≤ y." So a sale on Feb 25 matches the price that was valid Feb 17–28. ⏳
  
  LEFT JOIN keeps products even if they never sold anything (so they can still show 0).
  
  2. Do a weighted average (SUM ÷ SUM). 
  Average selling price isn't just averaging the prices — it's total money ÷ total units.
  
  SUM(u.units * p.price) = total money made (each sale's units × its matched price, all added up).
  SUM(u.units) = total units sold.
  Dividing gives the true average price per unit. For product 1: (100×5 + 15×20) ÷ 115 = 6.96. ✓
  
  3. Handle "no sales" (IFNULL). 
  A product that never sold has no matching units → the division comes out null. IFNULL(..., 0) turns that into 0, like the problem asks.
  
  4. Round and group. 
  ROUND(..., 2) for two decimals, and GROUP BY p.product_id so you get one row per product.
  
  So the whole thing reads: "For each product, match every sale to the price active on its date, add up total money and total units, divide for the average, call it 0 if nothing sold, and round to 2 decimals."
  
  The one new tool here:
  
  BETWEEN x AND y in a join condition = match rows that fall inside a date (or number) range — the key to connecting a sale to its correct time-based price.
