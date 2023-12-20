# Atomicité

Le numéro de sécurité sociale est-il atomique ?

## Exercice

### Modélisation naive

Créer la table suivante

~~~SQL
CREATE TABLE Patient(
    id INT AUTO_INCREMENT,
    prenom VARCHAR(30),
    numero_secu VARCHAR(40),
    CONSTRAINT pk_patient PRIMARY KEY(id)
);
~~~

Insérer le jeu de données test

~~~SQL
INSERT INTO Patient (prenom, numero_secu) VALUES
('Jean Dupont', '1 85 10 73 171 018 44'),
('Marie Martin', '2 89 07 56 342 019 83'),
('Pierre Dubois', '3 77 03 24 189 017 21'),
('Sophie Lefebvre', '2 62 11 68 593 016 76'),
('Luc Moreau', '1 83 04 35 802 017 05'),
('Isabelle Girard', '2 75 05 30 440 014 96'),
('François Thomas', '1 89 09 35 713 018 30'),
('Claire Laurent', '3 88 07 63 272 016 42'),
('Antoine Tremblay', '2 96 06 38 512 016 93'),
('Céline Gagnon', '1 78 09 35 614 017 09'),
('Mathieu Roy', '3 85 10 73 171 018 33'),
('Caroline Leclerc', '2 79 04 50 279 015 64');
~~~

Maintenant, pour une recherche médicale sur le cancer de la prostate, rechercher les patients qui sont nées dans les années 80 en Ille-et-vilaine

~~~SQL
SELECT * FROM Patient WHERE numero_secu LIKE '1%'
AND SUBSTRING(numero_secu, 3, 2) BETWEEN '80' AND '89' AND SUBSTRING(numero_secu, 9, 2) = '35';
~~~

> `BETWEEN` : vrai si min=<x=<max (bornes incluses)
> Si on souhaite travailler sur des numéros de sécu sans espace, avec [REGEXP_REPLACE](https://dev.mysql.com/doc/refman/8.0/en/regexp.html#function_regexp-replace) : `SELECT REGEXP_REPLACE(numero_secu, ' ', '') FROM Patient;`


Est-ce que le numéro de sécurité sociale est atomique ? Non, car en le divisant je trouve de nouvelles informations qui ont du sens (sexe, année de naissance, département de naissance, etc.)

Pourquoi cette modélisation est mauvaise ? Car on doit découper avec `SUBSTRING` : **coûteux**. **On ne peut pas utiliser d'index** sur le numéro de sécu avec l'usage de `SUBSTRING`. L'index indexe toute la chaîne, or ici on crée des nouvelles chaines. Donc `SUBSTRING` ne pourra pas utiliser d'index, accès séquentiel oblige. Si millions d'enregistrements, requête très peu performante...

### Modélisation atomisée

~~~SQL
CREATE TABLE PatientAtomise(
    id INT AUTO_INCREMENT,
    prenom VARCHAR(30),
    numero_secu_sexe CHAR(1),
    numero_secu_anmois CHAR(4),
    numero_secu_code_insee_commune CHAR(2),
    CONSTRAINT pk_patient_atomise PRIMARY KEY(id)
);
~~~

~~~SQL
INSERT INTO PatientAtomise (prenom, numero_secu_sexe, numero_secu_anmois,numero_secu_code_insee_commune  ) VALUES
('Luc Moreau', '1', '8304', '35'),
('François Thomas', '1', '8909', '35'),
('Jean Lesombre', '1', '2109', '34'),
('Sophie Lefebvre', '2', '6211', '35'),
('Céline Gagnon', '2', '8705', '44');
~~~

Et la requête devient :

~~~SQL
SELECT * FROM PatientAtomise WHERE numero_secu_sexe = '1'
AND numero_secu_anmois BETWEEN '8001' AND '8912' 
AND numero_secu_code_insee_commune = '35';
~~~

**Gains** : requête plus simple et plus lisible, on peut indexer les bonnes colonnes (on verra plus tard), requete quasi instantanée peu importe le volume de données. On peut interroger plus facilement notre base, grosses perfs en lecture. Le numéro de sécu est atomisé

## Conclusion

L'atomicité d'une donnée est intrinsèque à la donnée. De choisir d'aller dans *le sens de la donnée*, de la diviser en parties ou non dans notre schéma de base de données, dépend du métier. Si on doit travailler sur le numéro de sécu alors il faut regarder en face le fait que cette donnée ne soit pas atomique et prendre les mesures nécessaires pour son schéma.

Une donnée bien atomisée, bien modélisée, apporte de meilleurs performances pour le système notamment via l'usage d'index. Cela apporte aussi de la lisibilité sur les requêtes à écrire (et donc rend l'utilisation plus aisée aussi pour l'utilisateur de la base qu'il soit humain ou que ce soit un programme).

## Références

- [Numéro de sécurité sociale Wiki](https://fr.wikipedia.org/wiki/Num%C3%A9ro_de_s%C3%A9curit%C3%A9_sociale_en_France)
- [Modélisation des bases de données: UML et les modèles entité-association, 4e édition ou 5e édition](https://www.eyrolles.com/Informatique/Livre/modelisation-des-bases-de-donnees-9782416007507/), de Christian Soutou et Frédéric Brouard, 2022 (pour la 5e). Chapitre 'Avant d'aborder la théorie', p25,26
- [MySQL SUBSTRING](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_substring)