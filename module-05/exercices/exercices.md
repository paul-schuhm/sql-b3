# Module 5 - Exercices : jointures, opérateurs et fonctions de regroupement

Version : 2

Ces exercices sont là pour pratiquer la *DQL* (Data Query Language) et les opérations de jointure, le *coeur* du modèle relationnel.

- [Module 5 - Exercices : jointures, opérateurs et fonctions de regroupement](#module-5---exercices--jointures-opérateurs-et-fonctions-de-regroupement)
  - [Exercice 1 : Fonctions de regroupement](#exercice-1--fonctions-de-regroupement)
  - [Exercice 2 :  Fonctions de regroupement (suite)](#exercice-2---fonctions-de-regroupement-suite)
  - [Exercice 3 : Jointures (`INNER JOIN`)](#exercice-3--jointures-inner-join)
  - [Exercice 5 : Manipulation des données temporelles](#exercice-5--manipulation-des-données-temporelles)
  - [Exercices et ressources supplémentaires](#exercices-et-ressources-supplémentaires)


<hr>

## Exercice 1 : Fonctions de regroupement

> Pratiquer `AVG, SUM, ORDER BY, GROUP BY`

**Reprendre** la base `modelisation` du `Module 4/Exercice 2` (*relations Client/Facture*). **Ajouter** au script `dml_modelisation.sql` les requêtes permettant d'obtenir les relations suivantes :

1. **Lister** les numéros de chaque facture impayée depuis plus de 14 jours et le nom de son destinataire;
2. **Lister** le nom des clients qui ont *au moins* une facture impayée depuis plus de 14 jours
3. **Calculer** le montant moyen des factures de John et de Jane
4. **Calculer** le nombre de factures de Jane en 2022
5. **Afficher** le prénom du client ayant la facture avec le montant maximal
6. **Calculer** et afficher pour chaque client le nombre total de factures
7. **Lister** toutes les factures triées du plus récent au plus ancien et par ordre alphabétique sur le nom du client (toutes les factures de Jane de la plus récente à la plus ancienne, puis toutes les factures de John de la plus récente à la plus ancienne, etc.)

## Exercice 2 :  Fonctions de regroupement (suite)

> Comprendre et savoir utiliser les fonctions SUM, AVERAGE, COUNT, HAVING, GROUP BY, ORDER BY, GROUP_CONCAT.

**Reprendre** la base de données `parc`. **Écrire** les requêtes pour récupérer les données suivantes :

1. Pour chaque poste, le nombre de logiciels installés (en utilisant la table `Installer`).
2. Pour chaque salle, le nombre de postes (à partir de la table `Poste`).
3. Pour chaque logiciel, le nombre d’installations sur des postes différents.
4. Moyenne des prix des logiciels 'UNIX'.
5. Plus récente date d’achat d’un logiciel.
6. Numéros des postes hébergeant 2 logiciels.
7. Nombre de postes hébergeant 2 logiciels. Pour cela, utiliser une sous-requête : utiliser la requête précédente en faisant un `SELECT` dans la clause `FROM` (un `SELECT` retourne une table que l'on peut requêter comme n'importe quelle table). Réécrire la requête obtenu cette fois-ci avec une [*Common Table Expression*](https://dev.mysql.com/doc/refman/8.0/en/with.html) (à préférer aux sous-requêtes)


## Exercice 3 : Jointures (`INNER JOIN`)

**Reprendre** la base `parc` et ses données du `Module 3/Exercice 1` (parc informatique)

> Remarque MySQL : Au lieu d'écrire manuellement le prédicat pour chaque jointure, vous pouvez utiliser le `NATURAL JOIN`: c'est un `INNER JOIN` qui joint automatiquement sur deux colonnes communes (nom et type) à deux tables. Par exemple, `SELECT * FROM A NATURAL JOIN B;`
> Lors d'une jointure, il est également possible de préciser la colonne sur laquelle faire la jointure avec `USING(col)`. Par exemple, `SELECT * FROM A JOIN B USING (colonneSurLaquelJoindre);` En pratique cependant, on préférera éviter ces syntaxes propres à MySQL qui rendent les requêtes plus lisibles (moins verbeuses) mais qui rendent les structures de tables implicites (connues).

**Écrire** les requêtes SQL permettant de récupérer les données suivantes : 

1. Adresses IP complètes des postes qui hébergent le logiciel 'log6'.
2. Adresses IP complètes des postes qui hébergent le logiciel de nom 'Oracle 8'.
3. Noms des segments possédant exactement trois postes de travail de type 'TX'.
4. Noms des salles ou l’on peut trouver au moins un poste hébergeant le logiciel 'Oracle 6'.



## Exercice 5 : Manipulation des données temporelles

Écrire des requêtes, à l’aide des fonctions temporelles de MySQL, donnant les informations
suivantes :

0. La date du jour, puis l'heure du jour, puis la date et l'heure du jour en une requête (sur 3 colonnes distinctes)
1. La date dans 31 jours
2. La date du jour à 0h00 - 1 microseconde à laquelle on ajoute 1 jour et 1 microseconde.
3. La date dans 4 mois
4. La date dans 7 jours et 1h30
5. Aujourd’hui, mais en anglais

## Exercices et ressources supplémentaires

- Répondre aux questions supplémentaires de l'exercice 3 du module 4 (sur la base conçue avec [AnalyseSI](https://launchpad.net/~analysesi))
- [Exercices en ligne (sections 2, 3, 5 et 6)](https://fxjollois.github.io/cours-sql/), section 2-Calculs et fonctions, 3-Agrégats, 5 sous requêtes, 6 opérations ensemblistes