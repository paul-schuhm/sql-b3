DROP DATABASE IF EXISTS operations;

CREATE DATABASE operations;

USE operations:

 CREATE TABLE Psql(
    id INTEGER,
    nom CHAR(10),
    CONSTRAINT pk_psql PRIMARY KEY(id)
);

CREATE TABLE Pjava(
    id INTEGER,
    nom CHAR(10),
    CONSTRAINT pk_pjava PRIMARY KEY(id)
);

CREATE TABLE Couleur(
    id INTEGER AUTO_INCREMENT,
    nom CHAR(7),
    CONSTRAINT pk_couleur PRIMARY KEy(id)
);

CREATE TABLE Carte(
    id INTEGER AUTO_INCREMENT,
    valeur CHAR(7),
    CONSTRAINT pk_carte PRIMARY KEY(id)
);
