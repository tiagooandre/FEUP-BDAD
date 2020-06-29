PRAGMA foreign_keys = true;

DROP TABLE IF EXISTS Interessado;
DROP TABLE IF EXISTS Moto;
DROP TABLE IF EXISTS Carro;
DROP TABLE IF EXISTS Combustivel;
DROP TABLE IF EXISTS Tracao;
DROP TABLE IF EXISTS CaixaVelocidades;
DROP TABLE IF EXISTS Peca;
DROP TABLE IF EXISTS CategoriaPeca;
DROP TABLE IF EXISTS MarcaPeca;
DROP TABLE IF EXISTS Veiculo;
DROP TABLE IF EXISTS Registo;
DROP TABLE IF EXISTS Cor;
DROP TABLE IF EXISTS ModeloVeiculo;
DROP TABLE IF EXISTS MarcaVeiculo;
DROP TABLE IF EXISTS Segmento;
DROP TABLE IF EXISTS Foto;
DROP TABLE IF EXISTS Anuncio;
DROP TABLE IF EXISTS Condicao;
DROP TABLE IF EXISTS UtilizadorProfissional;
DROP TABLE IF EXISTS UtilizadorParticular;
DROP TABLE IF EXISTS Utilizador;
DROP TABLE IF EXISTS Evento;

CREATE TABLE Evento(
    nome TEXT NOT NULL,
    desconto INTEGER CHECK ( desconto > 0 AND desconto < 100 ) NOT NULL,
    ano INTEGER PRIMARY KEY CHECK ( ano >= 1600 )
);

CREATE TABLE Utilizador(
    nome TEXT NOT NULL,
    telefone TEXT UNIQUE NOT NULL,
    email TEXT PRIMARY KEY,
    evento INTEGER,
    FOREIGN KEY (evento) REFERENCES Evento
);

CREATE TABLE UtilizadorParticular(
    email TEXT PRIMARY KEY,
    FOREIGN KEY (email) REFERENCES Utilizador
);

CREATE TABLE UtilizadorProfissional(
    email TEXT PRIMARY KEY,
    localizacao TEXT NOT NULL,
    nif char(9) UNIQUE NOT NULL,
    avatar TEXT NOT NULL,
    FOREIGN KEY (email) REFERENCES Utilizador
);

CREATE TABLE Condicao(
    tipo TEXT PRIMARY KEY
);

CREATE TABLE Anuncio(
    id INTEGER PRIMARY KEY,
    descricao TEXT NOT NULL,
    condicao TEXT NOT NULL,
    anunciante TEXT NOT NULL,
    evento INTEGER,
    preco INTEGER CHECK ( preco >= 0 ) NOT NULL,
    data TEXT NOT NULL,
    FOREIGN KEY (condicao) REFERENCES Condicao,
    FOREIGN KEY (evento) REFERENCES Evento,
    FOREIGN KEY (anunciante) REFERENCES Utilizador
);

CREATE TABLE Foto(
    link TEXT PRIMARY KEY,
    idAnuncio INTEGER,
    FOREIGN KEY (idAnuncio) REFERENCES Anuncio
);

CREATE TABLE Segmento(
    tipo TEXT PRIMARY KEY
);

CREATE TABLE MarcaVeiculo(
    nome TEXT PRIMARY KEY
);

CREATE TABLE ModeloVeiculo(
    nome TEXT,
    potencia INTEGER CHECK (potencia >= 0),
    cilindrada INTEGER CHECK (cilindrada >= 0),
    segmento TEXT NOT NULL,
    marca TEXT NOT NULL,
    PRIMARY KEY (nome, potencia, cilindrada, segmento),
    FOREIGN KEY (segmento) REFERENCES Segmento,
    FOREIGN KEY (marca) REFERENCES MarcaVeiculo
);

CREATE TABLE Cor(
    nome TEXT PRIMARY KEY
);

CREATE TABLE Registo(
    ano INTEGER CHECK (ano >= 1600),
    mes INTEGER CHECK ( mes BETWEEN 1 AND 12 ),
    PRIMARY KEY (ano, mes)
);

CREATE TABLE Veiculo(
    id INTEGER PRIMARY KEY,
    matricula TEXT UNIQUE NOT NULL,
    mesRegisto INTEGER NOT NULL,
    anoRegisto INTEGER NOT NULL,
    modelo TEXT NOT NULL,
    potencia INTEGER NOT NULL,
    cilindrada INTEGER NOT NULL,
    segmento TEXT NOT NULL,
    quilometros INTEGER NOT NULL CHECK ( quilometros >= 0 ),
    ivaDedutivel INTEGER DEFAULT 0,
    retoma INTEGER DEFAULT 0,
    financiamento INTEGER DEFAULT 0,
    numRegistos INTEGER CHECK ( numRegistos >= 1 ) NOT NULL,
    cor TEXT NOT NULL,
    FOREIGN KEY (id) REFERENCES Anuncio,
    FOREIGN KEY (mesRegisto, anoRegisto) REFERENCES Registo(mes, ano),
    FOREIGN KEY (modelo, potencia, cilindrada, segmento) REFERENCES ModeloVeiculo(nome, potencia, cilindrada, segmento),
    FOREIGN KEY (cor) REFERENCES Cor,
    CONSTRAINT CHK_BOOL CHECK ( (ivaDedutivel = 0 OR ivaDedutivel = 1) AND
                                (retoma = 0 OR retoma = 1) AND
                                (financiamento = 0 OR financiamento= 1) )
);

CREATE TABLE MarcaPeca(
    nome TEXT PRIMARY KEY
);

CREATE TABLE CategoriaPeca(
    nome TEXT PRIMARY KEY
);

CREATE TABLE Peca(
    id INTEGER PRIMARY KEY,
    marca TEXT NOT NULL,
    categoria TEXT NOT NULL,
    FOREIGN KEY (id) REFERENCES Anuncio,
    FOREIGN KEY (marca) REFERENCES MarcaPeca,
    FOREIGN KEY (categoria) REFERENCES CategoriaPeca
);

CREATE TABLE CaixaVelocidades(
    tipo TEXT,
    numVelocidades INTEGER CHECK ( numVelocidades >= 1 ),
    PRIMARY KEY (tipo, numVelocidades)
);

CREATE TABLE Tracao(
    tipo TEXT PRIMARY KEY
);

CREATE TABLE Combustivel(
    tipo TEXT PRIMARY KEY
);

CREATE TABLE Carro(
    id INTEGER PRIMARY KEY,
    lotacao INTEGER CHECK ( lotacao >= 1 ) NOT NULL,
    classe TEXT,
    numPortas INTEGER CHECK ( numPortas >= 2 ) NOT NULL,
    tracao TEXT NOT NULL,
    importado INTEGER,
    tipoCaixa TEXT NOT NULL,
    numVelocidades INTEGER NOT NULL,
    combustivel TEXT NOT NULL,
    FOREIGN KEY (id) REFERENCES Veiculo,
    FOREIGN KEY (tracao) REFERENCES Tracao,
    FOREIGN KEY (tipoCaixa, numVelocidades) REFERENCES CaixaVelocidades,
    FOREIGN KEY (combustivel) REFERENCES Combustivel,
    CONSTRAINT CHK_BOOL CHECK ( importado = 0 OR importado = 1 )
);

CREATE TABLE Moto(
    id INTEGER PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Veiculo
);

CREATE TABLE Interessado(
    email TEXT,
    id TEXT,
    PRIMARY KEY (email, id),
    FOREIGN KEY (email) REFERENCES Utilizador,
    FOREIGN KEY (id) REFERENCES Anuncio
);
