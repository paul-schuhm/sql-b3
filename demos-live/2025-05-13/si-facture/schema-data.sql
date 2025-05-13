-- Insertion des clients

CREATE DATABASE IF NOT EXISTS fac;

use fac

DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Invoice;

CREATE TABLE Client (  `id` int NOT NULL AUTO_INCREMENT,  `first_name` varchar(200) DEFAULT NULL,  `last_name` varchar(200) DEFAULT NULL,  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE Invoice (  `id` INT NOT NULL AUTO_INCREMENT,  `number` CHAR(12) NOT NULL,  `issued_at` DATE NOT NULL,  `total_amount_ati_euros` DECIMAL(5,1) NOT NULL,  `is_paid` TINYINT NOT NULL DEFAULT 0,  `id_client` INT NOT NULL,  PRIMARY KEY (`id`),  UNIQUE INDEX `number_UNIQUE` (`number` ASC) VISIBLE,  INDEX `fk_Invoice_Client_idx` (`id_client` ASC) VISIBLE,  CONSTRAINT `fk_invoice_concerns_client`    FOREIGN KEY (`id_client`)    REFERENCES `Client` (`id`)    ON DELETE NO ACTION    ON UPDATE NO ACTION)ENGINE = InnoDB;


-- Insertion des client·es
INSERT INTO Client (first_name, last_name) VALUES('Alice', 'Dupont'),('Bruno', 'Lemoine'),('Claire', 'Durand'),('David', 'Moreau'),('Emma', 'Bernard');

-- Insertion des factures
INSERT INTO Invoice (number, issued_at, total_amount_ati_euros, is_paid, id_client) VALUES('INV001', '2024-11-01', 120.50, 1, 1),('INV002', '2024-11-05', 89.99, 0, 1),('INV003', '2024-12-01', 150.00, 1, 2),('INV004', '2024-12-10', 75.20, 0, 2),('INV005', '2025-01-15', 200.00, 1, 3),('INV006', '2025-01-18', 49.90, 0, 3),('INV007', '2025-01-20', 310.00, 1, 3),('INV008', '2025-02-01', 180.75, 1, 4),('INV009', '2025-02-10', 99.99, 0, 4),('INV010', '2025-02-15', 60.00, 1, 4),('INV011', '2025-03-01', 140.30, 0, 5),('INV012', '2025-03-05', 250.00, 1, 5),('INV013', '2025-03-10', 130.00, 0, 5),('INV014', '2025-03-15', 95.00, 1, 1),('INV015', '2025-03-20', 180.00, 0, 2),('INV016', '2025-03-25', 220.00, 1, 2),('INV017', '2025-03-28', 199.99, 1, 3),('INV018', '2025-04-01', 87.65, 0, 4),('INV019', '2025-04-05', 310.50, 1, 5),('INV020', '2025-04-10', 45.00, 0, 1);
