# Module 4 - Exercices : Conception de base de données et associations

Version : 2

Exercices sur la conception de bases de données et le [passage du modèle conceptuel au modèle relationnel](http://cours.thirion.free.fr/Cours/Merise/MCD_To_MR.php).

- [Module 4 - Exercices : Conception de base de données et associations](#module-4---exercices--conception-de-base-de-données-et-associations)
  - [Exercice 1 : Le SI du mondial de football](#exercice-1--le-si-du-mondial-de-football)
  - [Exercice 2 : Du modèle conceptuel au modèle relationnel (au modèle physique)](#exercice-2--du-modèle-conceptuel-au-modèle-relationnel-au-modèle-physique)
  - [Exercice 3 : Utiliser un outil de conception de base de données](#exercice-3--utiliser-un-outil-de-conception-de-base-de-données)
    - [Questions supplémentaires (avec jointures, triggers)](#questions-supplémentaires-avec-jointures-triggers)
    - [Bonus](#bonus)
    - [Données du problème](#données-du-problème)
      - [Client 1](#client-1)
      - [Client 2](#client-2)
  - [Exercice 4 : Conception d'une base de données d'un cinéma](#exercice-4--conception-dune-base-de-données-dun-cinéma)
  - [Exercice 5 : Explorer et analyser une base existante](#exercice-5--explorer-et-analyser-une-base-existante)
  - [Exercice 6 : Parc immobilier](#exercice-6--parc-immobilier)
  - [Exercices et ressources supplémentaires](#exercices-et-ressources-supplémentaires)
  - [Annexe A : Bien débuter un travail de conception](#annexe-a--bien-débuter-un-travail-de-conception)
  - [Annexe B : Références utiles](#annexe-b--références-utiles)


<hr>

## Exercice 1 : Le SI du mondial de football

L'objectif de cet exercice est de produire un modèle conceptuel de l'organisation du 1er tour de la coupe du monde de football.

Au premier tour, les équipes sont réparties en 6 groupes de 4 (soit 24 équipes au total à chaque édition). Dans chaque groupe, chaque équipe joue contre les autres, ce qui fait 6 matchs à organiser par groupe. À la fin du 1er tour, seules les deux premières équipes passent au second tour pour continuer la compétition, les autres sont éliminées.

|  Attribut 	| Désignation   	| Type   	|
|---	|---	|---	|
|  lib_equipe 	|   Libellé de l'équipe participante (pays)	|  Chaîne de caractères  	|
|  lib_groupe 	|   Libellé du groupe (par exemple, "Groupe A")	|   Chaîne de caractères 	|
|  nom_ville 	|   Nom de la ville où se déroule le match (par exemple, "Johannesburg")	|    Chaîne de caractères 	|
|  nom_stade 	|   Nom du stade où se déroule le match (par exemple, "Roazhon Park")	|   Chaîne de caractères	|
|  jour_match 	|   Jour d'un match (par exemple, "11/06/2020")	| Date  	|
|  heure_match 	|   Heure d'un match (par exemple, "13h30")	| Décimal  	|
|  score_match 	|   Score d'un match (par exemple "1-2")	| Chaîne de caractères  	|
|  nom_chaine_tv 	|   Nom de la chaîne TV qui diffuse le match (par exemple, "France 2")	| Chaîne de caractères  	|
|  classement 	|   Classement de l'équipe au sein du groupe	| Entier court  	|


1. **Compléter** le diagramme de classes UML suivant (ajouter les **attributs** manquants et la ou les **classes** manquantes) en vous servant du *dictionnaire des données* qui vous est fourni pour vous aider à démarrer votre conception.

![](./diagramme_ex_1_1coupe_du_monde.svg)

2. Une fois votre diagramme de classes complété, **relier** les classes par des **associations** *judicieusement choisies*. Faites figurer sur chaque association un **nom** et la **cardinalité** à chaque extrémité de l'association.

>Source : cet exercice est adapté de l'exercice *La déroute des bleus* (Modélisation des bases de données: UML et les modèles entité-association, 4e édition, Christian Soutou, 2017, Eyrolles, Exercice 1.1 p 124)

## Exercice 2 : Du modèle conceptuel au modèle relationnel (au modèle physique)

Afin de développer un SI informatisé pour une entreprise de services, nous avons identifié les relations suivantes :

- **Client** : Nom, Prénom
- **Facture** : Numéro de facture, Date d'émission de la facture, Montant de la facture en euro, Facture payée ou non

1. À partir de ces informations, **établir** le dictionnaire des données et **développer** le modèle conceptuel ou MCD (Diagramme de classes UML). **Ajouter** les associations entre classes. Penser à nommer les associations et à y faire figurer les cardinalités.
2. **Passer** du modèle conceptuel au modèle relationnel (des classes aux relations/tables). *Penser à ajouter les attributs manquants propres au modèle relationnel*.
3. **Écrire** les requêtes SQL dans un script `ddl_modelisation.sql` et exécutez les via le programme client `mysql` en *batch mode*. Pour cela, créer la base de données `exercice2`.
4. **Insérer** les données suivantes :

- John Doe a deux factures :
  - F-900-08, 12/12/2022, 120.5 EUROS, non payé
  - F-500-02, 13/01/2023, 90 EUROS, payé
- Jane Doe a 4 factures :
  - Z-500-03, 01/01/23, 1000 EUROS, non payé
  - J-400-02, 11/09/23, 800 EUROS, payé
  - F-434-04, 23/12/22, 400 EUROS, non payé
  - J-333-05, 27/01/23, 1250 EUROS, non payé  

5. En utilisant les instructions SQL de la DML (*Data Manipulation Language* : `SELECT`, `WHERE` et autres opérateurs logiques) écrivez un script `dml_modelisation.sql` afin de récupérer les informations suivantes :
   1. **Lister** toutes les factures impayées
   2. **Lister** toutes les factures impayées dont le montant est supérieur à 500 EUROS
   3. **Lister** toutes les factures de 2022
   4. **Lister** toutes les factures impayées de 2023 
   
> Vérifier la cohérence de la base de données (facture bien associée au client correspondant)

## Exercice 3 : Utiliser un outil de conception de base de données

Il existe de nombreux outils de conception de base de données, plus ou moins complexes, payants ou gratuits. Dans cet exercice, nous allons utiliser le logiciel libre [Analyse SI](https://launchpad.net/analysesi) qui n'est pas parfait mais a le mérite d'être simple, sans distractions, cross-platform (Java) et utile. Il utilise la syntaxe Merise 1. Ce logiciel se focalise sur la phase de conception et pour produire le MCD, moins pour générer le SQL et interagir avec une base de données.

Nous devons produire un SI normalisé d'un système de comptabilité.

1. Télécharger [AnalyseSI](https://launchpad.net/analysesi) et executer le : `java -jar analyseSI-version.jar`

2. A l'aide d'AnalyseSI, créer les *entités* suivantes :
   1. `Client : **id_client**, prenom, nom, raison_sociale`
   3. `Adresse_entete : **client_id**, code_postal, ville, voie, numero_voie_debut, numero_voie_fin, complement_de_voie, pays`
   4. `Adresse_ligne : **client_id**, **position**, ligne`
   5. `Facture : **id_facture**, status, date_emission, echeance_en_jours, tva_applicable, numero`
   6. `LigneFacture : **id_ligne_facture**, designation, quantite, prix_unitaire_euro`

> Nous utilisons ici une modélisation normalisée des adresses telle qu'elle est définie en Europe.

Voici les contraintes supplémentaires sur les attributs :

1. `complement_de_voie` : ensemble prédéfini. Valeurs possibles : Bis, Ter, Quater, A, B
2. `statut` : ensemble prédéfini. en attente de paiement (`ATT`), payée (`PAY`)
3. `echeance_en_jours` : période comptée à partir de la date d'émission. Si la facture n'est pas payée dans ce délai, des pénalités s'appliquent. Valeur par défaut : `60`
4. `tva_applicable` : oui ou non
5. `numero` : unique
6. `quantite` : > 1
7. `prix_unitaire_euro` : > 0
8. `ligne` : <= 38 caractères
9. `code_postal + ville` : <= 38 caractères
10. `numero_voie_debut + numero_voie_fin + numero_complement + voie` : <= 38 caractères

Avant de créer les relations, créer *le dictionnaire de données*.

1. A l'aide d'Analyse SI, créer les *associations* entre relations avec les bonnes *cardinalités*
2. A l'aide d'Analyse SI, valider votre *MCD*.
3. Générer le *Modèle Relationnel* (ici appelé *Modèle Physique*) et le *Modèle Physique* (code SQL). Enregistrer une image de votre MCD et le code sql dans un fichier `schema.sql` pour documenter votre projet.
4. Modifier le script `schema.sql` pour créer les tables de la base `exercice3`  et ajouter les contraintes manquantes. Exécuter le script avec le client `mysql` *en batch mode*. **Le script doit permettre de régénérer la base lors de son exécution, peu importe l'état courant de la base.** Corriger le script généré si nécessaire. Le script de création des tables doit pouvoir être exécuté deux fois d'affilée sans erreur.
5. Créer un script `data.sql` pour insérer des données dans la base ([voir section Données du problème](#données-du-problème)).
6. Le script `data.sql` doit permettre de régénérer le jeu de données lors de son execution, **peu importe l'état de la base**. Pour cela, vider les tables en début de script avec `TRUNCATE`:
~~~sql
TRUNCATE Ligne_facture;
TRUNCATE Facture;
TRUNCATE Client;
~~~
Quelle erreur obtenez-vous ? Pourquoi ? [Inspecter la documentation de TRUNCATE](https://dev.mysql.com/doc/refman/8.0/en/truncate-table.html). Trouver une autre solution pour vider la table.

7. Une fois toutes les données insérées (clients, adresses et factures), essayer de supprimer un client. Que se passe-t-il ? Corriger le problème en définissant une politique de gestion des contraintes avec `ON DELETE`. Lorsqu'un client est supprimé, supprimer automatiquement ses factures. Tester en supprimant le client `'Parisian Tech Solutions S.A.'`.
8. Est-il possible d'implémenter les contraintes 9 et 10 avec une contrainte `CHECK` ? Si oui, le faire.

<!-- 
8. Oui, c'est possible ! On peut définir une contrainte CHECK sur une table qui référence plusieurs colonnes
 -->

### Questions supplémentaires (avec jointures, triggers)

1. Récupérer la facture complète (toutes les lignes de facture) du client `'Parisian Tech Solutions S.A.'`. Calculer le montant total Hors-Taxe et TTC de la facture de chaque client en écrivant une requête pour chaque client·e. *Conseil : Décomposer la requête en sous-requête, construisez la requête de manière itérative*.
2. Afficher l'adresse complète de chaque client sur une ligne (en concaténant les chaines de caractères). Le résultat doit être retourné dans une relation `Destinataire (nom + prénom + raison sociale) | Adresse`.
3. A l'aide de [déclencheurs](https://dev.mysql.com/doc/refman/8.0/en/trigger-syntax.html) (*triggers*), implémenter les contraintes 9 et 10.
4. Écrire une procédure `address_format(client_id, country_code="fr")` qui permet de fabriquer l'adresse complète formatée selon chaque format européen. On le fera pour le [format français](https://fr.wikipedia.org/wiki/Adresse_postale), allemand et anglais ([consulter cette page wikipédia](https://fr.wikipedia.org/wiki/Adresse_postale)).

### Bonus

Faire le même exercice de conception de la base avec l'outil de conception [Oracle Data Modeler](https://www.oracle.com/fr/database/sqldeveloper/technologies/sql-data-modeler/). Ouvrir l'aide et faire le tutoriel *Data Modeler Tutorial: Modeling for a Small Database*

### Données du problème

#### Client 1

- **Raison Sociale** : Parisian Tech Solutions S.A.
- **Service** : Comptabilité
- **Adresse**:
  - **Code Postal**: 75001
  - **Ville**: Paris
  - **Voie**: Rue de la Paix
  - **Numéro de Voie**: 123-124
  - **Complément de Voie**: Bis
  - **Infos supplémentaire** : Bâtiment 2 - Étage 3 - Porte 2

- Facture 1 : En attente de paiement, émise le 01/01/2024, échéance fixée à 30 jours, applique la TVA. La facture contient les lignes suivantes :
  - Prestation A, Quantité : 2, Prix unitaire : 300
  - Prestation B, Quantité : 1, Prix unitaire : 225.55
  - Prestation C, Quantité : 1, Prix unitaire : 500.25

#### Client 2

- **Nom**: Amarsid
- **Prénom**: Saliha
- **Adresse**:
  - **Code Postal**: 69002
  - **Ville**: Lyon
  - **Voie**: Avenue des Cèdres
  - **Numéro de Voie**: 45

- Facture 2 : Payée, émise le 02/01/2024, échéance fixée à 60 jours, n'applique pas la TVA. La facture contient les lignes suivantes :
  - Prestation A, Quantité : 1, Prix unitaire : 300
  - Prestation B, Quantité : 1, Prix unitaire : 225.25


## Exercice 4 : Conception d'une base de données d'un cinéma

> Modélisation (Niveau conceptuel)

1. **Modéliser** le SI d'un cinéma. Le cinéma dispose de 3 salles, et diffuse jusqu'à vingt films différents chaque mois. Chaque salle propose 3 séances : matin, midi et soir. 
2. **Ajouter** une réduction des tarifs en fonction de :

- L'âge du client :
  - En dessous de 12 ans: -50%
  - Entre 12 et 16: -25% uniquement le week-end (à partir de la séance de vendredi soir jusqu'à celle du dimanche soir) 
- De son statut : 
  - Chômage: -50%
  - Étudiant·e: -50%

> La réduction est appliquée lors de la recherche du prix (`SELECT`) pour une séance.

## Exercice 5 : Explorer et analyser une base existante

On vous fournit un dump d'une base de données existante sous forme d'archive `external-db.zip`. Vous allez travailler dessus les prochaines semaines. 

> Me demander de vous fournir cette archive !

1. Lire les instructions du `README` pour charger la base de données sur le serveur MySQL.
2. A l'aide de requêtes SQL d'inspection, étudier la base de données. **Produire le MCD de la base**.
3. Est-ce qu'un même employé peut travailler plusieurs fois pour le même département ?

<!-- 
Fournir la base de données test : test_db sur les employees
 -->

## Exercice 6 : Parc immobilier


- Le parc immobilier de la SCI (Société Civile Immobilière) EasyLocation est constitué d’appartements
faisant partie d’immeubles situé à une adresse (n°, voie, code postal, ville)
- L’immeuble dispose ou ne dispose pas de la fibre optique, il dispose ou non d’un parking privatif ;
- L’appartement a une valeur locative (loyer mensuel), il a une superficie totale, il a une description, il
possède ou non une terrasse, il a une classe de consommation d’énergie (« A », « B », « C », ...), il est
chauffé à l’électricité (« E ») ou au gaz (« G »), il a ou n’a pas de place de place de parking, s’il a une
place de parking, son prix est indiqué ;
- L’appartement est constitué d’une à plusieurs pièces ayant une superficie et une fonction (exemple :
« salle d’eau », « cuisine », etc.) ;
A l’appartement peuvent être attachées des photos

1. **Établir le Modèle Conceptuel des Données (MCD)** du SI.
2. A partir du MCD, **en déduire le Modèle Relationnel des Données** (ou Modèle Logique des Données MLD) à partir des règles de dérivation vues en cours.
3. Préciser les contraintes qui ne figurent pas sur le MCD.
  
> Exercice proposé par J. Paquereau (BTS SIO)

## Exercices et ressources supplémentaires

- [Challenges SQL sur codewars](https://www.codewars.com/kata/search/sql?q=&r%5B%5D=-8&r%5B%5D=-7&r%5B%5D=-6&tags=Databases&beta=false&order_by=sort_date%20desc), nécessite de se créer un compte
- [Les meilleurs cours et tutoriels pour apprendre les bases de données MySQL](https://mysql.developpez.com/cours/), sélection des meilleurs tutoriels et cours de formation gratuits pour apprendre le Système de Gestion de Base de Données MySQL. Vous trouverez les meilleures méthodes éducatives pour une formation agréable et complète, ainsi que des exercices intéressants, voire ludiques. Une sélection proposée par le site [developpez.com](https://developpez.com), un très bon site auquel contribuent des personnes compétentes en base de données relationnelles (dont Frédéric Brouard)

## Annexe A : Bien débuter un travail de conception

Quelques rappels et conseils sur la démarche à a adopter pour entamer un travail de conception :

- Établir la liste des attributs sous la forme d'un [*dictionnaire des données*](https://fr.wikipedia.org/wiki/Dictionnaire_des_donn%C3%A9es). Document indispensable pour lever les ambiguïtés de langage, communiquer avec votre client ou les experts du métier sur lequel vous travaillez. Chaque attribut doit avoir un nom, une définition, un type, un commentaire (contraintes métiers)
- Épurer, éviter les synonymes et les polysémies
- Décomposer les attributs structurés (**atomicité**): adresse, numéro de sécurité sociale, etc.
- Repérer les identifiants (ce qui identifie une structure, en général un label), en créer si nécessaire
- Déduire les classes (entités) à partir de chaque identifiant
- Disposer chaque attribut dans une classe (dépendance)
- Déterminer les associations entre classes dans un second temps
- Itérer, jeter les mauvaises idées, garder les bonnes et recommencer si nécessaire
- Ne pas raisonner en termes de traitements, mais en termes de *données factuelles et tangibles* (*les faits, toujours les faits!*)
- *Avancé :* Une fois le MCD conçu, passer le au crible des *formes normales* pour vérifier la bonne normalisation des données

## Annexe B : Références utiles

- [Normalisation des noms des objets des bases de données](https://sqlpro.developpez.com/cours/standards/), une proposition de standardisation interne à l'organisation de l'ensemble des éléments composant une base de données, par Frédéric Brouard. Propose un standard sur le nommage, les domaines de validité, la documentation, l'ergonomie et l'écriture des requêtes. Indépendant du SGBDR. **Ne pas hésiter à s'en servir.**
- [Fixed-Point Types (Exact Value) - DECIMAL, NUMERIC](https://dev.mysql.com/doc/refman/8.0/en/fixed-point-types.html), pour la représentation des valeurs monétaires
- [String Functions and Operators](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html), les fonctions MySQL sur les chaines de caractères
- [Aggregate Function Descriptions](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
- [GROUP_CONCAT](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html#function_group-concat)
- [test_db](https://github.com/datacharmer/test_db), le dépôt Github de la base de données externes