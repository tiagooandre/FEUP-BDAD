.mode columns
.headers on
.nullvalue NULL

-- 2. Listar todos os veículos de 2013
SELECT id, modelo
FROM Veiculo
WHERE anoRegisto = 2013;