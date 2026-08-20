-- 1934. Confirmation Rate
-- https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.user_id,
       ROUND(IFNULL(
         SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(c.action),
       0), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;

    Notes:
    1. Keep every user (LEFT JOIN). 
    Start from Signups (which has everyone) and attach their confirmation rows. LEFT means users like #6 — who never got any messages — still stay in the answer instead of vanishing.

    2. Count the confirmed ones (the new trick: CASE WHEN). 
    This is the clever part. CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END is a tiny if/else you drop right into the query: "if this row is confirmed, write a 1; otherwise write a 0." Then SUM(...) adds up all those 1s and 0s — giving you the count of just the confirmed messages. It's how you count only rows that meet a condition. 

    3. Divide to get the rate. ➗
    COUNT(c.action) = total messages the user got. So confirmed ÷ total = the rate. User 2 had 1 confirmed out of 2 → 0.50.

    4. Handle "no messages" (IFNULL). 
    User 6 got zero messages → you'd be dividing by zero, which comes out as nothing (null). IFNULL(..., 0) says "if the answer is null, use 0 instead" — turning user 6's rate into a clean 0.00.

    5. Round it (ROUND(..., 2)). 
    Trim to two decimal places, like the problem asks.

    So the whole thing reads: "For every user, count their confirmed messages, divide by their total messages, call it 0 if they had none, and round to two decimals." 

    The two new tools to pocket:

    CASE WHEN ... THEN 1 ELSE 0 END inside SUM = count only rows that meet a condition (a mini if/else in SQL — you'll use this everywhere).
    IFNULL(x, 0) = "if it's blank, use this fallback instead" — perfect for avoiding divide-by-zero holes.
