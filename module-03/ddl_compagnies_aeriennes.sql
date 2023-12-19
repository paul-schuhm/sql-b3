-- Création de nos relations(tables)

-- USE est une instruction spéciale, il n'y a pas besoin de la terminer par un delimiteur
USE mod3

-- On supprime les tables si elles existent déjà.
DROP TABLE IF EXISTS Compagnie;
DROP TABLE IF EXISTS Pilote;

CREATE TABLE Compagnie (
    -- définition des colonnes
    id INTEGER,
    nom CHAR(30),
    numero_rue TINYINT,
    nom_rue CHAR(40) NOT NULL,
    -- nom, type, valeur par défaut, commentaire
    ville CHAR(30) DEFAULT 'Paris' COMMENT 'Par défaut: Paris',
    -- contrainte de clef primaire (au sens de Codd)
    CONSTRAINT pk_compagnie PRIMARY KEY(id) 
);

-- Création de la table Pilote
CREATE TABLE Pilote(
    id INTEGER,
    nom CHAR(30),
    nb_heures_vol TINYINT,
    id_compagnie INTEGER,
    -- contrainte de clef primaire (au sens de Codd)
    CONSTRAINT pk_pilote PRIMARY KEY(id),
    -- contrainte de clef étrangère (intégrité référentielle) : 
    -- Une FOREIGN KEY DOIT référencer une colonne indexée (une clé primaire ajoute un index sur la table, PRIMARY KEY = UNIQUE + NOT NULL + INDEX)
    -- pour être performante.
    -- See : https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html#foreign-key-restrictions
    CONSTRAINT fk_pilote_work_for_compagnie FOREIGN KEY (id_compagnie) REFERENCES Compagnie(id) ON DELETE CASCADE
);

-- Inspecter les tables créees

DESCRIBE mod3.Compagnie;
DESCRIBE mod3.Pilote;
