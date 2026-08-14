-- 197. Rising Temperature
-- https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50

SELECT w1.id
FROM Weather w1
JOIN Weather w2 ON w2.recordDate = w1.recordDate - INTERVAL 1 DAY
WHERE w1.temperature > w2.temperature;

  Notes:
  FROM Weather w1 JOIN Weather w2 → "Take the calendar and make two copies — call one w1 (today) and one w2 (yesterday)." This is called a self-join: joining a table to itself. 🪞
  ON w2.recordDate = w1.recordDate - INTERVAL 1 DAY → "Line them up so that w2's date is exactly one day before w1's date." (- INTERVAL 1 DAY just means "go back one day.") So each "today" gets paired with its real "yesterday."
  WHERE w1.temperature > w2.temperature → "Keep only the pairs where today was hotter than yesterday."
  SELECT w1.id → "Give me the id of that hotter day."
