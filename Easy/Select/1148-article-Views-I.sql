-- 1148. Article Views I
-- https://leetcode.com/problems/article-views-i/?envType=study-plan-v2&envId=top-sql-50

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

Notes:
WHERE author_id = viewer_id → "Only keep the lines where the writer and the reader are the same person." This is the heart of it — you're comparing one column to another column in the same row, not to a fixed number. If they match, the author read their own work. 
SELECT author_id AS id → "Give me the author's id — but rename the column to id." The AS word renames a column in the output (the answer wanted the header to say id, not author_id).
DISTINCT → "Only show each author once." The logbook can have duplicate lines (author 4 might appear twice), but you don't want 4, 4 in your answer — just 4. DISTINCT throws out the repeats. 
ORDER BY id → "Sort the results from smallest to biggest." (Ascending is the default, so you don't even need to say "ASC.") 
column = column → compare two columns in the same row
AS → rename a column in the output
DISTINCT → remove duplicate rows
ORDER BY → sort the results
