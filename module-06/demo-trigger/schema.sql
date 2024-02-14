CREATE DATABASE IF NOT EXISTS demo_triggers;

USE demo_triggers;

DROP TABLE User;

DROP TABLE Log;

CREATE TABLE User(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(32),
    first_name VARCHAR(32)
);

CREATE TABLE Log(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    timestamp TIMESTAMP,
    operation CHAR(10),
    details VARCHAR(80)
);

INSERT INTO
    User(first_name, last_name)
VALUES
    ('John', 'Doe');

-- Trigger INSERT
CREATE TRIGGER log_user_added
AFTER
INSERT
    ON User FOR EACH ROW
INSERT INTO
    Log(timestamp, operation, details)
VALUES
    (
        SYSDATE(),
        'INSERT',
        CONCAT_WS(
            ' ',
            'User',
            NEW.first_name,
            NEW.last_name,
            'has entered the system'
        )
    );

-- Trigger UPDATE
CREATE TRIGGER log_user_updated
AFTER
UPDATE
    ON User FOR EACH ROW
INSERT INTO
    Log(timestamp, operation, details)
VALUES
    (
        SYSDATE(),
        'UPDATE',
        CONCAT_WS(
            ' ',
            'User',
            OLD.first_name,
            OLD.last_name,
            'has been updated to',
            NEW.first_name,
            NEW.last_name
        )
    );

-- Trigger DELETE
CREATE TRIGGER log_user_removed
AFTER
DELETE
    ON User FOR EACH ROW
INSERT INTO
    Log(timestamp, operation, details)
VALUES
    (
        SYSDATE(),
        'DELETE',
        CONCAT_WS(
            ' ',
            'User',
            OLD.first_name,
            OLD.last_name,
            'has been removed from the system'
        )
    );



-- Trigger INSERT avec un corps (plusieurs instructions dans le corps)
DELIMITER //
CREATE TRIGGER log_user_added_extended
BEFORE INSERT ON User FOR EACH ROW
BEGIN
    -- Calcule le nombre d'homonymes (même prénom et même nom) déjà présents dans la base au moment de l'insertion.
    DECLARE nb_of_homonyms INT DEFAULT 0;
    SELECT COUNT(*) INTO nb_of_homonyms FROM User WHERE first_name=NEW.first_name AND last_name=NEW.last_name;
    
    INSERT INTO Log(timestamp, operation, details)
    VALUES
    (
        NOW(),
        'INSERT',
        CONCAT_WS(
            ' ',
            'User',
            NEW.first_name,
            NEW.last_name,
            'has entered the system - ',
            nb_of_homonyms,
            'homonyms detected)'
        )
    );
END;
//
DELIMITER ;