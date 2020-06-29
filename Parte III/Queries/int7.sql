.mode columns
.headers on
.nullvalue NULL

-- 7. Listar preço minimo, medio e maximo de Carros, Motos e Peças
SELECT AVG(precoCarros) as MediaPrecoCarros, AVG(precoMotos) as MediaPrecoMotos, AVG(precoPecas) as MediaPrecoPecas,
       MIN(precoCarros) as MinPrecoCarros, MIN(precoMotos) as MinPrecoMotos, MIN(precoPecas) as MinPrecoPecas,
       MAX(precoCarros) as MaxPrecoCarros, MAX(precoMotos) as MaxPrecoMotos, MAX(precoPecas) as MaxPrecoPecas
FROM
     (SELECT preco as precoMotos
        FROM Anuncio INNER JOIN Moto M on Anuncio.id = M.id),
     (SELECT preco as precoCarros
         FROM Anuncio INNER JOIN Carro C on Anuncio.id = C.id),
     (SELECT preco as precoPecas
         FROM Anuncio INNER JOIN Peca P on Anuncio.id = P.id);
