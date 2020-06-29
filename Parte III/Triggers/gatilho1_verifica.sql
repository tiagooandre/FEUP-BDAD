.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print 'Primeiro adicionamos o anuncio referente'
.print ''

INSERT INTO Anuncio (id, descricao, condicao, anunciante, evento, preco, data)
VALUES (1000, 'Lorem ipsum', 'new', 'dnapoleon3@mac.com', 2015, 12300, '2015-12-31');

.print 'Tentamos adicionar um veiculo usando modelo "Other"'
.print ''

INSERT INTO Veiculo (id, matricula, mesRegisto, anoRegisto, modelo, potencia, cilindrada, segmento, quilometros, ivaDedutivel, retoma, financiamento, numRegistos, cor)
VALUES (1000, '12-XL-12', 12, 2010, 'Other', 150, 1500, 'city', 100000, 0, 0, 0, 1, 'blue');

.print 'Podemos ver que foi adicionado um modelo novo "Other" com 150cv, 1500cc e segmento "city"'
.print ''

SELECT * FROM ModeloVeiculo WHERE nome = 'Other';


-- apagar os dados criados para verificação do trigger
DELETE FROM Veiculo WHERE id = 1000;
DELETE FROM Anuncio WHERE id = 1000;
DELETE FROM ModeloVeiculo WHERE nome = 'Other';
DELETE FROM MarcaVeiculo WHERE nome = 'Other';