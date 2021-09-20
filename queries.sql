
/*Matches animals that end in mon*/

SELECT *
FROM animals
WHERE name ~ '[A-Za-z]+mon';

/*Matches animals between 2016 and 2019*/
SELECT *
FROM animals
WHERE date_of_birth > '1/1/2016' 
AND date_of_birth < '1/1/2019';

/*Matches animals neutered with less than 3 escapes*/
SELECT *
FROM animals
WHERE neutered = TRUE
AND escape_attempts < 3;
