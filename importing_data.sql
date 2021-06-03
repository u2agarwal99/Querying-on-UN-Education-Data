--Load the Schema
\i schema.ddl


--Setting regions and countries data
CREATE table CountriesAndRegions (
country VARCHAR(60) primary key,
region VARCHAR(60),
subregion VARCHAR(60));

\copy CountriesAndRegions from 'countries_and_regions_cleaned.csv' with csv;

UPDATE CountriesAndRegions SET country = 'china, hong kong sar' WHERE country='hong kong';
UPDATE CountriesAndRegions SET country = 'china, macao sar' WHERE country='macao';
UPDATE CountriesAndRegions SET country = 'british virgin islands' WHERE country='virgin islands';

DELETE FROM CountriesAndRegions 
WHERE country='antarctica';

UPDATE CountriesAndRegions SET subregion = region WHERE region='europe' or region='oceania';

INSERT INTO Subregions 
(SELECT DISTINCT subregion from CountriesAndRegions);

INSERT INTO Countries
(SELECT DISTINCT country, subregion from CountriesAndRegions);

DROP table CountriesAndRegions;

-- Setting expenditure data tables

\copy CountryEdExpendPerGDP  from 'expend_per_gdp.csv' with csv;

\copy CountryEdExpendPerOthers  from 'expend_per_others.csv' with csv;

-- Setting main tables

CREATE table TeachersData(
area VARCHAR(60),
teachers REAL,
yearRange VARCHAR(9),
educationLevel VARCHAR(9),
primary key (area, yearRange, educationLevel));

\copy TeachersData from 'teachers.csv' with csv;

CREATE table PupilTeacherRatioData(
area VARCHAR(60),
pupilTeacherRatio REAL,
yearRange VARCHAR(9),
educationLevel VARCHAR(9),
primary key (area, yearRange, educationLevel));

\copy PupilTeacherRatioData from 'pupil_teacher_ratio.csv' with csv;

CREATE table GrossEnrollmentRatioMaleData(
area VARCHAR(60),
grossEnrollmentRatioMale REAL,
yearRange VARCHAR(9),
educationLevel VARCHAR(9),
primary key (area, yearRange, educationLevel));

\copy GrossEnrollmentRatioMaleData from 'ger_male.csv' with csv;

CREATE table GrossEnrollmentRatioFemaleData(
area VARCHAR(60),
grossEnrollmentRatioFemale REAL,
yearRange VARCHAR(9),
educationLevel VARCHAR(9),
primary key (area, yearRange, educationLevel));

\copy GrossEnrollmentRatioFemaleData from 'ger_female.csv' with csv;

CREATE table ExpenditureData(
country VARCHAR(60) references Countries,
publicExpenditure REAL,
yearRange VARCHAR(9),
educationLevel VARCHAR(9),
primary key (country, yearRange, educationLevel));

\copy ExpenditureData from 'expenditure.csv' with csv;

CREATE VIEW all_but_expenditure AS SELECT * FROM (TeachersData NATURAL JOIN PupilTeacherRatioData NATURAL JOIN  GrossEnrollmentRatioMaleData NATURAL JOIN GrossEnrollmentRatioFemaleData);

INSERT INTO RegionData
(SELECT region, educationLevel, yearRange, teachers, pupilTeacherRatio, grossEnrollmentRatioMale, grossEnrollmentRatioFemale
 FROM Subregions NATURAL JOIN all_but_expenditure
 WHERE region=area);

INSERT INTO CountryData
(SELECT country, educationLevel, yearRange, publicExpenditure, teachers, pupilTeacherRatio, grossEnrollmentRatioMale, grossEnrollmentRatioFemale
 FROM ExpenditureData NATURAL JOIN all_but_expenditure
 WHERE country=area);

DROP VIEW all_but_expenditure;
DROP TABLE TeachersData;
DROP TABLE PupilTeacherRatioData;
DROP TABLE GrossEnrollmentRatioMaleData;
DROP TABLE GrossEnrollmentRatioFemaleData;
DROP TABLE ExpenditureData;

--Table Sizes
SELECT count(*) FROM Subregions;
SELECT count(*) FROM Countries;
SELECT count(*) FROM RegionData;
SELECT count(*) FROM CountryData;
SELECT count(*) FROM CountryEdExpendPerGDP;
SELECT count(*) FROM CountryEdExpendPerOthers;

--Sample Interaction
SELECT * FROM Subregions;
SELECT * FROM Countries;
SELECT * FROM RegionData;
SELECT * FROM CountryData;
SELECT * FROM CountryEdExpendPerGDP;
SELECT * FROM CountryEdExpendPerOthers;
