create database gerenciamento;

use gerenciamento;

CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    cargo VARCHAR(255),
    departamento VARCHAR(255)
);

CREATE TABLE estoque (
    id INT PRIMARY KEY,
    produto VARCHAR(255),
    quantidade_estoque INT
);


CREATE TABLE relacionamento_cliente_vendedor (
    id INT PRIMARY KEY,
    cliente VARCHAR(255),
    vendedor VARCHAR(255)
);

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    produto VARCHAR(255),
    preco DECIMAL(10, 2)
);

CREATE TABLE pedidos (
    numero_pedido INT PRIMARY KEY,
    cliente VARCHAR(255),
    status VARCHAR(255),
    data_entrega DATE
);


INSERT INTO relacionamento_cliente_vendedor (id, cliente, vendedor)
VALUES 
(1, 'marta', 'carlos'),
(2, 'jose', 'paulo'),
(3, 'vinicius', 'marcos');

INSERT INTO produtos (id, produto, preco)
VALUES 
(1, 'boneca', 150.50),
(2, 'carrinho', 95.75),
(3, 'tabuleiro', 200.00);

INSERT INTO pedidos (numero_pedido, cliente, status, data_entrega)
VALUES 
(101, 'marta', 'Pendente', NULL),
(102, 'jose', 'Entregue', '2023-11-01'),
(103, 'vinicius', 'Pendente', NULL);

INSERT INTO funcionarios (id, nome, cargo, departamento)
VALUES 
(1, 'João Silva', 'Analista', 'Administrativo'),
(2, 'Maria Oliveira', 'Gerente', 'Administrativo'),
(3, 'Carlos Santos', 'Assistente', 'Vendas');

INSERT INTO estoque (id, produto, quantidade_estoque)
VALUES 
(1, 'carrinho', 10),
(2, 'boneca', 3),
(3, 'tabuleiro', 7);

CREATE VIEW vw_funcionarios_departamento AS
SELECT nome, cargo
FROM funcionarios
WHERE departamento = 'Administrativo';

CREATE VIEW vw_estoque_insuficiente AS
SELECT produto, quantidade_estoque
FROM estoque
WHERE quantidade_estoque < 5;

CREATE VIEW vw_relacionamento_cliente_vendedor AS
SELECT cliente, vendedor
FROM relacionamento_cliente_vendedor;

CREATE VIEW vw_produtos_caros AS
SELECT produto, preco
FROM produtos
WHERE preco > 100;

CREATE VIEW vw_pedidos_pendentes AS
SELECT numero_pedido, cliente, status, data_entrega
FROM pedidos
WHERE status = 'Pendente' AND data_entrega IS NULL;


