-- Exercicio 1 a)
DROP TRIGGER IF EXISTS Oficina1a;
CREATE TRIGGER Oficina1a
    AFTER INSERT ON Reparacao
    WHEN (New.idCliente IS NULL)
    begin
        UPDATE Reparacao
        SET idCliente = (SELECT idCliente FROM Carro WHERE Carro.idCarro = New.idCarro)
        WHERE idReparacao = new.idReparacao;
    end;


-- Exercicio 1 b)
DROP TRIGGER IF EXISTS Oficina1b;
CREATE TRIGGER Oficina1b
    BEFORE INSERT ON ReparacaoPeca
    WHEN new.idPeca NOT IN
    (SELECT idPeca FROM PecaModelo
        WHERE idModelo = (SELECT idModelo FROM Carro
            WHERE idCarro = (SELECT idCarro FROM Reparacao
                WHERE Reparacao.idReparacao = New.idReparacao)))
    OR
         New.idPeca IN
    (SELECT idPeca FROM Peca
        WHERE Peca.quantidade < New.quantidade)
    BEGIN
        SELECT RAISE(ABORT, 'Peça ou quantidade inválidos.');
    end;

-- this will trigger an exception
INSERT INTO ReparacaoPeca (idReparacao, idPeca, quantidade)
VALUES (3, 2, 20);

-- Exercicio 1 c)
DROP TRIGGER IF EXISTS Oficina1c;
CREATE TRIGGER Oficina1c
    AFTER INSERT ON ReparacaoPeca
    begin
        UPDATE Peca
        SET quantidade = quantidade - new.quantidade
        where idPeca = new.idPeca;
    end;


-- Exercicio 2 a)
DROP TRIGGER IF EXISTS Clinica2a;
CREATE TRIGGER Clinica2a
BEFORE INSERT ON ConsultasMarcadas
WHEN New.codmedico NOT IN (
SELECT codigo
FROM Disponibilidade
WHERE dia = New.data AND codigo NOT IN (
SELECT codmedico
FROM ConsultasMarcadas
WHERE data = New.data
GROUP BY codmedico
HAVING COUNT(*) >= (SELECT numdoentes
FROM HorarioConsultas AS HC, Disponibilidade AS D
WHERE HC.idhorarioconsulta = D.idhorarioconsulta AND
D.dia = data AND D.codigo = codmedico)))
BEGIN
SELECT RAISE(IGNORE);
END;

-- Exercicio 2 b)
DROP TRIGGER IF EXISTS Clinica2b;
CREATE TRIGGER Clinica2b
BEFORE INSERT ON ConsultasMarcadas
WHEN New.horainicio IN (SELECT horainicio
FROM ConsultasMarcadas
WHERE data = New.data AND codmedico = New.codmedico AND horainicio = New.horainicio)
BEGIN
SELECT RAISE(IGNORE);
END;