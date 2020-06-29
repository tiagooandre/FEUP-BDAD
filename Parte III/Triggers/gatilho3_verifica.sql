.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print 'Tentamos adicionar um utilizador (Joaquim Fernandes) no evento de 2019'
.print ''

INSERT INTO Utilizador (nome, telefone, email, evento)
VALUES ('Joaquim Fernandes', '913232321', 'email@example.com', 2019);


.print 'Tentamos adicionar um utilizador (Joaquim Fernandes) no evento de 2020'
.print ''

INSERT INTO Utilizador (nome, telefone, email, evento)
VALUES ('Joaquim Fernandes', '913232321', 'email@example.com', 2020);

.print 'Como podemos ver, o utilizador existe na base de dados'
.print ''

SELECT * FROM Utilizador WHERE telefone = '913232321';

-- apagar dados temporarios
DELETE FROM Utilizador WHERE telefone = '913232321';
