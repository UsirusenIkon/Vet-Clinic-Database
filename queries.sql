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
UPDATE animal SET species = 'unspecified';
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
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/*Querying multiple tables*/
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT animals.name, owners.full_name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;
SELECT animals.name from animals JOIN owners ON owners.id = animals.owner_id JOIN species on species.id = animals.species_id WHERE animals.species_id = '2' AND animals.owner_id = '2';
SELECT animals.name from animals JOIN owners ON owners.id = animals.owner_id WHERE animals.escape_attempts = '0' AND animals.owner_id = '5';
SELECT full_name, COUNT(owner_id) FROM owners JOIN animals on owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT (owner_id) desc limit 1;

/*Join table with multiple visits*/
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = '1' ORDER BY visits.date_of_visit desc limit 1;
SELECT COUNT(DISTINCT animal_id) FROM visits WHERE vet_id = '2';
SELECT vets.name, specializations.vet_id, specializations.species_id FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id;
SELECT animals.name , visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' AND vet_id = '3';
SELECT animals.name, COUNT(animal_id) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(animal_id) desc limit 1;
SELECT animals.name, date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = '2'ORDER BY visits.date_of_visit ASC LIMIT '1';
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);
SELECT *, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE visits.date_of_visit = (SELECT MIN(date_of_visit) FROM visits);
SELECT COUNT(visits.animal_id) FROM visits JOIN vets ON vets.id = visits.vet_id WHERE vet_id = '2';
SELECT species.name, COUNT(animals.species_id) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Vet Maisy Smith' GROUP BY species.name ORDER BY COUNT(animals.species_id) desc limit 1;
SELECT full_name, COUNT(owner_id) FROM owners JOIN animals on owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT (owner_id) desc limit 1;

/*Queries that provide answers to the questions from all projects.*/

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
