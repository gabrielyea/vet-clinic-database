
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

/*---------------TRANSACTIONS ------------------*/

/* Transaction, drop species from and animals and then rollback changes */
BEGIN;

ALTER TABLE
animals
DROP COLUMN species;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals; 

/* Set species to pokemons or digimons */
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name ~'[A-Za-z]mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

/* Delete animals and rollback changes with no commit */
BEGIN;
DELETE FROM animals
ROLLBACK;


/* Big transaction */
BEGIN;

DELETE FROM animals
WHERE date_of_birth > 'jan/01/2022';

SAVEPOINT save1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO save1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT; 

/* Total animals */
SELECT COUNT (*)
FROM animals;

/* Total animals that never escpaed */
SELECT COUNT (*)
FROM animals
WHERE escape_attempts = 0;

/* Avarage weiht */
SELECT AVG(weight_kg) FROM animals; 

/* Total escape attempts by neutered */
SELECT neutered, SUM (escape_attempts)
FROM animals
GROUP BY neutered;

/* MAX and MIN weight by species */
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species; 

/* AVG escape attempts between dates */
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN 'jan/01/1990' AND 'DEC/31/2000'
GROUP BY species; 

/*--------------MULTIPLE QUERIES ------------------*/

/* Animals owned by melody pond */
SELECT 
animals.name,
owners.full_name 
FROM animals
JOIN owners ON owners.id = animals.owner_id
where owners.full_name = 'Melody Pond';

/* All pokemons */
SELECT 
animals.name,
species.name
FROM animals
JOIN species ON species.id = animals.species_id 
where species.name = 'Pokemon';

/* All owners even without animals */
SELECT 
owners.full_name,
animals.name

FROM owners
left JOIN animals 
ON animals.owner_id = owners.id

/* Count by type */
SELECT 
species.name,
count(animals)
FROM animals
JOIN species 
ON animals.species_id = species.id
group by species.name;

/* All Digimons owned by jennifer orwell */
SELECT 
animals.name,
species.name,
owners.full_name
FROM animals
JOIN owners
ON owners.id = animals.owner_id
join species
on species.id = animals.species_id
where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell'


/* All Animals owned by dean that havent tried to escape */
SELECT 
animals.name,
animals.escape_attempts ,
owners.full_name
FROM animals
JOIN owners
ON owners.id = animals.owner_id
where owners.full_name = 'Dean Winchester' and escape_attempts = 0;

/* Owner that has the most animals */
SELECT 
count(owners.full_name),
owners.full_name
FROM owners
JOIN animals
ON owners.id = animals.owner_id
group by owners.full_name 
order by count(*) desc limit 1
