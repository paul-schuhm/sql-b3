# Module 5 - Exercices : les différentes opérations de l'algèbre relationnelle en pratique: opérateurs, jointures et fonctions de groupes

## Exercice 1: Jointures et opérateurs (`AVG, SUM, ORDER BY, GROUP BY`)

**Reprendre** la base `modelisation` du `Module 4/Exercice 2` (*tables Client/Facture*).

~~~SQL
-- 1. Lister le numero et le nom du client associé des factures impayées depuis plus de 14 jours
SELECT 
num_facture, nom_client FROM Facture 
JOIN Client 
ON Facture.id_client = Client.id_client 
WHERE NOT paye 
AND 
DATEDIFF(CURRENT_DATE(), date_emission) > 14;

-- 2. Lister le nom, prénom des clients qui ont au moins une facture impayée depuis plus de 14 jours
SELECT DISTINCT c.prenom_client, c.nom_client 
FROM Client c 
JOIN Facture f 
ON c.id_client = f.id_client 
WHERE 
NOT f.paye 
AND DATEDIFF(CURRENT_DATE(), f.date_emission) > 14;

-- ou avec GROUP BY (ici on suppose qu'il n'y a pas d'homonymes dans la base, il faudrait faire le group by sur l'id du client et refaire une jointure pour récupérer nom et prénom)
SELECT c.prenom_client, c.nom_client  
FROM Client c  
JOIN Facture f  
ON c.id_client = f.id_client  
WHERE  NOT f.paye  AND DATEDIFF(CURRENT_DATE(), f.date_emission) > 14 
GROUP BY prenom_client, nom_client;

-- 3. Calculer le montant moyen des factures de chaque client
-- une possibilité
SELECT c.id_client,AVG(montant_euro)  
FROM Client c  
JOIN Facture f  
ON c.id_client = f.id_client 
GROUP BY id_client

-- 4. Calculer le nombre de factures de John Doe en 2022
SELECT COUNT(f.num_facture) "Nombre de factures de John en 2022" 
FROM Client c 
JOIN Facture f  
ON c.id_client = f.id_client 
WHERE c.id_client = 1 
AND 
YEAR(f.date_emission)=2022;


-- 5. Afficher le prénom du client ayant la facture avec le montant maximal
SELECT prenom_client 
FROM Client c JOIN Facture f  
ON c.id_client=f.id_client 
GROUP BY prenom_client 
ORDER BY MAX(montant_euro) 
DESC 
LIMIT 1;

-- 6. Calculer et afficher pour chaque client le nombre de factures total (ici on suppose qu'il n'y a pas d'homonymes dans la base, il faudrait faire le group by sur l'id du client)
SELECT 
c.prenom_client,c.nom_client, COUNT(f.num_facture) 
FROM Client c  
JOIN Facture f  
ON c.id_client = f.id_client 
GROUP BY 
prenom_client, nom_client;

-- 7. **Lister** toutes les factures triée du plus récent au plus ancien et par ordre alphabétique sur le nom du client
SELECT CONCAT(prenom_client," ",nom_client), num_facture, date_emission 
FROM Client c 
JOIN Facture f 
ON c.id_client = f.id_client 
ORDER BY 
prenom_client ASC, 
f.date_emission DESC;
~~~

## Exercice 2 :  Fonctions de regroupement (suite)

**Reprendre** la base `parc` et ses données du `Module 3/Exercice 1` (parc informatique)


~~~SQL
--1
SELECT nPoste, COUNT(nLog)
  FROM installer 
  GROUP BY (nPoste);

--2
SELECT nSalle, COUNT(nPoste)
  FROM Poste
  GROUP BY (nSalle)
  ORDER BY 2;

--3
SELECT nLog, COUNT(nPoste)
  FROM Installer 
  GROUP BY (nLog);

--4
SELECT AVG(prix)
  FROM Logiciel
  WHERE typeLog = 'UNIX';

--5
SELECT MAX(dateAch)
  FROM Logiciel;

--6
SELECT nPoste FROM Installer
  GROUP BY nPoste
  HAVING COUNT(nLog)=2;

--7
SELECT COUNT(*) FROM
  (SELECT nPoste FROM Installer GROUP BY nPoste HAVING COUNT(nLog)=2) T;

-- Ou avec une Common Table Expression
WITH postesAvec2logiciels 
AS (SELECT num_poste FROM Installer GROUP BY num_poste HAVING COUNT(num_logiciel)=2) 
SELECT COUNT(*) AS "Nombre de postes avec 2 logiciels installés" FROM postesAvec2logiciels;
~~~

## Exercice 3 : Jointures (`INNER JOIN`)

**Reprendre** la base `parc` et ses données du `Module 3/Exercice 1` (parc informatique)


~~~SQL
-- 1	Adresse IP des postes qui hébergent le logiciel 'log6'
SELECT  CONCAT(ind_ip,'.',ad)
FROM Poste 
NATURAL JOIN Installer
WHERE numero_logiciel='log6';
  
-- 2	Adresse IP des postes qui hébergent le logiciel de nom 'Oracle 8'
SELECT  CONCAT(ind_ip,'.',ad)
FROM  Poste NATURAL JOIN Installer 
NATURAL JOIN Logiciel
WHERE nom_logiciel = 'Oracle 8';

-- 3	Noms des segments possédant exactement trois postes de travail de type 'TX'
SELECT nom_segment as "Segment avec 3 postes TX" 
FROM Segment s 
INNER JOIN Poste p 
ON p.ind_ip=s.ind_ip 
WHERE p.type_poste='TX' 
GROUP BY nom_segment 
HAVING COUNT(*)=3;

--4	Noms des salles ou l'on peut trouver au moins un poste hébergeant 'Oracle 6'
SELECT  nom_salle
FROM  Salle 
NATURAL JOIN  Poste 
NATURAL JOIN  Installer 
NATURAL JOIN  Logiciel 
WHERE nom_logiciel  = 'Oracle 6';
~~~

## Exercice 4 : Manipulation des données temporelles

~~~SQL
-- 0
SELECT CURRENT_DATE(), CURRENT_TIME(), NOW();
-- 1. La date du 20/01/2023 dans 31 jours
SELECT ADDDATE('2023-01-20', 31) "Date dans 31 jours" ;
-- 2. La date du 20/01/2023 (date+temps) à 23 heures - 1 microseconde dans 1 jour et 1 microseconde.
SELECT ADDTIME(CONCAT(CURRENT_DATE(), ' 23:59:59.999999'), '1 0:0:0.000001') AS "exemple ADDTIME";
-- 3. La date dans 4 mois
SELECT DATE_ADD(CURRENT_TIMESTAMP, INTERVAL '4' MONTH) "Rendez-vous dans 4 mois";
-- 4. La date dans 7 jours et 1h30
SELECT DATE_ADD(CURRENT_TIMESTAMP, INTERVAL '7 01:30:00' DAY_SECOND) "RDV 1sem 1h30";
-- 5. La date courante, mais en anglais
SELECT DATE_FORMAT(SYSDATE(), '%W %d %M %Y') "Today in English";
-- 6. Bonus formater la date autrement avec DATE_FORMAT
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s.%f');
~~~

## Exercices supplémentaires (proposés dans le support de cours)

### Regroupements

[Faire ces exercices en ligne](https://colibri.unistra.fr/fr/course/practice/notions-de-base-en-sql/regrouper-avec-group-by/93), proposé par COLIBRI Strasbourg, Université de Strasbourg

~~~SQL
-- Exercice sur les regroupements : Exercice SQL n°1
SELECT COUNT(codecli) AS "Nombre de clients par ville" FROM Clients GROUP BY (villecli);
-- Exercice sur les regroupements : Exercice SQL n°2
SELECT nomfilm, MAX(duree) FROM LOCATIONS l INNER JOIN Films f ON f.codefilm=l.codefilm GROUP BY f.codefilm ORDER BY nomfilm ASC;
-- Exercice sur les regroupements : Exercice SQL n°3
SELECT nomfilm, ROUND(AVG(duree), 1) as "Moyenne" FROM LOCATIONS l INNER JOIN Films f ON f.codefilm=l.codefilm GROUP BY f.codefilm ORDER BY nomfilm ASC;

~~~

### Jointures

[Faire ces exercices en ligne](https://colibri.unistra.fr/fr/course/practice/notions-de-base-en-sql/les-jointures/36), proposé par COLIBRI Strasbourg, Université de Strasbourg

A venir.