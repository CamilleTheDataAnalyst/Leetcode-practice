-- 1661. Average Time of Process per Machine
-- https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.machine_id, ROUND(AVG(e.timestamp - s.timestamp), 3) AS processing_time
FROM Activity s
JOIN Activity e ON s.machine_id = e.machine_id
                AND s.process_id = e.process_id
                AND s.activity_type = 'start'
                AND e.activity_type = 'end'
GROUP BY s.machine_id;

  Notes:

  1. Pair each start with its end (the self-join). 🔗
  JOIN Activity e ON ... staples two copies together. The ON says: match rows that are the same machine AND the same job, where one is the 'start' and the other is the 'end'. Now each job's start and end sit side by side.

  2. Find one job's duration. ⏱️
  e.timestamp - s.timestamp = end time minus start time = how long that job took.
  
  3. Average them per machine. 📊
  GROUP BY s.machine_id scoops all of one machine's jobs into a pile, and AVG(...) finds the average duration of that pile. (AVG is the "find the average" helper — cousin of COUNT, which you used to tally rather than average.)
  
  4. Tidy up the number. ✨
  ROUND(..., 3) trims it to 3 decimal places, and AS processing_time names the column to match what the answer wants.
  
  So the whole thing reads: "Pair up each job's start and end, measure how long it took, then for each machine average all its jobs and round to 3 decimals." 🏭
  
  The big ideas to keep:
  
  Self-join = two nicknamed copies (s, e) to bring two related rows onto one line.
  AVG + GROUP BY = squish each group into a single averaged number. (Swap AVG for COUNT, SUM, MIN, or MAX depending on what you need.)
