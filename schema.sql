/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species varchar(100),
    PRIMARY KEY(id)
);

CREATE TABLE owners (
    id INT AUTO_INCREMENT,
    full_name varchar(100),
    age integer,
    PRIMARY KEY(id),
);

CREATE TABLE species (
    id INT AUTO_INCREMENT,
    name varchar(100),
    PRIMARY KEY(id),
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id BIGINT REFERENCES species(id);
ALTER TABLE animals ADD owner_id BIGINT REFERENCES owners(id);

CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name varchar(100),
    age integer,
    date_of_graduation date
);

CREATE TABLE specializations (
    species_id integer,
    vet_id integer
);

CREATE TABLE visits (
    animal_id int,
    vet_id int,
    date_of_visit date
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
ALTER TABLE visits ADD COLUMN ID BIGSERIAL PRIMARY KEY;

CREATE INDEX ON visits(animal_id);
CREATE INDEX ON visits(vet_id);
CREATE INDEX ON owners(email);