use exercice3;

DELETE FROM
    Facture_Ligne;

DELETE FROM
    Facture;

DELETE FROM
    Adresse_Entete;

DELETE FROM
    Adresse_Ligne;

DELETE FROM
    Client;

-- Insertion des clients
INSERT INTO
    Client (
        client_id,
        client_prenom,
        client_nom,
        client_raison_sociale
    )
VALUES
    (1, '', '', 'Parisian Tech Solutions S.A.'),
    (2, 'Saliha', 'Amarsid', '');

INSERT INTO
    Adresse_Entete (
        client_id,
        adresse_en_tete_code_postal,
        adresse_en_tete_ville,
        adresse_en_tete_voie,
        adresse_en_tete_numero_voie_debut,
        adresse_en_tete_numero_voie_fin,
        adresse_en_tete_numero_complement,
        adresse_en_tete_pays
    )
VALUES
    (
        1,
        '75001',
        'Paris',
        'Rue de la Paix',
        123,
        124,
        'Bis',
        'France'
    ),
    (
        2,
        '69002',
        'Lyon',
        'Avenue des Cèdres',
        45,
        NULL,
        NULL,
        'France'
    );

INSERT INTO
    Adresse_Ligne(
        client_id,
        adresse_ligne_position,
        adresse_ligne_ligne
    )
VALUES
    (1, 3, 'Bâtiment 2 - Étage 3 - Porte 2'), -- En 3eme ligne de l'adresse 
    (1, 2, 'Service Comptabilité'); -- En 2eme ligne de l'adresse

-- Insérer les factures
INSERT INTO
    Facture (
        facture_id,
        facture_statut,
        facture_date_emission,
        facture_echeance_en_jours,
        facture_tva_applicable,
        client_id
    )
VALUES
    (1, 'ATT', '2024-01-01', 30, 1, 1),
    (2, 'PAY', '2024-01-02', 60, 0, 2);

INSERT INTO
    Facture_Ligne(
        facture_id,
        ligne_facture_designation,
        ligne_facture_quantite,
        ligne_facture_prix_unitaire_euro
    )
VALUES
    (1, 'Prestation A', 2, 300),
    (1, 'Prestation B', 1, 225.55),
    (1, 'Prestation C', 1, 500.25),
    (2, 'Prestation B', 1, 225.55),
    (2, 'Prestation A', 1, 300);