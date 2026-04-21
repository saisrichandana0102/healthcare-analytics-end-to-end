CREATE DATABASE AxonHealthCare;
USE AxonHealthCare;

SHOW TABLES;

SELECT * FROM doctor;
ALTER TABLE doctor RENAME COLUMN `ï»¿Doctor ID` TO `Doctor ID`;

SELECT * FROM labresult;
ALTER TABLE labresult RENAME COLUMN `ï»¿Lab Result ID` TO `Lab Result ID`;

SELECT * FROM treatment;
ALTER TABLE treatment RENAME COLUMN `ï»¿Treatment ID` TO `Treatment ID`;

SELECT * FROM visit;
ALTER TABLE visit RENAME COLUMN `ï»¿Visit ID` TO `Visit ID`;

----- DATA COUNT VALIDATION

SELECT COUNT(*) FROM patient;
SELECT COUNT(*) FROM doctor;
SELECT COUNT(*) FROM visit;
SELECT COUNT(*) FROM treatment;
SELECT COUNT(*) FROM labresult;


----- DATA COMPLETENESS CHECK

SELECT * FROM patient WHERE `First Name` IS NULL OR LastName IS NULL;
SELECT * FROM visit WHERE `Visit Type` IS NULL OR `Visit Date` IS NULL;
SELECT * FROM treatments WHERE `Treatment Name` IS NULL OR Status IS NULL;
SELECT * FROM labresult WHERE `Test Name` IS NULL OR `Test Result` IS NULL;

----- DATA CONSISTENCY CHECK 

SELECT V.`Visit ID`, V.`Patient ID`, P.`Patient ID` 
from visit V
LEFT JOIN patient P ON V.`Patient ID` = P.`Patient ID`
WHERE P.`Patient ID` IS NULL;

SELECT T.`Treatment ID`, T.`Visit ID`, V.`Visit ID`
FROM treatment T
LEFT JOIN visit V on T.`Visit ID` = V.`Visit ID`
WHERE V.`Visit ID` IS NULL;

----- DUPLICATE RECORDS CHECK

SELECT `Patient ID`, COUNT(*)
FROM patient
GROUP BY `Patient ID`
HAVING COUNT(*) > 1;

SELECT `Visit ID`, COUNT(*)
FROM visit
GROUP BY `Visit ID`
HAVING COUNT(*) > 1;

----- DASHBOARD AGGREGATION CHECK

SELECT SUM(`Treatment Cost`) FROM treatments;
SELECT AVG(age) FROM patient;

----- PERFORMANCE TESTING (QUERY EXECUTION TIME)

EXPLAIN ANALYZE
SELECT * FROM visit WHERE `Visit Date` BETWEEN '2023-01-01' AND '2023-12-31';


