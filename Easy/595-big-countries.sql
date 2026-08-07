-- 595. Big Countries
-- https://leetcode.com/problems/big-countries/?envType=study-plan-v2&envId=top-sql-50
SELECT name, population, area
FROM World
WHERE  area >= 3000000 OR population >= 25000000;


Notes:
  SELECT name, population, area → "For each big country, tell me its name, how many people, and how much land." (Those are the three things the answer asks for.)
  FROM World → "Go look in the table called World."
  WHERE area >= 3000000 OR population >= 25000000 → "But only keep the pages where the land is at least 3 million OR the people are at least 25 million."
  >= means "at least" — it says "this much or more," so exactly 3,000,000 still counts.
  OR means "either one is enough" — different from AND, which would demand both be true at the same time.
