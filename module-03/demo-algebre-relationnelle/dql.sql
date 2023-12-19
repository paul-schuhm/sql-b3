-- Algèbre relationnelle : ensemble des opérations définies et implémentées en MySQL

-- Restriction
SELECT
    *
FROM
    Psql
WHERE
    nom LIKE 'h%';

-- Projection
SELECT
    nom
FROM
    Psql;

-- Union : tout le monde
SELECT
    *
FROM
    Psql
UNION
SELECT
    *
FROM
    Pjava;

-- Intersection : présent dans les deux cours
SELECT
    *
FROM
    Psql
INTERSECT
SELECT
    *
FROM
    Pjava;

-- Difference : elements d'une relation qui n'existe pas dans l'autre
-- Difference : Personnes présentes dans Psql mais pas dans Pjava
SELECT
    nom
FROM
    Psql
WHERE
    id NOT IN (
        SELECT
            id
        FROM
            Pjava
    );

-- Avec MySQL8+ (à préférer)

(SELECT * FROM Psql) EXCEPT (SELECT * FROM Pjava);

-- Difference : Personnes présentes dans Pjava mais pas dans Psql
SELECT
    nom
FROM
    Pjava
WHERE
    id NOT IN (
        SELECT
            id
        FROM
            Psql
    );

-- Multiplication
SELECT
    *
FROM
    Carte
    CROSS JOIN Couleur;

SELECT
    COUNT(*) as 'Nombre de cartes'
FROM
    Carte
    CROSS JOIN Couleur;
