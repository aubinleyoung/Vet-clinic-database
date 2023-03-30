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




