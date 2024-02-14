# Démo triggers

Une démo simple sur les triggers. Lorsqu'un utilisateur est ajouté, modifié ou supprimé un log est généré dans une table. A l'ajout d'un user, le nombre d'homonymes déjà présent dans la base est également indiqué.

## Instructions

Charger le schéma :

~~~bash
mysql -uuser -p < schema.sql
~~~

**Ou** directement depuis une connexion ouverte (avec l'instruction `SOURCE`) :

~~~bash
mysql> SOURCE ./schema.sql
~~~

> Fournir le chemin absolu ou relatif à l'endroit où la connexion a été ouverte sur le système de fichiers.

## Utiliser la démo

~~~SQL
-- Insertion d'un homonyme
INSERT INTO User(first_name,last_name)VALUES('John','Doe');
TABLE Log;
-- Jane a rejoint le système d'information
INSERT INTO User(first_name,last_name)VALUES('Jane','Thompson');
TABLE Log;
-- John et Jane se sont mariés, Jane a pris le nom de John
UPDATE User SET last_name = 'Doe' WHERE first_name='Jane';
TABLE Log;
-- John et Jane ont quitté notre service d'informations
DELETE FROM User WHERE last_name="Doe";
-- Inspecter la table de log
TABLE Log;
~~~

## Liens utiles

- [Syntaxe des triggers et exemples (en)](https://dev.mysql.com/doc/refman/8.0/en/trigger-syntax.html), documentation officielle MySQL
- [CREATE TRIGGER Statement](https://dev.mysql.com/doc/refman/8.0/en/create-trigger.html), documentation officielle MySQL