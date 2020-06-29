.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

-- Adiciona um Modelo a ModeloVeiculo caso o modelo seja especificado
-- como 'Other' na inserçao de dados em Veiculo

CREATE TRIGGER IF NOT EXISTS AdicionaModelo
BEFORE INSERT ON Veiculo
    WHEN new.modelo LIKE 'Other'
    BEGIN
        INSERT OR IGNORE INTO MarcaVeiculo(nome) VALUES ('Other');
        INSERT OR IGNORE INTO ModeloVeiculo(nome, potencia, cilindrada, segmento, marca)
        VALUES ('Other', new.potencia, new.cilindrada, new.segmento, 'Other');
    end;