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



-- Test whether the population of a country follows Benford's Law. 
-- The dataset here is way smaller than the new_cases dataset. 
-- Hence the results may not synanomious with the percentages of benfords law 

-- Create a Table that contains the country name and its population 
CREATE TABLE POPULATION (
select location ,population from Covid_deaths
WHERE continent not like '%0%'
group by location,population );

-- Create seperate tables for population of countries with the first digits ranging from 1-9 
DROP TABLE IF EXISTS digit_1_p;
CREATE TABLE digit_1_p(
SELECT COUNT(population) as population_count from POPULATION 
WHERE population regexp '^1');

CREATE TABLE digit_2_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^2');

CREATE TABLE digit_3_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^3');

CREATE TABLE digit_4_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^4');

CREATE TABLE digit_5_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^5');

CREATE TABLE digit_6_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^6');

CREATE TABLE digit_7_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^7');

CREATE TABLE digit_8_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^8');

CREATE TABLE digit_9_p(
SELECT COUNT(population) from POPULATION 
WHERE population regexp '^9');


-- union all the tables to form one dataset 
DROP table IF EXISTS benfords_population;
CREATE TABLE benfords_population(
SELECT * FROM digit_1_p UNION ALL
SELECT * FROM digit_2_p UNION ALL
SELECT * FROM digit_3_p UNION ALL
SELECT * FROM digit_4_p UNION ALL
SELECT * FROM digit_5_p UNION ALL
SELECT * FROM digit_6_p UNION ALL 
SELECT * FROM digit_7_p UNION ALL
SELECT * FROM digit_8_p UNION ALL
SELECT * FROM digit_9_p ) ;

-- Create the indexes from row numbers which also are the digits 
DROP TABLE IF EXISTS benfords_law_population;
CREATE TABLE benfords_law_population (
SELECT row_number() OVER (ORDER BY (SELECT NULL)) AS DIGIT,population_count from benfords_population);
SELECT * FROM benfords_law_population;

-- Calculate the percentages of digits appearing in this dataset 
CREATE VIEW Benfords_law_population_verify AS
SELECT DIGIT, population_count,population_count *100/ sum(population_count) OVER() AS
 population_count_percentage FROM benfords_law_population;
 
 -- Even with the small dataset (around 100 observations) we see some resemblences in the percentage 
 -- We can see that 1 is still the most frequent first digit 