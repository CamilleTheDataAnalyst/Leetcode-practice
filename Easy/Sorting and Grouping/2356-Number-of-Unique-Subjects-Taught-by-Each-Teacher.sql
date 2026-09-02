-- 2356. Number of Unique Subjects Taught by Each Teacher
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/?envType=study-plan-v2&envId=top-sql-50

SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;

  Notes:
  This is a clean GROUP BY + AVG — you've got all the tools. Let me guide you (this is from your SQLBolt Employees table).
  
  Step 1: Spot the "for each role" clue. 🗂️
  "For each role" means you're bundling employees by their Role and computing something per group. That's GROUP BY Role.
  
  Step 2: What to compute per group.
  "Average number of years employed" → average the Years_employed column within each role group. That's AVG(Years_employed).
  
  Step 3: What to SELECT.
  You want the role name and its average:
  
  SELECT Role, AVG(Years_employed)
  
  Step 4: Assemble it.
  
  sql
  SELECT Role, AVG(Years_employed)
  FROM Employees
  GROUP BY Role;
  
  Step 5: Trace it. 🔍
  Look at the Engineers: Becky (4), Dan B. (2), Sharon (6), Dan M. (4), Malcom (1). GROUP BY Role piles all five together, and AVG(Years_employed) = (4+2+6+4+1)/5 = 3.4. Artists get their own pile with their own average. ✓
  
  That's the whole thing:
  
  sql
  SELECT Role, AVG(Years_employed)
  FROM Employees
  GROUP BY Role;
  
  The pattern to recognize: "for each ___, find the average/count/total of ___" is almost always GROUP BY [the "each" thing] + an aggregate (AVG/COUNT/SUM) on the other thing. You've now done this shape several times (Project Employees, Average Time per Machine) — it's becoming second nature. 🔥
  
  One optional polish: if you want the average rounded, wrap it — ROUND(AVG(Years_employed), 2). And you can name the column with AS years if you'd like a cleaner header. Give it a run!
