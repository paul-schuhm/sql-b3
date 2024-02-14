# Exercices - Module 6, Niveau Externe : Vues, triggers, procédures et fonctions stockées

Version : 3

- [Exercices - Module 6, Niveau Externe : Vues, triggers, procédures et fonctions stockées](#exercices---module-6-niveau-externe--vues-triggers-procédures-et-fonctions-stockées)
  - [Pré-requis](#pré-requis)
  - [Exercice 1 : Vues monotables](#exercice-1--vues-monotables)
  - [Exercice 2 : Procédures stockées](#exercice-2--procédures-stockées)
  - [Exercice 3 : Écriture de fonctions](#exercice-3--écriture-de-fonctions)
  - [Exercice 4 : Procédure et variables de session](#exercice-4--procédure-et-variables-de-session)
  - [Exercice 4 : SI d'une station service](#exercice-4--si-dune-station-service)
  - [Exercice 5 : Réaliser le SI du mondial de football](#exercice-5--réaliser-le-si-du-mondial-de-football)
  - [Références](#références)


<hr>

## Pré-requis

- Exercice 1, Exercice 2 : avoir la base `parc` et ses données (cf Module 3/Exercice 1).
- Exercice 4 : avoir la base `exercice3` et ses données (cf Module 4/Exercice 3).

## Exercice 1 : Vues monotables

**Écrire** le script `vues.sql` en suivant les consignes suivantes:

1. **Créer** la vue `LogicielsUnix` qui contient tous les logiciels de type 'UNIX' (toutes les colonnes sont
conservées). **Vérifier** la *structure* et le *contenu* de la vue (`DESCRIBE` et `SELECT`).
2. **Créer** la vue `Poste_0` de structure `(nPos0, nomPoste0, nSalle0, TypePoste0, indIP, ad0)` qui
contient tous les postes du rez-de-chaussée (`etage=0` au niveau de la table `Segment`). **Vérifier** la *structure* et le *contenu* de la vue.
**Insérer** deux nouveaux postes dans la vue tels qu’un poste soit connecté au segment du rez-de-
chaussée, et l’autre à un segment d’un autre étage. **Vérifier** le contenu de la vue et celui de la table.
Conclusion ?
3. **Supprimer** ces deux enregistrements de la table `Poste`.
4. **Créer** la vue `SallePrix` de structure `(nSalle, nomSalle, nbPoste, prixLocation)` qui
contient les salles et leur prix de location pour une journée (en fonction du nombre de postes). Le
montant de la location d’une salle à la journée sera d’abord calculé sur la base de 100 EUROS par poste.
Servez-vous de l’expression `100*nbPoste` dans la requête de définition.
5. **Vérifier** le contenu de la vue, puis afficher les salles dont le prix de location dépasse 150 EUROS.
6. **Ajouter** la colonne tarif de type `SMALLINT(4)` à la table `Types`. **Mettre à jour** cette table de
manière à insérer les valeurs suivantes:

|   Type du poste	| Tarif en Euros  	|
|---	|---	|
|  TX 	|  50 	|
|  PCWS 	| 100  	|
|  PCNT 	|   120	|
|   UNIX	|   200	|
|   NC	|   80	|
|   BeOS	|  400 	|

7. **Créer** la vue `SalleIntermediaire` de structure `(nSalle, typePoste, nombre, tarif)`, de
telle sorte que le contenu de la vue reflète le tarif ajusté des salles, en fonction du nombre et du type
des postes de travail. Il s’agit de grouper par salle, type et tarif (tout en faisant une jointure avec la table
`Types` pour les tarifs), et de compter le nombre de postes pour avoir le résultat suivant :


|  num_salle 	|  type 	|   nombre	|   tarif	|
|---	|---	|---	|---	|
|  s01 	|  TX 	|   2	|   50	|
|  s01 	|  UNIX 	|   2	| 200  	|
|  s02 	|  PCWS 	|   2	|   100	|
|  s03 	|  TX 	|   1	|   50	|
|  etc. 	|   	|   	|   	|


8. À partir de la vue `SalleIntermediaire`, **créer** la vue `SallePrixTotal(num_salle, prix_reel)`
qui reflète le prix réel de chaque salle (par exemple, la `s01` sera facturée 2x50 + 1x200 = 300 EUROS). **Vérifier** le contenu de cette vue.

9. **Afficher** les salles les plus économiques à la location.


## Exercice 2 : Procédures stockées

**Écrire** la procédure MySQL qui affiche **les détails de la dernière installation de logiciel** sous la forme suivante
(les champs `numérodeSalle`, `numéroPoste`, `nomLogiciel`, `dateInstallation` sont à extraire) :

~~~
+------------------------------------------------+
| Derniere installation (salle)
|
+------------------------------------------------+
| Derniere installation en salle : **numérodeSalle** |
+------------------------------------------------+
+--------------------------------------------------------------------+
| Derniere installation (poste)
|
+--------------------------------------------------------------------+
| Poste : **numéroPoste** Logiciel : **nomLogiciel** en date du **dateInstallation** |
+--------------------------------------------------------------------+
~~~


> Vous utiliserez `SELECT ... INTO` pour extraire ces valeurs. Ne tenez pas compte, pour le moment, des erreurs qui pourraient éventuellement se produire (aucune installation de logiciel, poste ou logiciel non référencés dans la base, etc.).

## Exercice 3 : Écriture de fonctions

1. **Implémenter les contraintes** de l'exercice Module 4 / Exercice 3 (système de facturation avec adresse standardisée aux normes européennes) de sorte qu'on ne puisse pas insérer de données d'adresse ne respectant pas le standard. 

2. **Écrire une fonction** qui retourne l'adresse complète d'un·e client·e et bien formatée selon les standards de son pays. La fonction aura la signature suivante :`complete_address_format(client_id, format='fr')`. Elle prend en argument l'identifiant du client et un format (par défaut le format français `fr`). Implémenter également le format des adresses utilisé en [Royaume-Uni](https://fr.wikipedia.org/wiki/Adresse_postale#Royaume-Uni) (`gb`).

<!-- Remplacer le trigger par une procédure stockée. La procédure doit journaliser les tentatives infructueuses dans une table de journalisation `Adresse_Log` prévue à cet effet. La table aura la structure suivante : `id_log`, `timestamp`, `operation`, `details`. Les triggers doivent enregistrer les tentatives infructueuses avec un horodatage, le type d'opération (INSERT ou UPDATE) et des détails sur la contrainte violée. -->

## Exercice 4 : Procédure et variables de session

Écrire le bloc MySQL qui affecte hors d’un bloc, par des variables session, un numéro de salle et un
type de poste, et qui retourne des variables session permettant de composer un message indiquant
les nombres de postes et d’installations de logiciels correspondants :

~~~bash
+--------------------------------------------------------------------+
| Resultat exo2
|
+--------------------------------------------------------------------+
| x poste(s) installe(s) en salle y, z installation(s) de type t
|
+--------------------------------------------------------------------+
~~~

Essayez pour la salle `s01` et le type `UNIX`. Vous devez extraire 1 poste et 3 installations. 

> Ne tenez pas compte pour le moment d’éventuelles erreurs (aucun poste trouvé ou aucune installation réalisée, etc.).

## Exercice 4 : SI d'une station service

1. **Modéliser** le SI d'une station-service, qui dispose de 4 pompes. La station sert différents types de carburant. Le carburant est réglé par la station-service via carte bancaire. Le prix au litre est mis à jour tous les 24 heures automatiquement. **Proposer** une modélisation conceptuelle, puis **transformer** en modélisation relationnelle (avec les clefs, les types et les contraintes). 
2. **Implémenter le SI** avec MySQL et documenter votre projet.
3. Suite au contexte actuel, l'état a imposé des restrictions sur le plein faisable en station par personne et par jour. **Ajouter** une contrainte de restriction sur un prix maximum de `120 EUROS` lors d'une transaction. A l'aide d'un [event scheduler](https://dev.mysql.com/doc/refman/8.2/en/events-configuration.html) et [d'un évènement](https://dev.mysql.com/doc/refman/8.2/en/create-event.html), mettre à jour le prix des carburants. On supposera que les nouveaux pris sont fournis au format CSV au SBGDR. 
4. Créez une procédure stockée pour récupérer le prix actuel d'un carburant spécifique à partir de la table des prix en fonction du type de carburant fourni en entrée. Créer une procédure stockée qui simulera la vérification du solde du client avant qu'il puisse se servir à la pompe. Cette procédure sera déclenchée par un [trigger](https://dev.mysql.com/doc/refman/8.0/en/trigger-syntax.html). [Créer une vue](https://dev.mysql.com/doc/refman/8.0/en/create-view.html) pour l'administrateur de la base de données lui indiquant le volume restant dans les réservoirs de la station pour chaque type de carburant ainsi que le crédit total de la station (argent accumulé) sur la journée, la semaine et le mois courant.

> Sentez vous libre concernant les détails d'implémentation (le sujet ne spécifie pas entièrement le problème). Demandez-moi un avis et/ou des conseils pour aller plus loin ou sur des spécifications. L'idée est de travailler sur un système proche d'un système réel pour mesurer la complexité du système et d'apprendre à se servir des procédures stockées, des events et schedulers, des triggers et des vues.


## Exercice 5 : Réaliser le SI du mondial de football

Réaliser la système d'information conçu au module 4. Grâce aux procédures stockées, fonctions et/ou triggers mettez en place un système qui maintient à jour le classement dans chaque poule (`information dénormalisée`).


## Références

- Les énoncés des exercices 1, 2 et 4 sont tirés de l'ouvrage [*Apprendre SQL avec MySQL avec 40 exercices corrigés*](https://www.amazon.fr/APPRENDRE-AVEC-MYSQL-EXERCICES-CORRIGES/dp/2212119151/ref=sr_1_1), de Soutou, publié chez Eyrolles, 2006.