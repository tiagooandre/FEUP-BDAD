.mode columns
.headers on
.nullvalue NULL

-- 9. Listar carros usados, de anunciante profissional, do evento de 2015,
-- caixa automática, menos de 100k KM, pelo menos 2 fotos e preço inferior a 40.000€
SELECT C.id as ID
FROM Anuncio
INNER JOIN Veiculo on Anuncio.id = Veiculo.id
INNER JOIN Carro C on Veiculo.id = C.id
WHERE tipoCaixa = 'automatic'
    AND quilometros < 100000
    AND preco < 40000
    AND 2 <= (SELECT COUNT(*) FROM Foto WHERE idAnuncio = C.id);