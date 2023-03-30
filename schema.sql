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

ALTER TABLE owners
ADD COLUMN species_id INTEGER REFERENCES species(id);

ALTER TABLE species
ADD COLUMN owner_id INTEGER REFERENCES owners(id);