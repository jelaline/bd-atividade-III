

use funcional;


CREATE TABLE tb_produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    data_validade DATE,
    preco DECIMAL(10, 2),
    estoque INT
);

CREATE TABLE tb_estoque (
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES tb_produtos(id_produto)
);


-- Inserindo dados na tabela de produtos
INSERT INTO tb_produtos (id_produto, nome, data_validade, preco, estoque)
VALUES
    (1, 'estante', '2023-12-31', 100.00, 50),
    (2, 'armario', '2023-11-30', 150.00, 30);

-- Criando a tabela de funcionários
CREATE TABLE tb_funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255)
);


INSERT INTO tb_funcionarios (id_funcionario, nome)
VALUES
    (1, 'ana'),
    (2, 'julia');


CREATE TABLE tb_dependentes (
    id_dependente INT PRIMARY KEY,
    nome VARCHAR(255),
    id_funcionario INT,
    FOREIGN KEY (id_funcionario) REFERENCES tb_funcionarios(id_funcionario)
);


INSERT INTO tb_dependentes (id_dependente, nome, id_funcionario)
VALUES
    (1, 'paulo', 1),
    (2, 'pedro', 2);


DELIMITER //
CREATE TRIGGER valida_data_validade
BEFORE INSERT ON tb_produtos
FOR EACH ROW
BEGIN
    IF NEW.data_validade < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de validade vencida';
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER aumenta_preco
BEFORE UPDATE ON tb_produtos
FOR EACH ROW
BEGIN
    SET NEW.preco = NEW.preco * 1.10;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON tb_estoque
FOR EACH ROW
BEGIN
    UPDATE tb_produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER insere_funcionario_demitido
AFTER DELETE ON tb_funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO tb_funcionarios_demitidos (id_funcionario, nome)
    VALUES (OLD.id_funcionario, OLD.nome);
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER exclui_dependente
AFTER DELETE ON tb_funcionarios
FOR EACH ROW
BEGIN
    DELETE FROM tb_dependentes
    WHERE id_funcionario = OLD.id_funcionario;
END;
//
DELIMITER ;
