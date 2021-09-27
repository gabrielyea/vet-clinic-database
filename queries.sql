
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
order by count(*) desc limit 1;

/*------------- MANY TO MANY RELATION TABLES ------------------*/

/* Last animals seen by william */
SELECT visits.date, animals.name, vets."name"
FROM visits
JOIN animals  ON visits.animal_id = animals.id 
JOIN vets ON vets.id = visits.vet_id 
where vets."name" = 'William Tatcher'
order by visits."date" desc limit 1; 

/* Animals seen by stephanie */
SELECT count(distinct animal_id), vets."name"
FROM visits 
JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id 
where vets."name" = 'Stephanie Mendez'
group by vets."name";

/* All vets and their specs (Even the ones with no spec)*/
SELECT vets."name", species."name" 
FROM vets
left JOIN specializations on specializations.vet_id = vets.id 
left join species on specializations.species_id = species.id ;

/* Visits to stephanie between dates */
SELECT visits.date, animals.name, vets.name
FROM visits
JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id
where vets."name" = 'Stephanie Mendez' and visits."date" between 'apr-01-2020' and 'aug-30-2020';

/* What animals has the most visits */
SELECT max(visitCount.count), visitCount.name

FROM (
	SELECT COUNT(visits."date"), animals."name" 
	FROM visits
	JOIN animals ON visits.animal_id = animals.id
	GROUP BY animals."name"
) AS visitCount

GROUP BY visitCount.name, visitCount.count
ORDER BY visitCount.count DESC LIMIT 1;

/* Mary's first animal */
SELECT visits.date, animals.name, vets."name"
FROM visits
JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id
where vets."name" = 'Maisy Smith'
order by visits."date" asc limit 1;

/* Full details on most recent animal visit */
SELECT visits, animals, vets
FROM visits
JOIN animals ON visits.animal_id = animals.id 
JOIN vets ON visits.vet_id = vets.id
order by visits."date" desc limit 1;

/* Count visits that were treated by non spec */
SELECT count(*) 
FROM vets 
JOIN visits ON vets.id = visits.vet_id
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN animals ON visits.animal_id = animals.id 
WHERE specializations.species_id != animals.species_id;

/* What spec shoud maisy study */
SELECT COUNT(visits.animal_id), species."name"
FROM visits
JOIN animals on visits.animal_id = animals.id 
JOIN species on animals.species_id = species.id
JOIN vets on visits.vet_id = vets.id
WHERE vets."name" = 'Maisy Smith'
GROUP BY  species."name"
ORDER BY COUNT(visits.animal_id ) DESC LIMIT 1;

/* Optimized query 1 */
EXPLAIN ANALYZE SELECT animal_id FROM visits WHERE animal_id = 4;

/* Optimized query 2 */
EXPLAIN ANALYZE SELECT vet_id FROM visits WHERE vet_id = 2;

/* Optimized query 3 */
EXPLAIN ANALYZE SELECT id FROM owners WHERE email = 'owner_18327@gmail.com';

