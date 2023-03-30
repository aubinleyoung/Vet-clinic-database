/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, TRUE, 8),
  (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04),
  (4, 'Devimon', '2017-05-12', 5, TRUE, 11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species) 
VALUES 
(5,'Charmander', '2020-02-08', 0, false, -11),
(6,'Plantmon', '2021-11-15', 2, true, -5.7),
(7,'Squirtle', '1993-04-02', 3, false, -12.13),
(8,'Angemon', '2005-06-12', 1, true, -45),
(9,'Boarmon', '2005-06-07', 7, true, 20.4),
(10,'Blossom', '1998-10-13', 3, true, 17),
(11,'Ditto', '2022-05-14', 4, true, 22);

--multi tables
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon'),
('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' or name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon ' OR name = 'Boarmon';

-- Vet clinic database: add "join table" for visits

INSERT INTO vets (name, age, date_of_graduation) VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

    -- Insert the data into the specializations table
INSERT INTO specializations (vet_id, species_id) VALUES
    (1, 1), -- William Tatcher specialized in Pokemon
    (3, 1), (3, 2), -- Stephanie Mendez specialized in Digimon and Pokemon
    (4, 2); -- Jack Harkness specialized in Digimon

    
-- Insert the data into the visits table
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
    (1, 1, '2020-05-24'), -- Agumon visited William Tatcher on May 24th, 2020.
    (1, 3, '2020-07-22'), -- Agumon visited Stephanie Mendez on Jul 22th, 2020.
    (2, 4, '2021-02-02'), -- Gabumon visited Jack Harkness on Feb 2nd, 2021.
    (3, 2, '2020-01-05'), (3, 2, '2020-03-08'), (3, 2, '2020-05-14'), -- Pikachu visited Maisy Smith on Jan 5th, Mar 8th, and May 14th, 2020.
    (4, 3, '2021-05-04'), -- Devimon visited Stephanie Mendez on May 4th, 2021.
    (5, 4, '2021-02-24'), -- Charmander visited Jack Harkness on Feb 24th, 2021.
    (6, 2, '2019-12-21'), (6, 1, '2020-08-10'), (6, 2, '2021-04-07'), -- Plantmon visited Maisy Smith on Dec 21st, 2019, William Tatcher on Aug 10th, 2020, and Maisy Smith again on Apr 7th, 2021.
    (7, 3, '2019-09-29'), -- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
    (8, 4, '2020-10-03'), (8, 4, '2020-11-04'), -- Angemon visited Jack Harkness on Oct 3rd and Nov 4th, 2020