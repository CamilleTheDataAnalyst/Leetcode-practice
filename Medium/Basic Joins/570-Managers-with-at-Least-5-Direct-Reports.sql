-- 570. Managers with at Least 5 Direct Reports
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/?envType=study-plan-v2&envId=top-sql-50

SELECT m.name
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY e.managerId, m.name
HAVING COUNT(*) >= 5;

  Notes:
  1. Connect each worker to their boss (self-join). 
  The table lists both workers and bosses (a boss is just an employee too). So you make two copies: e = the employees (reports), m = the managers. ON e.managerId = m.id links each worker to their boss's row — that's how you grab the boss's name (m.name), not just their id.
  
  2. Bundle by boss and count (GROUP BY + COUNT). 
  Group all the workers under the same boss into one pile, and COUNT(*) tallies how big each pile is. John's pile has 5 people.
  
  3. Keep only the big piles (HAVING). 
  Here's the new tool. You want piles with 5+ people — but you can't use WHERE for this. Why? WHERE checks individual rows before they're grouped, but the count only exists after grouping. So SQL gives you HAVING, which filters the groups by their count. HAVING COUNT(*) >= 5 keeps only bosses with at least 5 reports.
  
  The golden rule to remember:
  
  WHERE = "which rows do I keep?" (before grouping)
  HAVING = "which groups do I keep?" (after grouping, using COUNT/SUM/AVG)
  
  So the whole thing reads: "Link each worker to their boss, pile workers up under each boss, count the piles, and keep only the bosses with 5 or more." 👔
  
  That HAVING idea is the big unlock — and it's what makes this a Medium. Any time a question says "groups where the count/total/average is more than X," HAVING is your friend. 
