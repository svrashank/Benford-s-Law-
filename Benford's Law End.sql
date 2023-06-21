DROP TABLE IF EXISTS digit_1l;
CREATE TABLE digit_1l(
SELECT COUNT(new_cases) as num_cases from Covid_deaths 
WHERE new_cases regexp '1$');

SELECT * from digit_1l ;

CREATE TABLE digit_2l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '2$');

CREATE TABLE digit_3l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '3$');

CREATE TABLE digit_4l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '4$');

CREATE TABLE digit_5l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '5$');

CREATE TABLE digit_6l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '6$');

CREATE TABLE digit_7l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '7$');

CREATE TABLE digit_8l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '8$');

CREATE TABLE digit_9l(
SELECT COUNT(new_cases) from Covid_deaths 
WHERE new_cases regexp '9$');

DROP table IF EXISTS benfords_end;
CREATE TABLE benfords_end(
SELECT * FROM digit_1l UNION ALL
SELECT * FROM digit_2l UNION ALL
SELECT * FROM digit_3l UNION ALL
SELECT * FROM digit_4l UNION ALL
SELECT * FROM digit_5l UNION ALL
SELECT * FROM digit_6l UNION ALL 
SELECT * FROM digit_7l UNION ALL
SELECT * FROM digit_8l UNION ALL
SELECT * FROM digit_9l ) ;

DROP TABLE IF EXISTS benfords_law_end;
CREATE TABLE benfords_law_end (
SELECT row_number() OVER (ORDER BY (SELECT NULL)) AS DIGIT,num_cases from benfords_end);


-- Calculate the percentages of each digit appearing in the dataset 
CREATE VIEW Benfords_law_verified_end AS
SELECT DIGIT, num_cases,num_cases *100/ sum(num_cases) OVER() AS
 Covid_dataset_percentage FROM benfords_law_end;

