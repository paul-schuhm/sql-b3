use exercice3;

DROP TABLE IF EXISTS Facture_Ligne;
DROP TABLE IF EXISTS Facture;
DROP TABLE IF EXISTS Adresse_Entete;
DROP TABLE IF EXISTS Adresse_Ligne;
DROP TABLE IF EXISTS Client ;

CREATE TABLE Client (
    -- On increment nous meme ici (comme on insere manuellement les données)
    client_id int NOT NULL,
    client_prenom VARCHAR(32),
    client_nom VARCHAR(32),
    client_raison_sociale VARCHAR(32),
    adresse_id int,
    PRIMARY KEY (client_id)
) ENGINE = InnoDB;


-- Penser à rajouter les données obligatoires avec la contrainte NOT NULL
CREATE TABLE Adresse_Entete (
    adresse_en_tete_code_postal CHAR(8) NOT NULL,
    adresse_en_tete_ville CHAR(32) NOT NULL,
    adresse_en_tete_voie VARCHAR(32) NOT NULL,
    adresse_en_tete_numero_voie_fin TINYINT,
    adresse_en_tete_numero_voie_debut TINYINT,
    -- On modifie le complement en ENUM
    adresse_en_tete_numero_complement ENUM('Ter', 'Bis', 'Quater', 'A', 'B'),
    adresse_en_tete_pays VARCHAR(32),
    client_id int,
    PRIMARY KEY (client_id) -- La clef primaire de la relation sera égale à la clef etangere (client_id)
) ENGINE = InnoDB;


CREATE TABLE Adresse_Ligne (
    -- On se sert du couple addresse_id et adresse_ligne_position comme clef
    -- adresse_ligne_id int AUTO_INCREMENT NOT NULL,
    adresse_ligne_position TINYINT,
    adresse_ligne_ligne VARCHAR(38),
    client_id int NOT NULL,
    PRIMARY KEY (client_id, adresse_ligne_position)
) ENGINE = InnoDB;


CREATE TABLE Facture (
    facture_id INT NOT NULL,
    -- On rajoute l'ENUM avec les tricode ATT, PAY
    facture_statut ENUM ('ATT', 'PAY'),
    facture_date_emission DATE,
    facture_echeance_en_jours TINYINT DEFAULT 60,
    facture_tva_applicable BOOL,
    facture_numero VARCHAR(32) UNIQUE,
    client_id int,
    PRIMARY KEY (facture_id)
) ENGINE = InnoDB;


CREATE TABLE Facture_Ligne (
    ligne_facture_id int AUTO_INCREMENT NOT NULL,
    ligne_facture_designation VARCHAR(32),
    ligne_facture_quantite TINYINT CHECK (ligne_facture_quantite > 0),
    ligne_facture_prix_unitaire_euro DECIMAL CHECK (ligne_facture_prix_unitaire_euro > 0),
    facture_id int NOT NULL,
    PRIMARY KEY (ligne_facture_id)
) ENGINE = InnoDB;



-- Contrainte générée par AnalyseSI, non nécessaire.
-- ALTER TABLE
--     Adresse
-- ADD
--     CONSTRAINT FK_Adresse_adresse_en_tete_adresse_id FOREIGN KEY (adresse_en_tete_adresse_id) REFERENCES Adresse_Entete (adresse_en_tete_adresse_id);

-- ALTER TABLE
--     Adresse
-- ADD
--     CONSTRAINT FK_Adresse_adresse_ligne_id FOREIGN KEY (adresse_ligne_id) REFERENCES Adresse_Ligne (adresse_ligne_id);

ALTER TABLE
    Adresse_Entete
ADD
    CONSTRAINT FK_Adresse_Entete_adresse_id FOREIGN KEY (client_id) REFERENCES Client (client_id);

ALTER TABLE
    Adresse_Ligne
ADD
    CONSTRAINT FK_Adresse_Ligne_adresse_id FOREIGN KEY (client_id) REFERENCES Client (client_id);

-- On ajoute la politique ON DELETE CASCADE pour supprimer les factures avec son client
ALTER TABLE
    Facture
ADD
    CONSTRAINT FK_Facture_client_id FOREIGN KEY (client_id) REFERENCES Client (client_id) ON DELETE CASCADE;

-- On ajoute la politique ON DELETE CASCADE pour supprimer les lignes de facture avec sa facture
ALTER TABLE
    Facture_Ligne
ADD
    CONSTRAINT FK_Facture_Ligne_facture_id FOREIGN KEY (facture_id) REFERENCES Facture (facture_id) ON DELETE CASCADE;