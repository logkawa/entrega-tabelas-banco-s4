SELECT i.ID, i.name, COUNT(t.sec_id)  AS num_secoes
FROM instructor i
LEFT OUTER JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name
ORDER BY i.ID;

SELECT i.ID, i.name, (SELECT COUNT(teaches.sec_id) FROM teaches WHERE i.ID = teaches.ID) AS num_secoes
FROM instructor i
GROUP BY i.ID, i.name
ORDER BY i.ID;

-- 3° questão pelo ODBC

-- select course_id, sec_id, i.ID, semester, [year], IIF{name is null, '-', name} as name FROM
-- (select s.course_id, s.sec_id, s.semester, s.[year], t.ID from {
--     section s 
--     left outer join teaches t on s.course_id = t.course_id and s.sec_id = t.sec_id and s.semester = t.semester and s.[year] = t.[year]
-- })
-- section_teaches 
-- left outer join instructor i on i.ID = section_teaches.ID
-- where semester = 'Spring' and year = 2010;

-- 3° questão pelo MySQL
SELECT 
    s.course_id,
    s.sec_id,
    i.ID,
    s.semester,
    s.year,
    COALESCE(i.name, '-') AS name
FROM section s
LEFT JOIN teaches t 
    ON s.course_id = t.course_id 
    AND s.sec_id = t.sec_id 
    AND s.semester = t.semester 
    AND s.year = t.year
LEFT JOIN instructor i 
    ON i.ID = t.ID
WHERE s.semester = 'Spring' 
  AND s.year = 2010;



-- 4º questão
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

GO

CREATE VIEW grade_points AS
SELECT 
  grade,
  CASE 
    WHEN grade = 'A+' THEN 4.0
    WHEN grade = 'A'  THEN 3.7
    WHEN grade = 'A-' THEN 3.3
    WHEN grade = 'B+' THEN 3.0
    WHEN grade = 'B'  THEN 2.7
    WHEN grade = 'B-' THEN 2.3
    WHEN grade = 'C+' THEN 2.0
    WHEN grade = 'C'  THEN 1.7
    WHEN grade = 'C-' THEN 1.3
    ELSE 0
  END AS points
FROM takes
GROUP BY grade;

GO

SELECT 
  t.ID, 
  s2.name, 
  c.title, 
  c.dept_name, 
  t.grade, 
  g.points,
  c.credits, 
  (c.credits * g.points) AS "Points totais"
FROM takes t
JOIN section s 
  ON t.course_id = s.course_id 
 AND t.sec_id = s.sec_id
 AND t.semester = s.semester
 AND t.year = s.year
JOIN course c 
  ON t.course_id = c.course_id
JOIN grade_points g 
  ON t.grade = g.grade
JOIN student s2 
  ON s2.ID = t.ID 
 AND s2.dept_name = c.dept_name
ORDER BY t.ID, s2.name, c.title;


GO
CREATE VIEW coeficiente_rendimento AS
SELECT 
  t.ID, 
  s2.name, 
  c.title, 
  c.dept_name, 
  t.grade, 
  g.points,
  c.credits, 
  (c.credits * g.points) AS points_totais
FROM takes t
JOIN section s 
  ON t.course_id = s.course_id 
 AND t.sec_id = s.sec_id
 AND t.semester = s.semester
 AND t.year = s.year
JOIN course c 
  ON t.course_id = c.course_id
JOIN grade_points g 
  ON t.grade = g.grade
JOIN student s2 
  ON s2.ID = t.ID 
 AND s2.dept_name = c.dept_name;