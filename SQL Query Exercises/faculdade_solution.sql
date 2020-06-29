-- Exercicio 1
SELECT nr from aluno;

-- Exercicio 2
SELECT cod, Design
FROM cadeira
WHERE curso='AC';

-- Exercicio 3
SELECT DISTINCT aluno.Nome
FROM prof, aluno
WHERE aluno.Nome = prof.Nome;

-- Exercicio 4 (https://javarevisited.blogspot.com/2013/05/difference-between-left-and-right-outer-join-sql-mysql.html)
SELECT aluno.Nome
FROM aluno LEFT JOIN prof ON aluno.Nome = prof.Nome
WHERE prof.Nome IS NULL;
-- ou
SELECT nome FROM Aluno
WHERE nome NOT IN (SELECT Nome FROM Prof);

-- Exercicio 5
SELECT Nome
FROM prof
    UNION
SELECT Nome
FROM aluno;

-- Exercicio 6
SELECT DISTINCT aluno.Nome
FROM aluno
    INNER JOIN prova
        ON aluno.nr=prova.nr
WHERE prova.cod='TS1';

-- Exercicio 7
SELECT DISTINCT aluno.Nome
FROM aluno
    JOIN prova
        ON aluno.nr=prova.nr
    JOIN cadeira
        ON cadeira.cod=prova.cod
WHERE cadeira.curso='IS';

-- Exercicio 8
SELECT DISTINCT nome FROM Aluno
WHERE nr NOT IN
    (SELECT nr AS alunonr
    FROM Aluno, Cadeira
    WHERE curso='IS' AND NOT (cod IN
        (SELECT cod
        FROM Prova
        WHERE nota>=10 AND nr=alunonr)
        )
    );

-- Exercicio 9
SELECT MAX(prova.nota)
FROM prova;

-- Exercicio 10
SELECT AVG(prova.nota)
FROM prova
WHERE prova.cod='BD';

-- Exercicio 11
SELECT COUNT(aluno.nome)
FROM aluno;

-- Exercicio 12
SELECT cadeira.curso, count(*)
FROM cadeira
GROUP BY cadeira.curso;

-- Exercicio 13
SELECT aluno.Nome, count(*)
FROM aluno, prova
WHERE aluno.nr = prova.nr
GROUP BY aluno.Nome;

-- Exercicio 14
SELECT AVG(number) as avgProvasAluno
FROM (
     SELECT count(*) AS number
     FROM aluno, prova
     WHERE aluno.nr = prova.nr
     GROUP BY aluno.nr
);

-- Exercicio 15
SELECT Nome, avg(nota)
FROM (
    SELECT nr, max(nota) AS nota
    FROM prova GROUP BY nr, cod
)
NATURAL JOIN aluno
WHERE nota >= 10
GROUP BY nr;

-- Exercicio 16

