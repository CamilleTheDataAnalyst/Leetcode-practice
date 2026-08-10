-- 1757. Recyclable and Low Fat Products
-- https://leetcode.com/problems/recyclable-and-low-fat-products/description/?envType=study-plan-v2&envId=top-sql-50
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';

Notes:
SELECT product_id → "Just give me the product's ID number."
FROM Products → "Look on the Products shelf."
WHERE low_fats = 'Y' AND recyclable = 'Y' → "Only keep products where the low-fat sticker is Yes AND the recyclable sticker is Yes."

The one magic word is AND — it means both things must be true at the same time. Like needing your ticket AND your ID to get into a movie: having just one won't get you in. 🎟️

That's the key contrast to remember:
AND = strict — both conditions must pass.
OR = generous — just one is enough (that was Big Countries, #595).
