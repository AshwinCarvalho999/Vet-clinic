/* Populate database with sample data. */

-- DAY ONE
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('1', 'Agumon', '2018-02-03', '10.23', 'true', '0');
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('2', 'Gabumon', '2018-11-15', '8', 'true', '2');
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('3', 'Pikachu', '2021-01-07', '15', 'false', '1');
INSERT INTO animals (id, name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('4', 'Devimon', '2017-05-12', '11', 'true', '5');

-- DAY TWO
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Charmander', '2020-02-08', '-11', 'false', '0');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Plantmon', '2021-11-15', '-5.7', 'true', '2');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Squirtle', '1993-04-02', '-12.13', 'false', '3');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Angemon', '2005-06-12', '-45', 'true', '1');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Boarmon', '2005-06-07', '20.4', 'true', '7');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Blossom', '1998-10-13', '17', 'true', '3');
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES('Ditto', '2022-05-14', '22', 'true', '4');

-- DAY THREE
INSERT INTO owners(full_name, age) 
VALUES
    ('Sam Smith', '34'),
    ('Jennifer Orwell', '19'),
    ('Bob', '45'),
    ('Melody Pond', '77'),
    ('Dean Winchester', '14'),
    ('Jodie Whittaker', '38');

INSERT INTO species(name)
VALUES
    ('Pokemon'),
    ('Digimon');


INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES
    ('Agumon', '2018-02-03', '10.23', 'true', '0'),
    ('Gabumon', '2018-11-15', '8', 'true', '2'),
    ('Pikachu', '2021-01-07', '15', 'false', '1'),
    ('Devimon', '2017-05-12', '11', 'true', '5'),
    ('Charmander', '2020-02-08', '-11', 'false', '0'),
    ('Plantmon', '2021-11-15', '-5.7', 'true', '2'),
    ('Squirtle', '1993-04-02', '-12.13', 'false', '3'),
    ('Angemon', '2005-06-12', '-45', 'true', '1'),
    ('Boarmon', '2005-06-07', '20.4', 'true', '7'),
    ('Blossom', '1998-10-13', '17', 'true', '3'),
    ('Ditto', '2022-05-14', '22', 'true', '4');

UPDATE animals
SET species_id = '2'
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = '1'
WHERE name NOT LIKE '%mon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Sam Smith') 
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell') 
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Bob') 
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond') 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester') 
WHERE name IN ('Angemon', 'Boarmon');

-- DAY FOUR
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('Vet William Tatcher', '45', '2020-04-23'),
    ('Vet Maisy Smith', '26', '2019-01-17'),
    ('Vet Stephanie Mendez', '64', '1981-05-04'),
    ('Vet Jack Harkness', '38', '2008-06-08');

INSERT INTO specialization (vets_id, species_id)
VALUES
    ('1', '1'),
    ('3', '2'),
    ('3', '1'),
    ('4', '2');

INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES
    ('1', '1', '2020-05-24'),
    ('1', '3', '2020-07-22'),
    ('2', '4',  '2021-02-02'),
    ('3', '2',  '2020-01-05'),
    ('3', '2',  '2020-03-08'),
    ('3', '2',  '2020-05-14'),
    ('4', '3',  '2021-05-04'),
    ('5', '4',  '2021-02-24'),
    ('6', '2',  '2019-12-21'),
    ('6', '1',  '2020-08-10'),
    ('6', '2',  '2021-04-07'),
    ('7', '3',  '2019-09-29'),
    ('8', '4',  '2020-10-03'),
    ('8', '4',  '2020-11-04'),
    ('9', '2',  '2019-01-24'),
    ('9', '2',  '2019-05-15'),
    ('9', '2',  '2020-02-27'),
    ('9', '2',  '2020-08-03'),
    ('10', '3',  '2020-05-24'),
    ('10', '1',  '2021-01-11');


SELECT vets.name, animals.name, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Vet William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(DISTINCT (animals.name)), vets.name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name LIKE 'Vet Stephanie Mendez'
GROUP BY vets.name;

SELECT vets.name, species.name FROM vets
LEFT JOIN species ON vets.id = species.id;

SELECT animals.name, vets.name, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Vet Stephanie Mendez' AND date_of_visit BETWEEN DATE '2020-04-01' AND '2020-08-30';


SELECT COUNT(animals.name), animals.name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
GROUP BY animals.name
ORDER BY count DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
ORDER BY visits.date_of_visit LIMIT 1;

SELECT animals.*, vets.*, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY date_of_visit DESC LIMIT 1;

SELECT vets.name, COUNT(vets.name) FROM vets
LEFT JOIN specialization ON specialization.vets_id = vets.id
LEFT JOIN visits ON vets.id = visits.vets_id
LEFT JOIN species ON species.id = specialization.species_id
GROUP BY vets.name;

SELECT COUNT(*) FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id 
LEFT JOIN specialization ON specialization.vets_id = vets.id 
WHERE specialization.species_id != animals.species_id OR specialization.species_id is NULL;

SELECT species.name, count(*) FROM visits 
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets_id=2
GROUP BY species.name LIMIT 1;

-- week2  day1
-- The following queries to add an extra column to the owners table:

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit)
SELECT * FROM (SELECT id FROM animals) animals_ids,
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';




