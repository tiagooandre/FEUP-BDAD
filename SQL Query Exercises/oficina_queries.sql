-- Exercicio a)
SELECT * FROM Peca
WHERE custoUnitario < 10 AND codigo LIKE '%98%';

-- Exercicio b)
SELECT Carro.Matricula
FROM Carro INNER JOIN Reparacao R on Carro.idCarro = R.idCarro
WHERE dataFim <= '2010-09-31' AND dataInicio >= '2010-09-01';

-- Exercicio c)
SELECT C2.nome
FROM Reparacao
INNER JOIN ReparacaoPeca RP on Reparacao.idReparacao = RP.idReparacao
INNER JOIN Carro C on Reparacao.idCarro = C.idCarro
INNER JOIN Cliente C2 on C.idCliente = C2.idCliente
INNER JOIN Peca P on RP.idPeca = P.idPeca
WHERE P.custoUnitario > 10
ORDER BY P.custoUnitario DESC;

-- Exercicio d)
SELECT nome
FROM Cliente
WHERE idCliente NOT IN (SELECT idCliente FROM Carro);

-- Exercicio e)
SELECT idCarro, count(*) AS numReparacoes
FROM Reparacao GROUP BY idCarro;

-- Exercicio f)
SELECT matricula,
       SUM(strftime('%d',dataFim) - strftime('%d',dataInicio)) "No de dias"
FROM Carro, Reparacao
WHERE Carro.idCarro=reparacao.idCarro
GROUP BY matricula;

-- Exercicio g)
-- TODO -> acabar exercicio
