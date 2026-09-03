-- 1141. User Activity for the Past 30 Days I
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/submissions/2129599579/?envType=study-plan-v2&envId=top-sql-50

SELECT activity_date AS day,
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

  Notes:
  The story:
  
  1. Keep only the 30-day window (WHERE ... BETWEEN). 📅
  activity_date BETWEEN '2019-06-28' AND '2019-07-27' keeps only rows inside the window. BETWEEN x AND y means "≥ x and ≤ y," so both end dates are included. This is why user 4's activity on 2019-06-25 gets thrown out — it's before the window. ✓
  
  (How do you get 2019-06-28? Count back 30 days inclusive from 2019-07-27. The 27th is day 1, so day 30 is the 28th of June.)
  
  2. Bundle by day (GROUP BY activity_date). 🗂️
  Pile up all the rows that happened on the same date, so you can count per day.
  
  3. Count DISTINCT users (the key twist). 🎯
  COUNT(DISTINCT user_id) counts how many different users were active that day — ignoring the duplicates.
  
  2019-07-20: user 1 (3 rows) + user 2 (1 row) → distinct users = 2. ✓ (User 1's three rows collapse to one.)
  2019-07-21: users 2 and 3 → 2. ✓
  
  4. Rename for the output (AS day, AS active_users). ✏️
  Match the required column headers.
  
  So the whole thing reads: "Look only at activity in the 30-day window, group it by date, and for each date count how many distinct users showed up."
  
  The tools clicking together here:
  
  BETWEEN for the date window (same tool as Average Selling Price's range join).
  COUNT(DISTINCT user_id) — count unique users, not rows (same as the teacher/subjects problem #2356).
  GROUP BY a date to get one row per day.
  
  And notice why days with zero users never appear: if nobody was active on a day, that day has no rows to group, so it simply doesn't show up — which matches "we don't care about zero-user days." (If the problem had wanted zeros, you'd need a calendar table + LEFT JOIN, like Students & Examinations. But it doesn't, so this stays simple.) 🔥
