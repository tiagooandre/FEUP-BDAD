.mode columns
.headers on
.nullvalue NULL

-- 5. Listar número de anuncios por evento
SELECT evento, COUNT(*) AS numAnuncios
FROM Anuncio
GROUP BY evento
ORDER BY evento DESC;