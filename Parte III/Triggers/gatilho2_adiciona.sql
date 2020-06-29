.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

/*  Ao adicionar um Utilizador, se o email não for do 
    tipo email@example.example then its aborted */

CREATE TRIGGER IF NOT EXISTS VerificaEmail
BEFORE INSERT ON Utilizador
    WHEN new.email NOT LIKE '%_@__%.__%'
    BEGIN
        SELECT RAISE (ABORT, 'Endereço de e-mail inválido!');
    end;