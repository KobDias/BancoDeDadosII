/*Testa existencia de banco 'Venda'*/
create database IF NOT EXISTS venda;

/* Exibir os bancos de dados*/
show databases;

/* verify qual o callation e  charset dos bancos */
SELECT SCHEMA_NAME 'database', default_character_set_name 'charset',
DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA;

/* Selecionar o banco de dados */
use venda; -- [nome do banco]

/*Visualize charset (config)*/
show variables like "character_set_database";

/*Visualize collation */
show variables like "collation_database";

/*Alterar c=o callation e o charset do banco venda*/
ALTER DATABASE venda DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

/*Visualize charset (config) */
show variables like "character_set_database";

/*Visualize collation */
show variables like "collation_database";

/*source caminho do sceipt;*/

/*09-05-23*/

DROP TABLE IF EXISTS cliente;

create table  cliente(
    cod_cliente smallint,
    nome_cliente VARCHAR (100),
    endereco_cliente VARCHAR (50),
    cidade_cliente VARCHAR (50),
    CEP VARCHAR (10),
    UF Char(2),
    CNPJ VARCHAR (18),
    IE VARCHAR (15)
) ENGINE=INNOdb DEFAULT CHARSET=utf8;

LOCK TABLES cliente WRITE;
    ALTER TABLE cliente
    ADD PRIMARY KEY (cod_cliente);
UNLOCK TABLES;

/*Inserir dados na tab cliente*/

insert into cliente VALUES('1', 'Microsoft', 'Av. Paulista', 'São Paulo', '17500000', 'SP', '52845990000175', '142270790110'), ('2', 'IBM', 'Av. Paulista', 'São Paulo', '17500000', 'SP', '33885990000105', '144070090440'), ('3', 'Dell', 'Av. Paulista', 'São Paulo', '17500000', 'SP', '55888890000220', '164090090333');


/*vendedor*/

DROP TABLE IF EXISTS vendedor;

create table vendedor(
    cod_vendedor smallint,
    nome_vendedor VARCHAR(150),
    salario_fixo decimal(9,2),
    faixa_comissao char(1),
    PRIMARY KEY (cod_vendedor)
)ENGINE= INNOdb DEFAULT CHARSET=utf8;

/*Inserir um vendedor*/

INSERT INTO vendedor VALUES('1', 'Marcos', '3000', 'A'), ('2', 'Ana', '3000', 'A'), ('3', 'João', '3000', 'B');

DROP IF EXISTS produto

create table produto(
    cod_produto smallint NOT NULL UNIQUE, 
    valor_unitario decimal (9,2), 
    descricao_PRODUTO VARCHAR(100),
    unidade CHAR(3)
 ) ENGINE=INNOdb DEFAULT CHARSET=utf8;

/*Cad produtos*/
insert into produto VALUES('1', '60', 'Silica', 'kg'), ('2', '70', 'Cobre', 'kg'), ('3', '360', 'Estanho', 'kg');

DROPT TABLE IF EXISTS pedido

create table pedido(
    num_pedido INT(10) NOT NULL UNIQUE,
    prazo_entrega smallint NOT NULL,
    cod_vendedor smallint NOT NULL,
    cod_cliente smallint NOT NULL,
    CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (cod_cliente) REFERENCES cliente(cod_cliente) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_pedido_vendedor
    FOREIGN KEY (cod_vendedor) REFERENCES vendedor(cod_vendedor) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=INNOdb DEFAULT CHARSET=utf8;

/*inserir pedido*/
insert into pedido VALUES('1', '15', '1', '1'), ('2', '10', '2', '2'), ('3', '20', '3', '3');

DROPT TABLE IF EXISTS item_pedido

create table item_pedido(
    num_pedido INT(10) NOT NULL UNIQUE,
    cod_vendedor smallint NOT NULL,
    quantidade DECIMAL,
    cod_produto smallint NOT NULL UNIQUE
 ) ENGINE=INNOdb DEFAULT CHARSET=utf8;

LOCK TABLES item_pedido WRITE;
    ALTER TABLE item_pedido
    ADD CONSTRAINT  fk_item_pedido_pedido FOREIGN KEY (num_pedido) REFERENCES pedido(num_pedido);
    ALTER TABLE item_pedido
    ADD CONSTRAINT  fk_item_pedido_produto FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto);
UNLOCK TABLES;

/* item pedido mais adiciona */
insert into item_pedido VALUES('1', '1', '100'), ('2', '3', '50');