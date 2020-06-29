.mode columns
.headers on
.nullvalue NULL

-- 6. Listar numero de peças por marca
SELECT marca, COUNT(*) as numPecas
FROM Peca
GROUP BY marca
ORDER BY marca;