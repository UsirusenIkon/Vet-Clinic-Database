/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';
SELECT date_of_birth FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animal SET specie = 'unspecified';
ROLLBACK;

BEGIN
UPDATE animals SET species = 'Digmon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals;

/*What is the minimum and maximum weight of each type of animal?*/
  SELECT MIN(weight_kg) FROM animals WHERE species = 'Digmon';
  SELECT MAX(weight_kg) FROM animals WHERE species = 'Digmon';
  SELECT MAX(weight_kg) FROM animals WHERE species = 'Pokemon';
  SELECT MIN(weight_kg) FROM animals WHERE species = 'Pokemon';

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
  SELECT AVG(escape_attempts) FROM animals WHERE species = 'Digmon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
  SELECT AVG(escape_attempts) FROM animals WHERE species = 'Pokemon' AND date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';