.mode columns
.headers on
.nullvalue NULL

-- 10. Ordenar eventos por desconto, listar numero de anuncios marcados com interesse
-- e valor total dos anuncios desse evento
SELECT evento, desconto, COUNT(id) as nAnunciosInteresse, SUM(preco)*(100-desconto)/100.0 as total
    FROM Anuncio, Evento
    WHERE ano = evento
    GROUP BY evento
    ORDER BY desconto DESC;