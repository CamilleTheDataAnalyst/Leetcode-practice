-- 577. Employee Bonus
-- https://leetcode.com/problems/employee-bonus/?envType=study-plan-v2&envId=top-sql-50

SELECT name, bonus
FROM Employee
LEFT JOIN Bonus ON Employee.empId = Bonus.empId
WHERE bonus < 1000 OR bonus IS NULL;

  Notes:
  1. Staple the lists together (LEFT JOIN). 
  Keep every employee, and attach their bonus if they have one. LEFT means nobody gets dropped — people with no bonus (like Brad and John) still stay, they just get a blank (null) where the bonus would be.

  2. Keep the right people (WHERE). 
  Two ways to qualify, joined by OR (either one is enough):

  bonus < 1000 → their bonus is small, OR
  bonus IS NULL → they got no bonus at all (the blank ones).

  Here's the sneaky part you have to remember: a blank bonus is null, and null doesn't get caught by bonus < 1000 — SQL treats "is null less than 1000?" as "I don't know" and skips it. So you must add OR bonus IS NULL on purpose, or Brad and John quietly disappear. 🕳️

  So the whole thing reads: "Keep every employee, attach their bonus, then show the ones with a small bonus OR no bonus at all." 💰
  
  This problem is really a greatest-hits combo of things you already learned:
  
  LEFT JOIN (#1378) → keep everyone, null for no match.
  IS NULL (#584) → catch the blanks that slip through comparisons.
  OR (#595) → either condition is enough.
