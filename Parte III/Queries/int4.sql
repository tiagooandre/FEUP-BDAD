.mode columns
.headers on
.nullvalue NULL

-- 4. Listar carros a diesel de ano superior a 2010 com caixa automatica
SELECT C.id
FROM Anuncio A
INNER JOIN Veiculo V on A.id = V.id
INNER JOIN Carro C on V.id = C.id
INNER JOIN CaixaVelocidades CV on C.tipoCaixa = CV.tipo and C.numVelocidades = CV.numVelocidades
WHERE V.anoRegisto > 2010 AND CV.tipo = 'automatic';