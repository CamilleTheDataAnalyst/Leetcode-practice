-- 1683. Invalid Tweets
-- https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50

SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;

NOTES:
LENGTH(content) → measures how many characters are in each tweet's text (a function that transforms the value before comparing). 
> 15 → "strictly greater than 15" means more than 15, not 15 itself. So a 15-character tweet is still fine; 16+ is invalid.
SELECT tweet_id → just hand back the ID of each too-long tweet.
