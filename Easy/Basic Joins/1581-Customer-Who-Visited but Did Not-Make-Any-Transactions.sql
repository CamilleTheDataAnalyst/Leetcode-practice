-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50

SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits
LEFT JOIN Transactions ON Visits.visit_id = Transactions.visit_id
WHERE transaction_id IS NULL
GROUP BY customer_id;

  Notes:
  1. Staple the notebooks together (LEFT JOIN). 📎
  Keep every visit, and attach its purchase if there was one. LEFT means "don't drop any visits" — even the ones with no purchase stay, and they just get a blank (null) where the transaction info would be.

  2. Keep only the blank ones (WHERE transaction_id IS NULL). 🕳️
  A visit with a purchase has a real transaction number. A visit with no purchase has null there. So IS NULL filters down to only the empty-handed visits — people who came and left without buying.

  3. Bundle by person and count (GROUP BY + COUNT). 🧮
  This is the new magic. Customer 54 had two empty visits. Instead of listing them separately, GROUP BY customer_id scoops all of one person's rows into a single pile, and COUNT(*) counts how many are in that pile → 2. The AS count_no_trans just names that number column.

  So the whole thing reads like: "Look at every visit, keep the ones where nobody bought anything, then for each customer tally up how many empty visits they had." 🛍️➡️🚶

  The two big ideas to remember:

  LEFT JOIN + IS NULL = the classic combo for finding "things with no match" (visits with no purchase).
  GROUP BY + COUNT = squish rows into groups and tally each group — one of the most useful tools in all of SQL.
