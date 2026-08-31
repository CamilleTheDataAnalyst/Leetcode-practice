-- 1633. Percentage of Users Attended a Contest
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/submissions/2120746508/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    contest_id,
    ROUND(COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;

  Notes:
  1. The subquery: total number of users
  
  sql
  (SELECT COUNT(*) FROM Users)
  
  This just counts how many users exist in total — in the example, that's 3 (Alice, Bob, Alex). This is your denominator, and it stays the same for every contest.
  
  2. Group by contest
  
  sql
  FROM Register
  GROUP BY contest_id
  
  This groups all registration rows by contest_id, so you get one group per contest — e.g. all rows where contest_id = 208, all rows where contest_id = 209, etc.
  
  3. Count registrants per contest
  
  sql
  COUNT(user_id)
  
  Within each group, this counts how many users registered for that specific contest. For contest 208, that's 3 users (Bob, Alice, Alex all registered) — matches the table.
  
  4. Calculate the percentage
  
  sql
  COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM Users)
  
  This is just: (registrants for this contest ÷ total users) × 100.
  
  The 100.0 (not 100) is important — it forces the division to happen in decimal/float form rather than integer division, which would truncate fractions like 0.67 down to 0.
  
  5. Round to 2 decimals
  
  sql
  ROUND(..., 2)
  
  Formats the result nicely, e.g. 66.666... → 66.67.
  
  6. Sort the output
  
  sql
  ORDER BY percentage DESC, contest_id ASC
  Highest percentage first.
  If two contests tie on percentage (like 208, 209, 210 all at 100.0%), break the tie by sorting contest_id in ascending order.
  
  Mental model: for each contest, you're asking "what fraction of ALL users signed up for this one?" — the numerator changes per contest (via GROUP BY), but the denominator (total users) never changes, which is why it lives in a separate subquery instead of being grouped.
