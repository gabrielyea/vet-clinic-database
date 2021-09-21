
SELECT *
FROM animals
WHERE name ~ '[A-Za-z]+mon';

SELECT name
FROM animals
WHERE date_of_birth 
BETWEEN '1-1-2016' 
AND '12-31-2019';

SELECT name
FROM animals
WHERE neutered = TRUE
AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE name = 'Agumon'
OR name = 'Pikachu';

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT *
FROM animals
WHERE neutered;

SELECT *
FROM animals
WHERE NOT name = 'Gabumon';

SELECT *
FROM animals
WHERE weight_kg
BETWEEN 10.4 
AND 17.3;


/* Transaction, drop species from and animals and then rollback changes */
BEGIN;

ALTER TABLE
public.animals
DROP COLUMN species;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals; 

/* Set species to pokemons or digimons */
BEGIN;
UPDATE public.animals
SET species = 'digimon'
WHERE name ~'[A-Za-z]mon';

UPDATE public.animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
