-- 1280. Students and Examinations
-- https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

SELECT Students.student_id, Students.student_name, Subjects.subject_name,
       COUNT(Examinations.subject_name) AS attended_exams
FROM Students
CROSS JOIN Subjects
LEFT JOIN Examinations 
  ON Students.student_id = Examinations.student_id 
  AND Subjects.subject_name = Examinations.subject_name
GROUP BY Students.student_id, Subjects.subject_name
ORDER BY Students.student_id, Subjects.subject_name;

  Notes:
  1. Build the full grid (CROSS JOIN). 
  Students CROSS JOIN Subjects pairs every student with every subject — 4 students × 3 subjects = 12 rows. This is your empty report card: Alice-Math, Alice-Physics, ... Alex-Programming. Every row that must appear in the answer now exists, even the ones nobody attended.
  
  2. Attach what actually happened (LEFT JOIN). 
  Now staple on the real exam log, matching by both student AND subject. LEFT keeps every grid row — so Alex-Math stays even though Alex never took Math; it just gets blanks (null) where the exam data would be.
  
  3. Count — but skip the blanks. 
  Here's the clever bit. COUNT(Examinations.subject_name) counts only the rows that came from the exam log — and COUNT(column) ignores nulls. So Alex-Math (all blanks) counts as 0, while Alice-Math (attended 3 times) counts as 3.
  
  If you'd written COUNT(*) instead, it would count the row itself — and Alex-Math still has 1 grid row, so you'd wrongly get 1 instead of 0. That's why counting a real exam-log column is the key.
  
  4. Bundle and sort. 
  GROUP BY collapses each student-subject pair into one line, and ORDER BY sorts it neatly by student then subject.
  
  So the whole thing reads: "Make a blank report card of every student × every subject, fill in the exams that really happened, and count them — writing 0 wherever nobody showed up." 📋
  
  The two big new ideas:
  
  CROSS JOIN = build every possible pairing (your "must appear" skeleton).
  COUNT(column) ignores nulls = the trick that turns empty combos into 0 instead of 1.
