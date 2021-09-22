INSERT INTO animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Agumon' , 'feb/3/20' , 0 , TRUE , 10.23);

INSERT INTO animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Gabumon' , 'nov/15/18' , 2 , TRUE , 8);

INSERT INTO animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Pikachu' , 'jan/7/21' , 1 , FALSE , 15.04);

INSERT INTO animals (name , date_of_birth , escape_attempts , neutered , weight_kg)
VALUES ('Devimon' , 'may/12/17' , 5 , TRUE , 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', 'feb/8/20', 0, FALSE, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', 'nov/15/22', 2, TRUE, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', 'apr/2/93', 3, FALSE, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', 'jun/12/2005', 1, TRUE, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', 'jun/07/2005', 7, TRUE, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', 'oct/13/1998', 3, TRUE, 17);

INSERT INTO owners (full_name,age)
	VALUES ('Sam Smith',34);
  
INSERT INTO owners (full_name,age)
	VALUES ('Jennifer Orwell',19);
  
INSERT INTO owners (full_name,age)
	VALUES ('Bob',45);
  
INSERT INTO owners (full_name,age)
	VALUES ('Melody Pond',77);
  
INSERT INTO owners (full_name,age)
	VALUES ('Dean Winchester',14);
  
INSERT INTO owners (full_name,age)
	VALUES ('Jodie Whittaker',38);

INSERT INTO species ("name")
	VALUES ('Pokemon');
	
INSERT INTO species ("name")
	VALUES ('Digimon');

UPDATE animals
	SET species_id=1
	WHERE id=22;
UPDATE animals
	SET species_id=1
	WHERE id=17;
UPDATE animals
	SET species_id=2
	WHERE id=20;
UPDATE animals
	SET species_id=2
	WHERE id=23;
UPDATE animals
	SET species_id=1
	WHERE id=15;
UPDATE animals
	SET species_id=2
	WHERE id=16;
UPDATE animals
	SET species_id=1
	WHERE id=21;
UPDATE animals
	SET species_id=2
	WHERE id=18;
UPDATE animals
	SET species_id=1
	WHERE id=14;
