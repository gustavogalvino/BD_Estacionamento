


CREATE DATABASE BD_ESTACIONAMENTO2

USE BD_ESTACIONAMENTO2


CREATE TABLE TB_CLIENTE(
	CPF VARCHAR(20),
	NOME VARCHAR(150) NOT NULL,
	SOBRENOME VARCHAR(150) NOT NULL,
	RG VARCHAR(20) NOT NULL,
	UF_RG CHAR(2) NOT NULL,
	LOGRADOURO VARCHAR(150) NOT NULL,
	NUMERO INT NOT NULL,
	COMPLEMENTO VARCHAR(150),
	CIDADE VARCHAR(100) NOT NULL,
	ESTADO VARCHAR(100) NOT NULL,

	CONSTRAINT PK_CPF_CLIENTE PRIMARY KEY (CPF),
	CONSTRAINT UK_RG_CLIENTE UNIQUE (RG, UF_RG)
);

CREATE TABLE TB_FUNCIONARIO(
	MATRICULA INT IDENTITY,
	NOME VARCHAR(150) NOT NULL,
	RG VARCHAR(20) NOT NULL,
	UF_RG CHAR(2) NOT NULL,
	CPF VARCHAR(20) NOT NULL,

	CONSTRAINT PK_MATRICULA PRIMARY KEY (MATRICULA),
	CONSTRAINT UK_RG_FUN UNIQUE (RG, UF_RG)
);

CREATE TABLE TB_VEICULO(
	CPF_CLIENTE VARCHAR(20),
	PLACA VARCHAR(20),
	MARCA VARCHAR(50) NOT NULL,
	COR VARCHAR(50) NOT NULL,
	MODELO VARCHAR(50) NOT NULL,
	MATRICULA INT,

	CONSTRAINT PK_CPF_PLACA_CLIENTE PRIMARY KEY (PLACA, CPF_CLIENTE),
	CONSTRAINT FK_CPF_CLIENTE FOREIGN KEY (CPF_CLIENTE) REFERENCES TB_CLIENTE (CPF),
	CONSTRAINT FK_MATRICULA FOREIGN KEY (MATRICULA) REFERENCES TB_FUNCIONARIO (MATRICULA)
);

CREATE TABLE TB_VAGA(
	NUMERO INT,
	SETOR VARCHAR(100) NOT NULL,

	CONSTRAINT PK_NUMERO PRIMARY KEY (NUMERO)
);

CREATE TABLE TB_LOCACAO(
	PLACA_VEICULO VARCHAR(20),
	VAGA INT,
	CPF_CLIENTE VARCHAR(20),
	DATA_HORA_ENTRADA DATETIME,
	DATA_HORA_SAIDA DATETIME,
	VALOR MONEY NOT NULL,

	CONSTRAINT PK_PLACA_VAGA PRIMARY KEY (PLACA_VEICULO, VAGA),
	CONSTRAINT FK_CPF_PLACA_CLIENTE FOREIGN KEY (PLACA_VEICULO, CPF_CLIENTE) 
		REFERENCES TB_VEICULO (PLACA, CPF_CLIENTE), 
	CONSTRAINT FK_NUM_VAGA FOREIGN KEY (VAGA) REFERENCES TB_VAGA (NUMERO),
	CONSTRAINT CK_VALOR CHECK (VALOR >= 10)
);



ALTER TABLE TB_CLIENTE ADD 
	CONSTRAINT DF_COMPLEMENTO DEFAULT ('N�O POSSUI') FOR COMPLEMENTO

ALTER TABLE TB_LOCACAO ADD 
	CONSTRAINT DF_ENTRADA DEFAULT (GETDATE()) FOR DATA_HORA_ENTRADA