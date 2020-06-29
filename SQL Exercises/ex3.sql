PRAGMA foreign_keys = true;

DROP TABLE IF EXISTS Aluno;
DROP TABLE IF EXISTS Prof;
DROP TABLE IF EXISTS Cadeira;
DROP TABLE IF EXISTS Prova;


CREATE TABLE Aluno (
    nr int PRIMARY KEY,
    nome TEXT NOT NULL
);

CREATE TABLE Prof (
    sigla TEXT PRIMARY KEY,
    nome TEXT
);

CREATE TABLE Cadeira (
    cod TEXT PRIMARY KEY,
    design TEXT,
    curso TEXT,
    regente TEXT,
    FOREIGN KEY (regente) REFERENCES Prof(nome)
        ON DELETE
            no action
        ON UPDATE
            no action
);

CREATE TABLE Prova (
    nr int,
    cod TEXT,
    data char(8),
    nota NUMERIC,
    PRIMARY KEY (nr, cod, data),

    FOREIGN KEY (nr) REFERENCES Aluno(nr)
        ON DELETE
            no action
        ON UPDATE
            no action,
    FOREIGN KEY (cod) REFERENCES Cadeira(cod)
        ON DELETE
            no action
        ON UPDATE
            no action,

    CONSTRAINT CHK_nota CHECK ( nota >= 0 AND nota <= 20 )
);

-- Inserting values

INSERT INTO Aluno(nr, nome)
    VALUES (100, 'João');
INSERT INTO Aluno(nr, nome)
    VALUES (110, 'Manuel');
INSERT INTO Aluno(nr, nome)
    VALUES (120, 'Rui');
INSERT INTO Aluno(nr, nome)
    VALUES (130, 'Abel');
INSERT INTO Aluno(nr, nome)
    VALUES (140, 'Fernando');
INSERT INTO Aluno(nr, nome)
    VALUES (150, 'Ismael');