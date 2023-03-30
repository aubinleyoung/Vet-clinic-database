/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(5,2)

);
ALTER TABLE animals ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
	id INTEGER PRIMARY KEY,
	full_name VARCHAR(50),
	age INTEGER
);
CREATE TABLE species (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id); 
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owner(id);

-- Vet clinic database: add "join table" for visits

CREATE TABLE vets (
    id SERIAL PRIMARY KEY ,
    name TEXT,
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    id SERIAL PRIMARY KEY ,
    vet_id INTEGER,
    species_id INTEGER,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    vet_id INTEGER,
    animal_id INTEGER,
    visit_date DATE,
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);
