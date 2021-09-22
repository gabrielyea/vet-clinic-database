CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
    ADD COLUMN species VARCHAR(100);

CREATE TABLE public.owners (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100);
    age int;
	CONSTRAINT owners_pk PRIMARY KEY (id)
);
