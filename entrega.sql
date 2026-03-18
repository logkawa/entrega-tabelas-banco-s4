SELECT i.ID, i.name, COUNT(t.sec_id)  AS num_secoes
FROM instructor i
LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name
ORDER BY i.ID;


SELECT 
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    t.grade,
    points.p AS points,
    c.credits,
    (c.credits * points.p) AS "Pontos totais"
FROM takes t
JOIN student s 
    ON t.ID = s.ID
JOIN course c 
    ON t.course_id = c.course_id
JOIN (
    SELECT 'A+' AS grade, 4.0 AS p UNION ALL
    SELECT 'A', 3.7 UNION ALL
    SELECT 'A-', 3.4 UNION ALL
    SELECT 'B+', 3.1 UNION ALL
    SELECT 'B', 2.7 UNION ALL
    SELECT 'B-', 2.3 UNION ALL
    SELECT 'C+', 2.0 UNION ALL
    SELECT 'C', 1.7 UNION ALL
    SELECT 'C-', 1.3 UNION ALL
    SELECT 'D', 1.0
) points 
    ON t.grade = points.grade
ORDER BY s.ID, c.title;

CREATE VIEW student_course_points AS
SELECT 
    s.ID,
    s.name,
    c.title,
    c.dept_name,
    t.grade,
    points.p AS points,
    c.credits,
    (c.credits * points.p) AS "Pontos totais"
FROM takes t
JOIN student s 
    ON t.ID = s.ID
JOIN course c 
    ON t.course_id = c.course_id
JOIN (
    SELECT 'A+' AS grade, 4.0 AS p UNION ALL
    SELECT 'A', 3.7 UNION ALL
    SELECT 'A-', 3.4 UNION ALL
    SELECT 'B+', 3.1 UNION ALL
    SELECT 'B', 2.7 UNION ALL
    SELECT 'B-', 2.3 UNION ALL
    SELECT 'C+', 2.0 UNION ALL
    SELECT 'C', 1.7 UNION ALL
    SELECT 'C-', 1.3 UNION ALL
    SELECT 'D', 1.0
) points 
    ON t.grade = points.grade;