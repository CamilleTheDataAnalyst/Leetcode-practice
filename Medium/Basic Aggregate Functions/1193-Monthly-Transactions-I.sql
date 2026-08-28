-- 1193. Monthly Transactions I
-- https://leetcode.com/problems/monthly-transactions-i/submissions/2122989935/?envType=study-plan-v2&envId=top-sql-50

SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country;

  Notes:
  The story:
  
  1. Turn a full date into just "year-month" (the new tool). 
  DATE_FORMAT(trans_date, '%Y-%m') reshapes 2018-12-18 into 2018-12. You throw away the day so all of December's transactions land in the same bucket. The '%Y-%m' is a pattern: %Y = 4-digit year, %m = 2-digit month.
  
  2. Bundle by month + country (GROUP BY). 
  GROUP BY month, country piles together every transaction that shares the same month and the same country. US-December is one pile, US-January another, DE-January another.
  
  3. Count and total everything (COUNT, SUM). 
  
  COUNT(*) → how many transactions in the pile.
  SUM(amount) → total money in the pile.
  
  4. Count and total ONLY the approved ones (CASE WHEN). 
  This is the clever combo you learned in Confirmation Rate:
  
  SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) → adds 1 for each approved row, 0 otherwise → count of approved.
  SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) → adds the amount for approved rows, 0 otherwise → total approved money.
  
  Think of CASE WHEN as a filter inside the sum: "only let approved rows contribute; everyone else contributes zero." 🔀
  
  So the whole thing reads: "Group transactions by month and country, then for each group count them all and total their money — and separately count and total just the approved ones." 
  
  The one new tool:
  
  DATE_FORMAT(date, '%Y-%m') = reshape a date into a chosen text format (here, to group by month).
  
  Everything else is your existing toolkit clicking together: GROUP BY for the buckets, COUNT/SUM for the totals, and the SUM(CASE WHEN...) trick to count/total only rows meeting a condition. That last pattern — "total everything vs. total only the ones that qualify, side by side" — is extremely common in real reporting. 🔥
