-- 584. Find Customer Referee
-- https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;

Notes:
  SELECT name → "Just give me their names."
  FROM Customer → "Look in the Customer list."
  WHERE referee_id != 2 → "Keep everyone whose inviter is not #2." (!= means "not equal to.")
  OR referee_id IS NULL → "AND also keep the people with an empty note."
