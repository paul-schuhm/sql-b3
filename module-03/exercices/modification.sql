USE mod3;

SELECT * FROM Segment;

UPDATE Segment SET etage=0 WHERE ind_ip = '130.120.80';
UPDATE Segment SET etage=1 WHERE ind_ip = '130.120.81';
UPDATE Segment SET etage=2 WHERE ind_ip = '130.120.82';

SELECT * FROM Segment;

SELECT num_logiciel, type_logiciel, prix FROM Logiciel;
UPDATE Logiciel SET prix = prix*0.9 WHERE type_logiciel = 'PCNT';
SELECT num_logiciel, type_logiciel, prix FROM Logiciel;







