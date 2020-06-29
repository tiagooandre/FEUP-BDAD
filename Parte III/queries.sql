-- Listar o nome de todos os utilizadores
SELECT nome
FROM Utilizador;


-- Listar todos os veículos de 2013
SELECT id, modelo
FROM Veiculo
WHERE anoRegisto = 2013;

-- Listar todos os anuncios com interessados
SELECT DISTINCT Anuncio.id
FROM Anuncio INNER JOIN Interessado I on Anuncio.id = I.id
WHERE I.id IS NOT NULL
ORDER BY Anuncio.id;

-- Listar carros a diesel de ano superior a 2010 com caixa automatica
SELECT C.id
FROM Anuncio A
INNER JOIN Veiculo V on A.id = V.id
INNER JOIN Carro C on V.id = C.id
INNER JOIN CaixaVelocidades CV on C.tipoCaixa = CV.tipo and C.numVelocidades = CV.numVelocidades
WHERE V.anoRegisto > 2010 AND CV.tipo = 'automatic';

-- Listar número de anuncios por evento
SELECT evento, COUNT(*) AS numAnuncios
FROM Anuncio
GROUP BY evento
ORDER BY evento DESC;

-- Listar numero de peças por marca
SELECT marca, COUNT(*) as numPecas
FROM Peca
GROUP BY marca
ORDER BY marca;

-- Listar preço minimo, medio e maximo de Carros, Motos e Peças
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

-- Listar numero de veiculos e preço medio
SELECT AVG(preco) as MediaPreco, COUNT(*) as NumVeiculos
FROM Anuncio INNER JOIN Veiculo V on Anuncio.id = V.id;

-- Listar carros usados, de anunciante profissional, do envento de 2015,
-- caixa automática, menos de 100k KM, pelo menos 2 fotos e preço inferior a 40.000€
SELECT C.id as ID
FROM Anuncio
INNER JOIN Veiculo on Anuncio.id = Veiculo.id
INNER JOIN Carro C on Veiculo.id = C.id
WHERE tipoCaixa = 'automatic'
    AND quilometros < 100000
    AND preco < 40000
    AND 2 <= (SELECT COUNT(*) FROM Foto WHERE idAnuncio = C.id);

-- Ordenar eventos por desconto, listar numero de anuncios marcados com interesse
-- e valor total dos anuncios desse evento
SELECT evento, desconto, COUNT(id) as nAnunciosInteresse, SUM(preco)*(100-desconto)/100.0 as total
    FROM Anuncio, Evento
    WHERE ano = evento
    GROUP BY evento
    ORDER BY desconto DESC;