# Savoir utiliser la documentation officielle

1. Supprimer une colonne
2. Créer plusieurs colonnes en une seule instruction
3. Renommer une table
4. Ajouter en première position une colonne qui portera une contrainte de clef primaire
5. Changer la valeur de départ d'AUTO_INCREMENT
6. Supprimer deux colonnes en une instruction
7. Renommer une colonne et changer son type en une instruction
8. Changer le moteur (engine) de la table

~~~SQL
-- Une table de test
CREATE TABLE Foo (id INTEGER);
-- 2 Créer plusieurs colonnes en une seule instruction
ALTER TABLE Foo ADD COLUMN (col1 INTEGER, col2 CHAR(3), col3 CHAR(4));
--ou ALTER TABLE Foo ADD aaa CHAR(50), ADD  bbb CHAR(50);
-- 1 Supprimer une colonne
ALTER TABLE Foo DROP COLUMN col1;
-- 3 Renommer la table
ALTER TABLE Foo RENAME Bar;
-- 4 Ajouter en première position une colonne qui portera une contrainte de clef primaire
ALTER TABLE Bar ADD COLUMN colPK INT PRIMARY KEY FIRST;
-- 5 Changer la valeur par défaut d'AUTO_INCREMENT
ALTER TABLE Bar AUTO_INCREMENT=12;
-- 6 Supprimer deux colones en une instrcution
ALTER TABLE DROP COLUMN col2, DROP COLUMN col3;
-- 7 Renommer une colonne et changer son type en une instruction
ALTER TABLE Bar CHANGE COLUMN colPK colPKBis VARCHAR(30); 
-- 8 Changer le moteur de la table to MyIASIM
ALTER TABLE Bar ENGINE=InnoDb;
~~~