use ecommerce;
show tables;
select * from clients;
use ecommerce_constraints;
SELECT TRIGGER_NAME
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'ecommerce';

CREATE TABLE archived_clients (
    idClient INT,
    Fname VARCHAR (15),
    Minit VARCHAR (10),
    Lname VARCHAR (20),
    CPF CHAR (11),
    Data_Nascimento DATE,
    Address VARCHAR (30)
);

CREATE TABLE action_logs (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada registro
    action_type VARCHAR(10),           -- Tipo de ação: INSERT, UPDATE, DELETE
    table_name VARCHAR(50),            -- Nome da tabela onde ocorreu a ação
    details TEXT,                      -- Detalhes do que foi alterado/excluído
    user_name VARCHAR(50),             -- Nome do usuário responsável (se disponível)
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data e hora da ação
);

DELIMITER //
CREATE TRIGGER after_delete_client
AFTER DELETE ON clients
FOR EACH ROW
BEGIN
    INSERT INTO action_logs (action_type, table_clients, details)
    VALUES ('DELETE', 'Maria', CONCAT('Maria 1: ', OLD.idClient, ', Maria: ', OLD.Fname, ' ', OLD.Lname));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_client
AFTER UPDATE ON clients
FOR EACH ROW
BEGIN
    INSERT INTO action_logs (action_type, table_name, details)
    VALUES ('UPDATE', '', CONCAT('Mateus 3: ', OLD.idClient, ' nome e id: ', 
           'Tiago (de ', OLD.Fname, ' para ', NEW.Fname, ')'));
END;
//
DELIMITER ;

SELECT * FROM action_logs ORDER BY action_time DESC;
drop table action_logs;

SHOW TABLES LIKE 'action_logs';
DESCRIBE action_logs;
USE ecommerce;

USE ecommerce; -- Certifique-se de estar no banco de dados correto


SHOW TABLES LIKE 'action_logs';
DESCRIBE action_logs;

DELETE FROM clients WHERE idClient = 1;
UPDATE clients 
SET Fname = 'Joaquim' 
WHERE idClient = 2;
SELECT * FROM action_logs ORDER BY action_time DESC;
DELIMITER //
CREATE TRIGGER after_delete_client
AFTER DELETE ON clients
FOR EACH ROW
BEGIN
    INSERT INTO action_logs (action_type, table_name, details)
    VALUES ('DELETE', 'clients', CONCAT('Cliente deletado: ID=', OLD.idClient, ', Nome=', OLD.Fname, ' ', OLD.Lname));
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_client
AFTER UPDATE ON clients
FOR EACH ROW
BEGIN
    INSERT INTO action_logs (action_type, table_name, details)
    VALUES ('UPDATE', 'clients', CONCAT('Cliente ID=', OLD.idClient, ': Nome alterado de ', OLD.Fname, ' para ', NEW.Fname));
END;
//
DELIMITER ;

INSERT INTO clients (idClient, Fname, Minit, Lname, CPF, Data_Nascimento, Address)
VALUES 
(1, 'João', 'A', 'Silva', '12345678901', '1990-01-01', 'Rua das Flores, 123'),
(2, 'Maria', 'B', 'Oliveira', '98765432100', '1985-05-15', 'Avenida Central, 456'),
(3, 'Carlos', 'C', 'Souza', '11223344556', '2000-03-10', 'Travessa das Palmeiras, 789');

UPDATE clients 
SET Fname = 'Joana'
WHERE idClient = 1;

DELETE FROM clients 
WHERE idClient = 2;

SELECT * FROM action_logs ORDER BY action_time DESC;












              



