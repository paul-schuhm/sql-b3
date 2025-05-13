-- Lister les factures impayées
SELECT * FROM Invoice WHERE NOT is_paid;
-- Afficher le CA Total TTC
SELECT SUM(total_amount_ati_euros) AS "Total TTC" FROM Invoice;
-- Les factures impayéées du plus haut montant au plus faible
-- ORDER BY pour trier suivant la valeur d'une colonne
SELECT * FROM Invoice WHERE NOT is_paid ORDER BY total_amount_ati_euros DESC;
-- LIMIT pour limiter le nb de lignes à retourner
SELECT * FROM Invoice WHERE NOT is_paid ORDER BY issued_at LIMIT 3;
-- Lister les factures de 2025
SELECT * FROM Invoice WHERE YEAR(issued_at)=2025;
-- Lister les factures impayées de 2025
SELECT * FROM Invoice WHERE YEAR(issued_at)=2025 AND NOT is_paid;
-- Calculer le CA Total TTC encore non encaissé (non payé)
SELECT SUM(total_amount_ati_euros) AS "Total TTC Impayé" FROM Invoice WHERE NOT is_paid;
-- Montant total facturé par client
SELECT c.first_name, c.last_name, SUM(i.total_amount_ati_euros) FROM Invoice i JOIN Client c ON i.id_client=c.id WHERE NOT is_paid GROUP BY c.id ORDER BY SUM(i.total_amount_ati_euros) DESC;
-- Créer une vue "Mauvais payeurs"
CREATE VIEW Mauvais_Payeurs AS SELECT c.first_name, c.last_name, SUM(i.total_amount_ati_euros) FROM Invoice i JOIN Client c ON i.id_client=c.id WHERE NOT is_paid GROUP BY c.id ORDER BY SUM(i.total_amount_ati_euros) DESC LIMIT 3;

