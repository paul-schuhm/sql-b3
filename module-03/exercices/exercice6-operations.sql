--1 Type du poste p8
SELECT
    num_poste,
    type_poste
FROM
    Poste
WHERE
    num_poste = 'p8';

--2 Noms des logiciels UNIX
SELECT
    nom_logiciel
FROM
    Logiciel
WHERE
    type_logiciel = 'UNIX';

--3 Nom, adresse IP, numéro de salle des postes de type UNIX ou PCWS.
SELECT
    nom_poste,
    ind_ip,
    ad,
    num_salle
FROM
    Poste
WHERE
    type_poste = 'UNIX'
    OR type_poste = 'PCWS';

--4 Même requête pour les postes du segment 130.120.80 triés
--par numéro de salle décroissant
SELECT
    nom_poste,
    ind_ip,
    ad,
    num_salle
FROM
    Poste
WHERE
    (
        type_poste = 'UNIX'
        OR type_poste = 'PCWS'
    )
    AND ind_ip = '130.120.80'
ORDER BY
    num_salle DESC;

--5 Numéros des logiciels installés sur le poste p6
SELECT numero_logiciel
FROM
    Installer
WHERE
    num_poste = 'p6';

--6 Numéros des postes qui hébergent le logiciel log1.
SELECT num_poste
FROM
    Installer
WHERE
    numero_logiciel = 'log1';

--7 Nom et adresse IP complète (ex : 130.120.80.01) des postes de type TX
SELECT
    nom_poste,
    CONCAT(ind_ip, '.', ad)
FROM
    Poste
WHERE
    type_poste = 'TX';

--8 Nombre de logiciels installé par poste
SELECT
    num_poste,
    COUNT(numero_logiciel)
FROM
    Installer
GROUP BY
    (num_poste);

--9 Nombre de postes par salle
SELECT
    num_salle,
    COUNT(num_poste)
FROM
    Poste
GROUP BY
    (num_salle);

--10
SELECT
    numero_logiciel,
    COUNT(num_poste)
FROM
    Installer
GROUP BY
    (numero_logiciel);

--11 Prix moyen des logiciels sur les postes de type UNIX
SELECT
    AVG(prix)
FROM
    Logiciel
WHERE
    type_logiciel = 'UNIX';

--12
SELECT
    MAX(dateAch)
FROM
    Logiciel;

--13
SELECT
    num_poste,
FROM
    Installer
GROUP BY
    num_poste,
HAVING
    COUNT(numero_logiciel) = 2;

--14 Nombre de postes où sont installés 2 logiciels
SELECT
    COUNT(*)
FROM
    (
        SELECT
            num_poste
        FROM
            Installer
        GROUP BY
            num_poste
        HAVING
            COUNT(numero_logiciel) = 2
    ) T;

--15
SELECT
    type_logiciel_poste
FROM
    Types
WHERE
    type_logiciel_poste NOT IN (
        SELECT
            DISTINCT type_poste
        FROM
            Poste
    );


--17
SELECT
    DISTINCT type_poste
FROM
    Poste
WHERE
    type_poste NOT IN (
        SELECT
            type_logiciel
        FROM
            Logiciel
    );