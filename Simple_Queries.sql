/*
1.
Indique por ordem alfabética ascendente o nome artistico de todos os músicos
que são guitarristas ou violinistas. Nota: pretende-se uma interrogação com
apenas um SELECT, ou seja, sem sub-interrogações.
*/
SELECT m.n_artistico
FROM musico_artista m, habilitado h
WHERE h.musico = m.id
AND (h.papel = 'guitarrista'
OR h.papel = 'violinista')
ORDER BY m.n_artistico ASC;

/*
2.
ID e nome artístico dos músicos que estão habilitados a pelo menos um dos
papeis: vocalista e coro, ou que tenham ‘a’ no nome e tenham começado a sua
actividade de músicos antes do ano do concerto Live Aid (1985). Nota: pode
usar construtores de conjuntos.
*/
SELECT m.id, m.n_artistico
FROM musico_artista m, habilitado h
WHERE m.id = h.musico
AND m.ano < 1985
AND (h.papel = 'coro'
    OR h.papel = 'vocalista'
    OR m.nome LIKE '%a%');

/*
3.
Nome das bandas (não solo) criadas depois do Live Aid que são formadas por,
pelo menos, um músico que iniciou atividade no ano deste concerto e tem um
nome artístico de 4 letras, começado por ‘L’ .
*/
SELECT b.nome
FROM banda_artista b, desempenha d
WHERE b.tipo = 'banda'
AND b.ano > 1985
AND EXISTS (SELECT m.id
            FROM musico_artista m
            WHERE m.ano = 1985
            AND m.n_artistico LIKE 'L___'
            AND m.id = d.musico
            AND d.banda_artista = b.codigo);

/*
4.
ID e nome dos músicos que iniciaram actividade depois do ano do movimento
hippie Summer of Love em S. Francisco (1967), e que nunca participaram em
bandas/artistas criadas depois do Live Aid.
*/
SELECT ma.id, ma.nome
FROM musico_artista ma, desempenha d, banda_artista ba
WHERE ma.id = d.musico
AND ba.codigo = d.banda_artista
AND ma.ano > 1967
AND NOT ba.ano > 1985

/*
5.
Nome, código, tipo e ano de criação das bandas/artistas que integrem músicos de
nível profissional em todos os papeis. Nota: o resultado deve vir ordenado pelo
ano e pelo nome de forma ascendente.
*/
SELECT DISTINCT ba.*
FROM desempenha d, banda_artista ba
WHERE NOT EXISTS (SELECT d.musico 
                 FROM desempenha d, habilitado h
                 WHERE h.nivel = "A"
                 AND d.musico = h.musico
                 AND d.banda_artista = ba.codigo)
ORDER BY ba.ano ASC, ba.nome ASC

/*
6.
Número de bandas/artistas integradas por cada músico, em cada papel. Nota:
ordene o resultado pelo ID e nome artístico do músico de forma ascendente, e
pelo papel de forma descendente.
*/
SELECT ma.id, ma.n_artistico, d.papel, COUNT(d.banda_artista)
FROM musico_artista ma, desempenha d
WHERE ma.id = d.musico
GROUP BY ma.id ASC, ma.n_artistico ASC, d.papel DESC

/*
7.
ID e nome artístico dos músicos que pertencem a mais bandas/artistas solo, em
cada papel. Notas: em caso de empate, devem ser mostrados todos os músicos
em causa.
*/
SELECT *
FROM (
SELECT ma.id, ma.n_artistico, d.papel, COUNT(d.banda_artista) AS bandas
FROM musico_artista ma, desempenha d
WHERE ma.id = d.musico
GROUP BY ma.id ASC, ma.n_artistico ASC, d.papel DESC) AS tabela2

/*
8.
Para cada ano de início de actividade, o ID e nome do músico que está habilitado
a desempenhar mais papeis. Listar também o número total de papeis para que
está habilitado, e o maior e menor cachet obtido no desempenho desses papeis.
Nota: em caso de empate do total de papeis, devem ser mostrados todos os
músicos em causa.
*/
SELECT id,nome,ano
FROM musico_artista
INNER JOIN (SELECT musico, count(*) as N FROM habilitado
GROUP BY ano,musico
ORDER BY N DESC LIMIT 1) as t ON (musico_artista.id = t.musico)	

/*
9.
ID e nome artístico dos músicos que iniciaram atividade depois do ano do Live
Aid e pertencem a menos de três bandas distintas, mesmo que não tenham
participado em nenhuma banda. Esta interrogação deve usar apenas um
SELECT, ou seja sem sub-interrogações.
*/
SELECT ma.id, ma.n_artistico
FROM desempenha d, musico_artista ma, banda_artista ba
WHERE d.musico = ma.id 
AND d.banda_artista = ba.codigo
AND ba.ano > 1985
GROUP BY ma.id, ma.n_artistico 
HAVING COUNT(DISTINCT ba.codigo) < 2
