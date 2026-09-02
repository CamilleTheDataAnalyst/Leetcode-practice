-- 2356. Number of Unique Subjects Taught by Each Teacher
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

  Notes:
  1. Bundle by teacher (GROUP BY teacher_id). 🗂️
  Pile up all the rows belonging to each teacher into one group — teacher 1's rows in one pile, teacher 2's in another.
  
  2. Count the DISTINCT subjects (the key twist). 🎯
  COUNT(DISTINCT subject_id) counts how many different subject IDs are in each pile — throwing out repeats first.
  
  Teacher 1's subjects: 2, 2, 3 → unique ones are {2, 3} → count = 2. ✓ (The duplicate 2 only counts once.)
  Teacher 2's subjects: 1, 2, 3, 4 → all different → count = 4. ✓
  
  3. Name it (AS cnt). ✏️
  Rename the count to match the output header.
  
  So the whole thing reads: "For each teacher, count how many distinct subjects they teach." 📚
  
  The one thing to bank here is a small but important combo you haven't used yet:
  
  COUNT(DISTINCT column) = count unique values, ignoring duplicates.
  
  Compare the three counting flavors you now know:
  
  COUNT(*) → counts all rows (would give teacher 1 → 3, wrong here).
  COUNT(column) → counts non-null rows (ignores nulls).
  COUNT(DISTINCT column) → counts unique values (the right tool this time).
  
  Whenever a question says "how many different/unique X," that's your cue to slip DISTINCT inside the COUNT. 🔥
