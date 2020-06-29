.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

/* Ao adicionar um Utilizador, verificar se o ano do evento é inferior ao ano corrente. */
CREATE TRIGGER IF NOT EXISTS VerificaEvento
BEFORE INSERT ON Utilizador
    WHEN CAST(strftime('%Y', date('now')) AS INTEGER) > new.evento
    BEGIN
        SELECT RAISE(abort, 'Evento inválido! O evento já acabou.');
    end;
    