.mode columns
.headers on
.nullvalue NULL

-- 3. Listar todos os anuncios com interessados.
SELECT DISTINCT Anuncio.id
FROM Anuncio INNER JOIN Interessado I on Anuncio.id = I.id
WHERE I.id IS NOT NULL
ORDER BY Anuncio.id;