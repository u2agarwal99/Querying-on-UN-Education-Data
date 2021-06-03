drop schema if exists educationdata cascade;
create schema educationdata;
set search_path to educationdata;

-- All Subregions of the world
create table Subregions (
	-- the name of the subregion
	region VARCHAR(60) primary key,
	check (region='sub-saharan africa' OR region='northern africa' OR
		region='western asia' OR region='central asia' OR
		region='southern asia' OR region='eastern asia' OR
		region='south-eastern asia' OR region='latin america and the caribbean' OR region='oceania' OR region='europe' OR
		region='northern america'));

-- All countries of the world other than Antarctica
create table Countries (
	-- the name of the country
	country VARCHAR(60) primary key,
	-- the name of the subregion the country belongs to
	region VARCHAR(60) references Subregions not null,
	check (country!='antarctica'));

-- A row in this table indicates that a region had median data for a yearRange at an educationLevel
create table RegionData(
	-- the name of the subregion
	region VARCHAR(60) references Subregions not null, 
	-- the education level this data is for
	educationLevel VARCHAR(11) not null, 
	-- the year range this data is for
	yearRange VARCHAR(9) not null, 
	-- the number of teachers (in thousands)
	Teachers REAL not null, 
	-- the ratio of pupils to teachers 
	pupilTeacherRatio REAL not null, 
	-- the ratio of male students enrolled to the number of children at the corresponding age-level
	grossEnrollmentRatioMale REAL not null, 
	-- the ratio of female students enrolled to the number of children at the corresponding age-level
	grossEnrollmentRatioFemale REAL not null,
	check (educationLevel='Primary' OR educationLevel='Secondary' OR
		educationLevel='Tertiary'),
	check (yearRange='2005-2010' OR yearRange='2010-2015'),
	primary key (region, educationLevel, yearRange));

-- A row in this table indicates that a country had median data for a yearRange at an educationLevel
create table CountryData (
	-- the name of the country
	country VARCHAR(60) references Countries not null, 
	-- the education level this data is for
	educationLevel VARCHAR(9) not null, 
	-- the year range this data is for
	yearRange VARCHAR(9) not null, 
	-- the percentage of government expenditure on education
	publicExpenditure REAL not null check (publicExpenditure >= 0 AND
	publicExpenditure <= 100), 
	-- the number of teachers (in thousands)
	Teachers REAL not null, 
	-- the ratio of pupils to teachers 
	pupilTeacherRatio REAL not null, 
	-- the ratio of male students enrolled to the number of children at the corresponding age-level
	grossEnrollmentRatioMale REAL not null, 
	-- the ratio of female students enrolled to the number of children at the corresponding age-level
	grossEnrollmentRatioFemale REAL not null,
	check (educationLevel='Primary' OR educationLevel='Secondary' OR
		educationLevel='Tertiary'),
	check (yearRange='2005-2010' OR yearRange='2010-2015'),
	primary key (country, educationLevel, yearRange));

-- A row in this table indicates that a country spent percentage amount of their gdp on education that year
create table CountryEdExpendPerGDP (
	-- the name of the country
	country VARCHAR(60) references Countries not null, 
	-- the year for which this percentage is for
	year SMALLINT check (year BETWEEN 1950 AND 2020)  not null, 
	-- the percentage of gdp spent on education
	percentage REAL check (percentage>=0) not null,
	primary key (country, year));

-- A row in this table indicates that a country spent percentage amount of expenditure on education that year
create table CountryEdExpendPerOthers (
	-- the name of the country
	country VARCHAR(60) references Countries not null, 
	-- the year for which this percentage is for
	year SMALLINT check (year BETWEEN 1950 AND 2020)  not null, 
	-- the percentage of government expenditure spent on education
	percentage REAL not null,
	check (percentage>=0 AND percentage<=100),
	primary key (country, year));
