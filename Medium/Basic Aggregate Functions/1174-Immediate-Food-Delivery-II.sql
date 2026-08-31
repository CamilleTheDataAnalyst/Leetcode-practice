-- 1174. Immediate Food Delivery II
-- https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50

SELECT ROUND(
         AVG(order_date = customer_pref_delivery_date) * 100,
         2
       ) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id
);

  Notes:  
  1. Find each customer's first order (the subquery). 
  The inner query does the isolating:
  
  sql
  SELECT customer_id, MIN(order_date)
  FROM Delivery
  GROUP BY customer_id
  
  GROUP BY customer_id piles up each customer's orders, and MIN(order_date) grabs their earliest date. This produces a little list: (customer 1, their first date), (customer 2, their first date), etc.
  
  2. Keep only those first orders (WHERE ... IN). 
  WHERE (customer_id, order_date) IN (...) filters the full table down to only the rows that match one of those "first order" pairs. So now you're looking at exactly one row per customer — their first order. (This is a subquery — a query inside a query. The inner one finds the first orders; the outer one uses that list to filter.)
  
  3. Calculate the percentage (a neat AVG trick). 
  order_date = customer_pref_delivery_date is a true/false test — is this order immediate? In MySQL, true counts as 1 and false as 0. So AVG(order_date = customer_pref_delivery_date) averages a bunch of 1s and 0s — which is exactly the fraction that are immediate (2 immediate out of 4 = 0.5). Multiply by 100 → 50, and ROUND(..., 2) → 50.00. ✓
  
  So the whole thing reads: "Find each customer's earliest order, keep just those, then figure out what fraction were same-day and turn it into a percentage."
  
  Two new-ish tools here:
  
  Subquery with WHERE ... IN (...) = "filter to rows that match a list computed by another query." The classic way to grab "each customer's first/latest/max something." 
  AVG(condition) * 100 = a shortcut for "what percentage of rows are true," because true=1 and false=0. (Equivalent to SUM(CASE WHEN ... THEN 1 ELSE 0 END) / COUNT(*) * 100 — just shorter.)
  
  The subquery is the big idea to bank: when a problem says "the first / latest / highest X per group, then do something with those," you often compute that inner list first, then filter the outer query against it. 
