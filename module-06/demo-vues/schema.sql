CREATE DATABASE IF NOT EXISTS demo_view;

use demo_view;

-- Reset le schéma
DROP TABLE IF EXISTS Profil;
DROP TABLE IF EXISTS Publication;
DROP TABLE IF EXISTS Utilisateur;

DROP TRIGGER IF EXISTS hash_password_trigger;

DROP TRIGGER IF EXISTS hash_password_trigger_change_password;

CREATE TABLE IF NOT EXISTS Utilisateur(
    id BIGINT AUTO_INCREMENT,
    login VARCHAR(12),
    password CHAR(64),
    CONSTRAINT pk_utilisateur PRIMARY KEY(id),
    UNIQUE INDEX unique_login (login)
);

CREATE TABLE IF NOT EXISTS Profil(
    nom VARCHAR(32),
    prenom VARCHAR(32),
    pseudo CHAR(12) UNIQUE,
    email VARCHAR(32) UNIQUE,
    utilisateur_id BIGINT,
    CONSTRAINT pk_profil PRIMARY KEY (utilisateur_id),
    CONSTRAINT fk_profil_de_utilisateur FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Publication(
    id BIGINT AUTO_INCREMENT,
    titre VARCHAR(32),
    contenu TEXT,
    auteur_id BIGINT,
    date_publication DATE,
    CONSTRAINT pk_publication PRIMARY KEY (id),
    CONSTRAINT fk_publication_postee_par_utilisateur FOREIGN KEY (auteur_id) REFERENCES Utilisateur(id)
);

-- Créer une vue qui affiche les données d'un utilisateur sans son mot de passe


DELIMITER // 

CREATE TRIGGER hash_password_trigger BEFORE
INSERT
    ON Utilisateur FOR EACH ROW BEGIN
SET
    NEW.password = SHA2(NEW.password, 256);

END;
//

CREATE TRIGGER hash_password_trigger_change_password BEFORE
UPDATE
    ON Utilisateur FOR EACH ROW BEGIN
SET
    NEW.password = SHA2(NEW.password, 256);

END;
//

DELIMITER ;