-- Social media use and student outcomes
-- Table: students (created by load_data.py)


-- 1. Average daily social media hours by platform
SELECT platform,
       COUNT(*) AS students,
       ROUND(AVG(daily_hours), 1) AS avg_daily_hours
FROM students
GROUP BY platform
ORDER BY avg_daily_hours DESC;


-- 2. Sleep, social media use and GPA by school level
SELECT academic_level,
       COUNT(*) AS students,
       ROUND(AVG(sleep_hours), 1) AS avg_sleep,
       ROUND(AVG(daily_hours), 1) AS avg_daily_hours,
       ROUND(AVG(gpa), 2) AS avg_gpa
FROM students
GROUP BY academic_level;


-- 3. Sleep and GPA by daily social media use
SELECT CASE
           WHEN daily_hours < 3 THEN '1: under 3h'
           WHEN daily_hours < 5 THEN '2: 3-5h'
           WHEN daily_hours < 7 THEN '3: 5-7h'
           ELSE '4: 7h+'
       END AS usage_group,
       COUNT(*) AS students,
       ROUND(AVG(sleep_hours), 1) AS avg_sleep,
       ROUND(AVG(gpa), 2) AS avg_gpa
FROM students
GROUP BY usage_group;


-- 4. Mental health and stress by daily social media use
SELECT CASE
           WHEN daily_hours < 3 THEN '1: under 3h'
           WHEN daily_hours < 5 THEN '2: 3-5h'
           WHEN daily_hours < 7 THEN '3: 5-7h'
           ELSE '4: 7h+'
       END AS usage_group,
       COUNT(*) AS students,
       ROUND(AVG(mental_health_index), 1) AS avg_mental_health,
       ROUND(AVG(stress_score), 1) AS avg_stress
FROM students
GROUP BY usage_group;


-- 5. GPA and mental health by platform
SELECT platform,
       COUNT(*) AS students,
       ROUND(AVG(gpa), 2) AS avg_gpa,
       ROUND(AVG(mental_health_index), 1) AS avg_mental_health
FROM students
GROUP BY platform
ORDER BY avg_gpa DESC;
