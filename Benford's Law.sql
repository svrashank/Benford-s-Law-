-- PART 2 : Test for Benford's Law 
-- Test whether new cases column follow Benfords law 

-- Uncomment the below code if the table Covid deaths doesn't read 


-- DROP TABLE IF EXISTS Covid_deaths;
-- CREATE TABLE Covid_deaths 
-- (
-- iso_code VARCHAR(255),
-- continent VARCHAR(255),
-- location VARCHAR(255),
-- RecordDate VARCHAR(255),
-- population BIGINT,
-- total_cases	BIGINT,
-- new_cases BIGINT,
-- new_cases_smoothed BIGINT,
-- total_deaths BIGINT,
-- new_deaths BIGINT, 
-- new_deaths_smoothed	BIGINT,
-- total_cases_per_million	BIGINT,
-- new_cases_per_million BIGINT,
-- new_cases_smoothed_per_million BIGINT,	
-- total_deaths_per_million BIGINT,
-- new_deaths_per_million BIGINT,
-- new_deaths_smoothed_per_million	BIGINT,
-- reproduction_rate BIGINT,
-- icu_patients BIGINT,
-- icu_patients_per_million BIGINT,
-- hosp_patients BIGINT,
-- hosp_patients_per_million BIGINT,	
-- weekly_icu_admissions BIGINT,
-- weekly_icu_admissions_per_million BIGINT,
-- weekly_hosp_admissions BIGINT,
-- weekly_hosp_admissions_per_million BIGINT
-- );

-- LOAD DATA INFILE 'Covid_Deaths.csv' INTO TABLE Covid_deaths
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES ;


-- Benford law states that the percentages of the first digits of numbers appearing in a dataset (1-9) are different.
-- The highest percentage is of 1 ,decreasing with every number following it 
-- lets get the count for first digit of new_cases ranging from 1-9 and save them in a new table 
-- The size of the dataset is optimal for the benford's law to show up 

-- Create tables for the count of num_cases that begins with digits ranging from 1-9
DROP TABLE IF EXISTS digit_1;
CREATE TABLE digit_1(
SELECT COUNT(new_cases) as num_cases from Covid_deaths 
WHERE new_cases regexp '^1');

CREATE TABLE digit_2(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^2');

CREATE TABLE digit_3(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^3');

CREATE TABLE digit_4(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^4');

CREATE TABLE digit_5(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^5');

CREATE TABLE digit_6(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^6');

CREATE TABLE digit_7(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^7');

CREATE TABLE digit_8(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^8');

CREATE TABLE digit_9(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '^9');


-- union all the tables to form one dataset 
DROP table IF EXISTS benfords;
CREATE TABLE benfords(
SELECT * FROM digit_1 UNION ALL
SELECT * FROM digit_2 UNION ALL
SELECT * FROM digit_3 UNION ALL
SELECT * FROM digit_4 UNION ALL
SELECT * FROM digit_5 UNION ALL
SELECT * FROM digit_6 UNION ALL 
SELECT * FROM digit_7 UNION ALL
SELECT * FROM digit_8 UNION ALL
SELECT * FROM digit_9 ) ;

-- Create indexes as row numbers which also corresponds to the digits  
DROP TABLE IF EXISTS benfords_law;
CREATE TABLE benfords_law (
SELECT row_number() OVER (ORDER BY (SELECT NULL)) AS DIGIT,num_cases from benfords);
SELECT * FROM benfords_law;

-- Calculate the percentages of each digit appearing in the dataset 
CREATE VIEW Benfords_law_verified AS
SELECT DIGIT, num_cases,num_cases *100/ sum(num_cases) OVER() AS
 Covid_dataset_percentage FROM benfords_law;



