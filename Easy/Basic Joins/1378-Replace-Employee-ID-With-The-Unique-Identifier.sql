-- 1378. Replace Employee ID With The Unique Identifier
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/submissions/2101501807/?envType=study-plan-v2&envId=top-sql-50

SELECT unique_id, name
FROM Employees
LEFT JOIN EmployeeUNI ON Employees.id = EmployeeUNI.id;

Notes:
  Imagine two notebooks.
  Notebook 1 (Employees): a list of everyone — each person's id and name.
  Notebook 2 (EmployeeUNI): only some people — their id and a special unique_id.
  SELECT unique_id, name → "Show me each person's special ID and their name." (These come from two different notebook)
  FROM Employees → "Start with the notebook that has everyone."
  LEFT JOIN EmployeeUNI → "Now go grab matching info from the second notebook and staple it on."
  ON Employees.id = EmployeeUNI.id → "Match them up by their id — same id = same person."

  
      INNER JOIN              LEFT JOIN
   ( only overlap )      ( all of left + overlap )

     A       B               A       B
    ( ( ✓ ) )               (((✓)) )
       ↑                      ↑   ↑
   just the match        everyone in A,
                         null if no match in B
