-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `id_client` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(32) NOT NULL,
  `nom` VARCHAR(32) NOT NULL,
  `raison_sociale` VARCHAR(45) NOT NULL,
  `Adresse_Entete_id_client` INT NOT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adresse_Entete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adresse_Entete` (
  `id_client` INT NOT NULL,
  `code_postal` CHAR(5) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `voie` VARCHAR(32) NOT NULL,
  `numero_voie_debut` INT NOT NULL,
  `numero_voie_fin` INT NULL,
  `numero_complement` ENUM('BIS', 'TER', 'QUATER', 'A', 'B') NULL,
  `pays` VARCHAR(45) NULL,
  `Client_id_client` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_Adresse_Entete_Client1_idx` (`Client_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Adresse_Entete_Client1`
    FOREIGN KEY (`Client_id_client`)
    REFERENCES `mydb`.`Client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adresse_Ligne`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adresse_Ligne` (
  `id_client` INT NOT NULL,
  `position` INT UNSIGNED NOT NULL,
  `ligne` VARCHAR(38) NULL,
  `Client_id_client` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_client`, `position`, `Client_id_client`),
  INDEX `fk_Adresse_Ligne_Client1_idx` (`Client_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Adresse_Ligne_Client1`
    FOREIGN KEY (`Client_id_client`)
    REFERENCES `mydb`.`Client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Facture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Facture` (
  `id_facture` INT NOT NULL,
  `date_emission` DATE NOT NULL,
  `echeance_en_jours` TINYINT NOT NULL DEFAULT 60,
  `tva_applicable` TINYINT NOT NULL,
  `numero` VARCHAR(25) NOT NULL,
  `status` ENUM('ATT', 'PAY') NOT NULL,
  `Client_id_client` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_facture`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC) VISIBLE,
  INDEX `fk_Facture_Client1_idx` (`Client_id_client` ASC) VISIBLE,
  CONSTRAINT `fk_Facture_Client1`
    FOREIGN KEY (`Client_id_client`)
    REFERENCES `mydb`.`Client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ligne_Facture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ligne_Facture` (
  `id_ligne_facture` INT NOT NULL,
  `idFacture` VARCHAR(45) NULL,
  `designation` VARCHAR(32) NOT NULL,
  `prix_unitaire_ht_euro` INT NOT NULL,
  `quantite` SMALLINT NOT NULL,
  `Facture_id_facture` INT NOT NULL,
  PRIMARY KEY (`id_ligne_facture`),
  INDEX `fk_Ligne_Facture_Facture1_idx` (`Facture_id_facture` ASC) VISIBLE,
  CONSTRAINT `fk_Ligne_Facture_Facture1`
    FOREIGN KEY (`Facture_id_facture`)
    REFERENCES `mydb`.`Facture` (`id_facture`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'La colonne prix doit avoir une valeur supérieure à 0';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Ajout des contraintes sur les lignes avec une contrainte CHECK (contraintes 9 et 10 de l'énoncé)
ALTER TABLE Adresse_Entete 
ADD CONSTRAINT ck_voie 
CHECK 
(LENGTH(adresse_en_tete_numero_voie_debut) + LENGTH(adresse_en_tete_numero_voie_fin) + LENGTH(adresse_en_tete_numero_complement) + LENGTH(adresse_en_tete_voie) <= 38);

ALTER TABLE Adresse_Entete 
ADD CONSTRAINT ck_ville_code_postal 
CHECK 
(LENGTH(adresse_en_tete_code_postal) + LENGTH(adresse_en_tete_ville) <= 38);

-- Test

-- Adresse OK
-- INSERT INTO Adresse_Entete(client_id, adresse_en_tete_code_postal, adresse_en_tete_ville, adresse_en_tete_voie, adresse_en_tete_numero_voie_debut , adresse_en_tete_numero_voie_fin, adresse_en_tete_numero_complement, adresse_en_tete_pays) VALUES (1, '75001', 'Paris', 'Rue de la paix', 123, 124, 'Bis', 'France');

-- Adresse Qui ne respecte pas le standard sur la ligne de la voie
-- INSERT INTO Adresse_Entete(client_id, adresse_en_tete_code_postal, adresse_en_tete_ville, adresse_en_tete_voie, adresse_en_tete_numero_voie_debut , adresse_en_tete_numero_voie_fin, adresse_en_tete_numero_complement, adresse_en_tete_pays) VALUES (1, '75001', 'Paris', "Rue de l'Ambiance Spectaculaire", 123, 124, 'Bis', 'France');