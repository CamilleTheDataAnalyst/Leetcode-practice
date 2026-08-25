-- 1075. Project Employees I
-- https://leetcode.com/problems/project-employees-i/submissions/2119585171/?envType=study-plan-v2&envId=top-sql-50

SELECT p.project_id,
       ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;

  Notes:
  The story:
  
  1. Look up each person's experience (JOIN). 
  The Project list only knows people by ID number. To find out how experienced each one is, you staple on the Employee list, matching by employee_id. Now every "person on a project" row also carries that person's years of experience. INNER JOIN is fine here — every project member exists in the Employee table.
  
  2. Bundle by project and average (GROUP BY + AVG). 
  GROUP BY p.project_id scoops all the people on the same project into one pile, and AVG(e.experience_years) finds the average experience of that pile. Project 1: (3+2+1)/3 = 2.00. ✓
  
  3. Round it (ROUND(..., 2)). 
  Trim to 2 decimal places, and AS average_years names the column to match the output.
  
  So the whole thing reads: "For each project, look up how experienced each member is, then average those numbers and round to 2 decimals." 
  
  Nothing brand-new here — it's a clean combo of tools you already own: JOIN (to pull experience from the other table) + GROUP BY + AVG (to average per project) + ROUND. This is the "look up a value in another table, then aggregate per group" pattern, same skeleton as Project Sales and Average Time per Machine. 
