.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Quando adicionamos um utilizador com um e-mail inválido:'
.print ''

INSERT INTO Utilizador(email, nome, evento, telefone)
	VALUES('123123123', 'João Figueiredo', 2019, '123123123');

.print 'Quando adicionamos um utilizador com um e-mail válido:'
.print ''

INSERT INTO Utilizador(email, nome, evento, telefone)
	VALUES('email@example.net', 'João Figueiredo', 2019, '123123123');

SELECT * FROM Utilizador WHERE nome = 'João Figueiredo';

DELETE FROM Utilizador WHERE email = 'email@example.net';