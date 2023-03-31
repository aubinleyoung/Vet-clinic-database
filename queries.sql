/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=TRUE AND escape_attempts <3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5 ; 
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
COMMIT;

ROLLBACK;


BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

BEGIN TRANSACTION;

DELETE FROM animals;

ROLLBACK;


-- start transaction
BEGIN;

-- delete animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- create savepoint
SAVEPOINT my_savepoint;

-- update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- rollback to savepoint
ROLLBACK TO my_savepoint;

-- update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- commit transaction
COMMIT;


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;



SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;


-- animals belong to Melody Pond
SELECT name
FROM animals
JOIN owners ON owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- all animals that are pokemon
SELECT *
FROM animals
JOIN species ON species_id = species.id
WHERE species.name = 'Pokemon';

-- all owners and their animals
SELECT full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

--List animals per species 
SELECT species.name, COUNT(animals.id)
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

--Find the one who owned the most animals
SELECT full_name, COUNT(animals.id)
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY full_name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;


-- Vet clinic database: add "join table" for visits
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT a.id)
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name, s.name AS specialty
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30'

SELECT a.name, COUNT(v.id) AS visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.id
ORDER BY visits DESC
LIMIT 1;
;

SELECT vt.name, MIN(v.visit_date) AS first_visit
FROM vets vt
JOIN visits v ON vt.id = v.vet_id
JOIN animals a ON a.id = v.animal_id
WHERE vt.name = 'Maisy Smith'
GROUP BY vt.id;

SELECT a.name AS animal, vt.name AS vet, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*)
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.id IS NULL;

SELECT s.name AS specialty, COUNT(*) AS visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN specializations sp ON a.species_id = sp.species_id
JOIN vets vt ON vt.id = sp.vet_id
WHERE vt.name = 'Maisy Smith'
GROUP BY sp.species_id
ORDER BY visits DESC
LIMIT 1;


