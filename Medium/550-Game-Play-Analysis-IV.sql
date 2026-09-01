-- 550. Game Play Analysis IV
-- https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50
WITH FirstLogin AS (
    SELECT player_id, MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
)
SELECT 
    ROUND(
        COUNT(DISTINCT a.player_id) * 1.0 / (SELECT COUNT(*) FROM FirstLogin), 
        2
    ) AS fraction
FROM FirstLogin f
JOIN Activity a
    ON f.player_id = a.player_id
    AND a.event_date = f.first_date + INTERVAL 1 DAY;
  
  
  1. Find each player's first login date
  
  sql
  WITH FirstLogin AS (
      SELECT player_id, MIN(event_date) AS first_date
      FROM Activity
      GROUP BY player_id
  )
  
  GROUP BY player_id splits the data into one group per player, and MIN(event_date) grabs the earliest date in each group — that's their "Day 1."
  
  For the example: Player 1's first day is 2016-03-01, Player 2's is 2017-06-25, Player 3's is 2016-03-02.
  
  2. Check who came back the very next day
  
  sql
  FROM FirstLogin f
  JOIN Activity a
      ON f.player_id = a.player_id
      AND a.event_date = f.first_date + INTERVAL 1 DAY
  
  This joins the FirstLogin table back to the original Activity table, but only keeps matches where the activity date equals first_date + 1 day. In other words: "does this player have a row in Activity exactly one day after their first login?"
  
  Player 1: first day 03-01, and there IS a row for 03-02 → match ✅
  Player 2: first day 06-25, no row for 06-26 → no match ❌
  Player 3: first day 03-02, no row for 03-03 → no match ❌
  
  Only Player 1 survives this join.
  
  3. Calculate the fraction
  
  sql
  COUNT(DISTINCT a.player_id) * 1.0 / (SELECT COUNT(*) FROM FirstLogin)
  COUNT(DISTINCT a.player_id) = number of players who came back the next day = 1.
  (SELECT COUNT(*) FROM FirstLogin) = total number of unique players = 3.
  1 * 1.0 / 3 = 0.333... → rounded to 0.33 ✅
  
  Mental model: Think of it in two steps — first figure out "Day 1" for every player, then check which players have an activity record on "Day 1 + 1." The join only keeps the ones who do, so counting the join's survivors versus the total player count gives you the fraction.
  
  Why INTERVAL 1 DAY? This is MySQL syntax for date arithmetic — it adds exactly one day to a date. In other databases you might see first_date + 1 (Postgres) or DATEADD(day, 1, first_date) (SQL Server) instead.
