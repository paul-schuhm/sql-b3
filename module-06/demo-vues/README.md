# Démo : Vues

Démonstration de l'utilisation des vues pour respecter la confidentialité des données et faciliter l'écriture de requêtes pour les utilisateur·ices de la base de données.

- [Démo : Vues](#démo--vues)
  - [Contexte](#contexte)
  - [Lancer la démo](#lancer-la-démo)
  - [Ressources](#ressources)


## Contexte

Dans cette démo, nous créons un petit schéma pour un site web éditorial.

## Lancer la démo

~~~bash
#Charger le schéma de la base de données 'demo_view'
mysql -uroot -p < schema.sql
#Charger un jeu de données test
mysql -uroot -p < data.sql
~~~

Essayer les requêtes suivantes sur une connexion avec le serveur MySQL :

~~~SQL
-- Tester la fonction de hachage SHA-2 256
SELECT SHA2('some-password', 256);
use demo_view
-- Mettre à jour le mot de passe de l'utilisateur 'foobar'
UPDATE Utilisateur SET password='newpassword' WHERE login='foobar';
-- Le trigger hash_password_trigger_change_password est déclenché et re hash le nouveau mot de passe
-- Afficher tous les triggers
SHOW TRIGGERS;
~~~

On veut à présent créer un utilisateur avec un role d'*editeur* : l'éditeur doit pouvoir accéder au contenu publié par les utilisateurs mais on ne souhaite pas qu'il accède à ses informations personnelles (**Sécurité : confidentialité**). On va donc créer un utilisateur SQL `editor` qui aura uniquement le droit de lire (`SELECT`) une vue qui contient les informations sur les publications et les pseudo uniquement :

~~~SQL
-- Création de la vue pour le role editor
CREATE VIEW 
editorial 
AS 
SELECT pseudo, titre, date_publication, contenu 
FROM Utilisateur u 
INNER JOIN Profil p 
ON u.id=p.utilisateur_id 
INNER JOIN Publication pu 
ON pu.auteur_id=u.id;
-- Création de l'utilisateur editor
CREATE USER 'editor'@'localhost' IDENTIFIED BY 'passeditor';
-- On lui donne le droit uniquement de SELECT sur la vue crée pour lui
GRANT SELECT ON demo_view.editorial TO 'editor'@'localhost';
~~~

Ouvrir une nouvelle connexion avec l'utilisateur `editor`

~~~bash
mysql -ueditor -p -Ddemo_view
~~~

Une fois la connexion ouverte, inspecter les tables visibles :

~~~SQL
SHOW TABLES;
TABLE editorial;
~~~

Seule la vue `editorial` est visible et requêtable en lecture seule pour l'editor.

> Remarque : on pourrait lui permettre de modifier le contenu de la vue (titre, contenu) pour maintenir la ligne éditorial du site et faire de la modération, cette modification serait ensuite reportée sur la table "réelle" Publication. Ceci se fait via une vue matérialisée (plus avancé). Laissé en guise d'exercice.

## Ressources

- [CREATE VIEW Statement](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)
- [CREATE TRIGGER Statement](https://dev.mysql.com/doc/refman/8.0/en/create-trigger.html)
- [Trigger Syntax and Examples](https://dev.mysql.com/doc/refman/8.0/en/trigger-syntax.html)
- [SET Syntax for Variable Assignment](https://dev.mysql.com/doc/refman/8.0/en/set-variable.html)