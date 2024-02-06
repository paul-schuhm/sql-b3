DELIMITER //


CREATE PROCEDURE hello_world()
BEGIN
    SELECT 'Hello, World!' AS Message;
END //

CREATE PROCEDURE IF NOT EXISTS fizz_buzz(IN game_size INT, OUT result VARCHAR(255))
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE temp_result VARCHAR(255) DEFAULT '';

    WHILE i <= game_size DO
        IF i % 3 = 0 AND i % 5 = 0 THEN
            SET temp_result = CONCAT(temp_result, 'FizzBuzz, ');
        ELSEIF i % 3 = 0 THEN
            SET temp_result = CONCAT(temp_result, 'Fizz, ');
        ELSEIF i % 5 = 0 THEN
            SET temp_result = CONCAT(temp_result, 'Buzz, ');
        ELSE
            SET temp_result = CONCAT(temp_result, i, ', ');
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Remove the trailing comma and space
    SET result_string = SUBSTRING(temp_result, 1, LENGTH(temp_result) - 2);
END //

DELIMITER ;

-- Remarque : je n'ai pas besoin de déclarer @result avant l'appel. Elle est déclarée dans l'appel et initialisée à NULL
CALL fizz_buzz(5, @result);
SELECT @result;