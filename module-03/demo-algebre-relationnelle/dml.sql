USE operations;

TRUNCATE Psql;

TRUNCATE Pjava;

INSERT INTO
    Psql(id, nom)
VALUES
    (3415, 'Harry'),
    (3401, 'Georges'),
    (3456, 'Hélène'),
    (2241, 'Sally');

INSERT INTO
    Pjava(id, nom)
VALUES
    (3415, 'Harry'),
    (2, 'Bertrand'),
    (3402, 'Eve'),
    (2241, 'Sally'),
    (1000, 'Barbara');

INSERT INTO
    Couleur(nom)
VALUES
    ('Coeur'),
    ('Carreau'),
    ('Pique'),
    ('Trèfle');

INSERT INTO
    Carte(valeur)
VALUES
    ('As'),
    ('2'),
    ('3'),
    ('4'),
    ('5'),
    ('6'),
    ('7'),
    ('8'),
    ('9'),
    ('10'),
    ('V'),
    ('D'),
    ('R');