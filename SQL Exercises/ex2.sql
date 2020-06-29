PRAGMA foreign_keys = true;

-- DROPING ALL TABLES
DROP TABLE IF EXISTS FuncionarioReparacao;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Especialidade;
DROP TABLE IF EXISTS PecaModelo;
DROP TABLE IF EXISTS ReparacaoPeca;
DROP TABLE IF EXISTS Peca;
DROP TABLE IF EXISTS Reparacao;
DROP TABLE IF EXISTS Carro;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS CodPostal;
DROP TABLE IF EXISTS Modelo;
DROP TABLE IF EXISTS CodPostal;
DROP TABLE IF EXISTS Marca;
-- ....

CREATE TABLE Marca (
    idMarca INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT
);

CREATE TABLE Modelo (
    idModelo INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    idMarca INTEGER,
    FOREIGN KEY (idMarca) REFERENCES Marca
);

CREATE TABLE CodPostal (
    codPostal1 char(4) PRIMARY KEY,
    localidade TEXT
);

CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    morada TEXT,
    codPostal1 char(4),
    codPostal2 char(3),
    telefone char(9),
    FOREIGN KEY (codPostal1) references CodPostal
);

CREATE TABLE Carro (
    idCarro INTEGER PRIMARY KEY AUTOINCREMENT,
    matricula TEXT UNIQUE NOT NULL,
    idModelo INTEGER,
    idCliente INTEGER,
    FOREIGN KEY (idModelo) REFERENCES Modelo,
    FOREIGN KEY (idCliente) REFERENCES Cliente
);

CREATE TABLE Reparacao (
    idReparacao INTEGER PRIMARY KEY AUTOINCREMENT,
    dataInicio NUMERIC,
    dataFim NUMERIC,
    idCliente INTEGER,
    idCarro INTEGER,
    FOREIGN KEY (idCliente) REFERENCES Cliente,
    FOREIGN KEY (idCarro) REFERENCES Carro,

    CONSTRAINT CHK_date CHECK ( dataFim >= dataInicio )
);

CREATE TABLE Peca (
    idPeca INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo TEXT,
    designacao TEXT,
    custoUnitario NUMERIC,
    quantidade INTEGER
);

CREATE TABLE ReparacaoPeca (
    idReparacao INTEGER,
    idPeca INTEGER,
    quantidade INTEGER,
    PRIMARY KEY (idReparacao, idPeca),
    FOREIGN KEY (idReparacao) REFERENCES Reparacao,
    FOREIGN KEY (idPeca) REFERENCES Peca
);

CREATE TABLE PecaModelo (
    idPeca INTEGER,
    idModelo INTEGER,
    PRIMARY KEY (idPeca, idModelo),
    FOREIGN KEY (idPeca) REFERENCES Peca,
    FOREIGN KEY (idModelo) REFERENCES Modelo
);

CREATE TABLE Especialidade (
    idEspecialidade INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    custoHorario NUMERIC
);

CREATE TABLE Funcionario (
    idFuncionario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    morada TEXT,
    codPostal1 char(4),
    codPostal2 char(3),
    telefone char(9),
    idEspecialidade INTEGER,

    FOREIGN KEY (codPostal1) REFERENCES CodPostal,
    FOREIGN KEY (idEspecialidade) REFERENCES Especialidade
);

CREATE TABLE FuncionarioReparacao (
    idFuncionario INTEGER,
    idReparacao INTEGER,
    numHoras NUMERIC,

    PRIMARY KEY (idFuncionario, idReparacao),
    FOREIGN KEY (idFuncionario) REFERENCES Funcionario,
    FOREIGN KEY (idReparacao) REFERENCES Reparacao
);


