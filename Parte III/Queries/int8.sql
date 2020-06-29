.mode columns
.headers on
.nullvalue NULL

-- 8. Listar numero de veiculos e preço medio
SELECT AVG(preco) as MediaPreco, COUNT(*) as NumVeiculos
FROM Anuncio INNER JOIN Veiculo V on Anuncio.id = V.id;
