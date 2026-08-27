-- 1211. Queries Quality and Percentage
-- https://leetcode.com/problems/queries-quality-and-percentage/submissions/2122011468/?envType=study-plan-v2&envId=top-sql-50
SELECT 
    query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;

  Notes:
  Breaking it down:
  
  1. Group by query_name
  
  sql
  GROUP BY query_name
  
  Every calculation needs to happen per query name (Dog, Cat, etc.), so we group all rows sharing the same query_name together first. Everything else in the SELECT operates within these groups.
  
  2. Calculate "quality"
  
  sql
  AVG(rating * 1.0 / position)
  
  The definition says quality is the average of the ratio between rating and position, so:
  
  For each row, first compute rating / position — e.g. for Dog's first row, that's 5/1 = 5.
  The * 1.0 forces decimal division instead of integer division (otherwise 1/200 would round down to 0 instead of 0.005).
  AVG(...) then averages all these individual ratios within the group.
  
  So for Dog: average of 5/1, 5/2, 1/200 = average of 5, 2.5, 0.005 = 2.50 ✅ matches the expected output.
  
  3. Calculate "poor_query_percentage"
  
  sql
  SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
  
  This is a classic "count how many rows meet a condition" trick:
  
  CASE WHEN rating < 3 THEN 1 ELSE 0 END turns each row into a 1 if it's a poor query (rating < 3) or 0 otherwise.
  SUM(...) adds those up, giving the count of poor queries in the group.
  Divide by COUNT(*) (total rows in the group) and multiply by 100.0 to get a percentage.
  
  For Dog: ratings are 5, 5, 1 → only one rating (1) is below 3 → 1/3 * 100 = 33.33 ✅
  
  4. Round both values
  
  sql
  ROUND(..., 2)
  
  Just formats both results to 2 decimal places as the problem requires.
  
  Mental model: Think of GROUP BY as splitting your table into mini-tables, one per query_name. Then AVG(), SUM(), and COUNT() each do their math within that mini-table only, and you get one output row per group.
