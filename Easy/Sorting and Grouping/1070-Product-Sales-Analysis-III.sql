-- 1070. Product Sales Analysis III
-- https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50

  Notes:  
  1. Find each product's earliest year (the inner query). 🔍
  
  sql
  SELECT product_id, MIN(year)
  FROM Sales
  GROUP BY product_id
  
  GROUP BY product_id piles up each product's sales, and MIN(year) grabs the smallest (earliest) year. This produces a little list of pairs: (100, 2008), (200, 2011). That's "each product paired with its debut year."
  
  2. Keep only sales matching those pairs (WHERE ... IN). 🎯
  WHERE (product_id, year) IN (...) filters the full Sales table down to only the rows whose (product, year) combo is in that debut list. So a sale is kept only if its year equals that product's earliest year.
  
  Sale of product 100 in 2008 → (100, 2008) is in the list → kept. ✓
  Sale of product 100 in 2009 → (100, 2009) is not in the list → dropped. ✓
  Sale of product 200 in 2011 → (200, 2011) is in the list → kept. ✓
  
  3. Show the wanted columns. ✏️
  SELECT product_id, year AS first_year, quantity, price — with year renamed to first_year to match the output.
  
  So the whole thing reads: "First figure out each product's debut year, then keep only the sales that happened in that product's debut year."
  
  The key idea to bank — and it's a really important one:
  
  Why a subquery instead of just MIN(year) in one query? Because you need to keep quantity and price from the original rows. If you tried SELECT product_id, MIN(year), quantity, price ... GROUP BY product_id, the quantity and price wouldn't know which row to show (grouping collapses rows, but those columns aren't aggregated). So the two-step dance is: inner query finds the "which" (product + earliest year), outer query fetches the full matching rows. 🪆
  
  The pattern to recognize: "return the full rows where some column is the min/max/first per group" → compute the min/max per group in a subquery, then filter the outer table against that list with WHERE (col, col) IN (...). You've now seen this exact shape twice (here and #1174) — it's one of the most useful patterns in intermediate SQL. 🔥
