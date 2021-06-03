DROP TABLE IF EXISTS q1 cascade;
DROP TABLE IF EXISTS q1a cascade;
DROP TABLE IF EXISTS q1b cascade;
DROP TABLE IF EXISTS q1c cascade;
DROP TABLE IF EXISTS q2 cascade;
DROP TABLE IF EXISTS q3 cascade;


CREATE TABLE q1 (
    Region VARCHAR(60) NOT NULL,
    educationLevel VARCHAR(9) NOT NULL,
    yearRange VARCHAR(9) NOT NULL,
    minMaleGER REAL NOT NULL,
    maxMaleGER REAL NOT NULL,
    avgMaleGER REAL NOT NULL,
    minFemaleGER REAL NOT NULL,
    maxFemaleGER REAL NOT NULL,
    avgFemaleGER REAL NOT NULL,
    minPupilTRatio REAL NOT NULL,
    maxPupilTRatio REAL NOT NULL,
    avgPupilTRatio REAL NOT NULL
);


INSERT INTO q1
SELECT region, educationLevel, yearRange,
   min(grossEnrollmentRatioMale) as minMaleGER,
   max(grossEnrollmentRatioMale) as maxMaleGER,
   avg(grossEnrollmentRatioMale) as avgMaleGER,
   min(grossEnrollmentRatioFemale) as minFemaleGER,
   max(grossEnrollmentRatioFemale) as maxFemaleGER,
   avg(grossEnrollmentRatioFemale) as avgFemaleGER,
   min(pupilTeacherRatio) as minPupilTRatio,
   max(pupilTeacherRatio) as maxPupilTRatio,
   avg(pupilTeacherRatio) as avgPupilTRatio
FROM CountryData NATURAL JOIN Countries
GROUP BY region, educationLevel, yearRange
ORDER BY region, educationLevel, yearRange;

CREATE TABLE q1a (
    Region VARCHAR(60),
    minMaleGER REAL,
    maxMaleGER REAL,
    avgMaleGER REAL,
    minFemaleGER REAL,
    maxFemaleGER REAL,
    avgFemaleGER REAL,
    minPupilTRatio REAL,
    maxPupilTRatio REAL,
    avgPupilTRatio REAL
);

INSERT INTO q1a
SELECT region,
    min(minMaleGER) as minMaleGER,
    max(maxMaleGER) as maxMaleGER,
    avg(avgMaleGER) as avgMaleGER,
    min(minFemaleGER) as minFemaleGER,
    max(maxFemaleGER) as maxFemaleGER,
    avg(avgFemaleGER) as avgFemaleGER,
    min(minPupilTRatio) as minPupilTRatio,
    max(maxPupilTRatio) as maxPupilTRatio,
    avg(avgPupilTRatio) as avgPupilTRatio
FROM q1
GROUP BY region;


CREATE TABLE q1b (
    educationLevel VARCHAR(9),
    minMaleGER REAL,
    maxMaleGER REAL,
    avgMaleGER REAL,
    minFemaleGER REAL,
    maxFemaleGER REAL,
    avgFemaleGER REAL,
    minPupilTRatio REAL,
    maxPupilTRatio REAL,
    avgPupilTRatio REAL
);

INSERT INTO q1b
SELECT educationLevel,
    min(minMaleGER) as minMaleGER,
    max(maxMaleGER) as maxMaleGER,
    avg(avgMaleGER) as avgMaleGER,
    min(minFemaleGER) as minFemaleGER,
    max(maxFemaleGER) as maxFemaleGER,
    avg(avgFemaleGER) as avgFemaleGER,
    min(minPupilTRatio) as minPupilTRatio,
    max(maxPupilTRatio) as maxPupilTRatio,
    avg(avgPupilTRatio) as avgPupilTRatio
FROM q1
GROUP BY educationLevel;


CREATE TABLE q1c (
    Region VARCHAR(60),
    educationLevel VARCHAR(9),
    minMaleGER REAL,
    maxMaleGER REAL,
    avgMaleGER REAL,
    minFemaleGER REAL,
    maxFemaleGER REAL,
    avgFemaleGER REAL,
    minPupilTRatio REAL,
    maxPupilTRatio REAL,
    avgPupilTRatio REAL
);

INSERT INTO q1c
SELECT region, educationLevel,
    min(minMaleGER) as minMaleGER,
    max(maxMaleGER) as maxMaleGER,
    avg(avgMaleGER) as avgMaleGER,
    min(minFemaleGER) as minFemaleGER,
    max(maxFemaleGER) as maxFemaleGER,
    avg(avgFemaleGER) as avgFemaleGER,
    min(minPupilTRatio) as minPupilTRatio,
    max(maxPupilTRatio) as maxPupilTRatio,
    avg(avgPupilTRatio) as avgPupilTRatio
FROM q1
GROUP BY region, educationLevel;


CREATE TABLE q2 (
    educationLevel VARCHAR(9) NOT NULL,
    yearRange VARCHAR(9) NOT NULL,
    minMaleGER REAL NOT NULL,
    maxMaleGER REAL NOT NULL,
    avgMaleGER REAL NOT NULL,
    minFemaleGER REAL NOT NULL,
    maxFemaleGER REAL NOT NULL,
    avgFemaleGER REAL NOT NULL,
    minPupilTRatio REAL NOT NULL,
    maxPupilTRatio REAL NOT NULL,
    avgPupilTRatio REAL NOT NULL

);


INSERT INTO q2
SELECT educationLevel, yearRange,
   min(minMaleGER) as minMaleGER,
   max(maxMaleGER) as maxMaleGER,
   avg(avgMaleGER) as avgMaleGER,
   min(minFemaleGER) as minFemaleGER,
   max(maxFemaleGER) as maxFemaleGER,
   avg(avgFemaleGER) as avgFemaleGER,
   min(minPupilTRatio) as minPupilTRatio,
   max(maxPupilTRatio) as maxPupilTRatio,
   avg(avgPupilTRatio) as avgPupilTRatio
FROM q1
GROUP BY educationLevel, yearRange;

CREATE TABLE q3 (
  country VARCHAR(60),
  yearRange VARCHAR(9) NOT NULL,
  expenditure REAL NOT NULL,
  pupilTRatio REAL NOT NULL,
  teachers  REAL NOT NULL
);

INSERT INTO q3
SELECT country, yearRange,
   sum(publicExpenditure), avg(pupilTeacherRatio), sum(Teachers)
FROM CountryData
GROUP BY country, yearRange
ORDER BY country, yearRange;

SELECT * FROM q1;
SELECT * FROM q1a;
SELECT * FROM q1b;
SELECT * FROM q1c;
SELECT * FROM q2;
SELECT * FROM q3;
