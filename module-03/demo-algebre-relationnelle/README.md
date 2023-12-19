# Démo algèbre relationnelle : ensemble des opérations définies et implémentées en MySQL

~~~bash
#Créer les tables (DDL)
mysql -udev -p < ddl.sql
#Insérer les données test (DML)
mysql -udev -p < dml.sql
#Faire les requêtes (DQL)
mysql -udev -p < dql.sql
~~~

> N'hésitez pas à modifier les scripts, essayer d'utiliser ces opérateurs pour écrire vos propres requêtes !

## Références

- [Set Operations with UNION, INTERSECT, and EXCEPT](https://dev.mysql.com/doc/refman/8.0/en/set-operations.html), l'ensemble des opérations sur les ensembles
- [UNION](https://dev.mysql.com/doc/refman/8.0/en/union.html), le OU logique
- [INTERSECT](https://dev.mysql.com/doc/refman/8.0/en/intersect.html), le ET logique
- [EXCEPT](https://dev.mysql.com/doc/refman/8.0/en/except.html), la différence
- [CROSS JOIN](https://dev.mysql.com/doc/refman/8.0/en/join.html), la multiplication
- [WHERE](https://dev.mysql.com/doc/refman/8.0/en/select.html), voir la clause `WHERE` dans la page