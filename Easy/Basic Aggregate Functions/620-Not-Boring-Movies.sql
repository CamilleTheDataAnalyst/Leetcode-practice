-- 620. Not Boring Movies
-- https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50

SELECT *
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

  Notes:  
  SELECT * → "Give me all the columns" (the * is a shortcut for "everything," instead of typing each column name).
  FROM Cinema → "Look in the movie list."
  WHERE id % 2 = 1 AND description != 'boring' → the two-part filter, joined by AND (both must be true).
  ORDER BY rating DESC → "Sort by rating, highest first."
  
  Two little tools worth remembering:
  
  1. % finds odd vs even (the new one). 
  % is the remainder after dividing. id % 2 asks "what's left over when you split the id into 2s?"
  
  Odd numbers leave a remainder of 1 → id % 2 = 1 means "odd."
  Even numbers leave 0 → id % 2 = 0 would mean "even."
  
  Think of it like pairing up socks: with 5 socks you make 2 pairs and have 1 leftover (odd); with 4 socks you make 2 pairs and have 0 leftover (even). 
  
  2. DESC flips the sort order. 
  ORDER BY normally goes small→big (ascending). Adding DESC makes it big→small — so the top-rated movie lands first. (The opposite, if you ever need it, is ASC, which is also the default.)
  
  So the whole thing reads: "From the movie list, keep the odd-ID movies that aren't boring, and show them best-rating-first." 
