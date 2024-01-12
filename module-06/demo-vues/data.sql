use demo_view;

DELETE FROM
    Utilisateur;

INSERT INTO
    Utilisateur(login, password)
VALUES
    ('foobar', 'mypassword');

-- Déclarer une variable pour stocker l'id de l'utilisateur généré via AUTO_INCREMENT
SET
    @user_id = LAST_INSERT_ID();

INSERT INTO
    Profil(prenom, nom, pseudo, email, utilisateur_id)
VALUES
    (
        'John',
        'Doe',
        'jdoe',
        'john.doe@mail.net',
        @user_id
    );

INSERT INTO
    Publication(titre, contenu, date_publication, auteur_id)
VALUES
    (
        'A quoi servent les vues ?',
        'The CREATE VIEW statement creates a new view, or replaces an existing view if the OR REPLACE clause is given. If the view does not exist, CREATE OR REPLACE VIEW is the same as CREATE VIEW. If the view does exist, CREATE OR REPLACE VIEW replaces it.',
        '2024-01-11',
        @user_id
    );