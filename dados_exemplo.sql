SET FOREIGN_KEY_CHECKS=0;

DELETE FROM musico_artista;
DELETE FROM papel_musical;
DELETE FROM habilitado;
DELETE FROM banda_artista;
DELETE FROM desempenha;

INSERT INTO musico_artista(id,nome,n_artistico,ano) #NO FOREIGN KEYS
VALUES (1,"Ana","Bacalhau",1998),
       (2,"Pedro","Alter",1956),
       (3,"Joao","Balas",1989),
       (4,"Quim","Joanetes",200);

INSERT INTO papel_musical(papel,descricao) # NO FOREIGN KEYS
VALUES ("guitarrista","guitarrista"),
       ("violinista","violinista"),
       ("baterista","baterista"),
       ("baixista","baixista"),
       ("vocalista","vocalista"),
       ("pianista","pianista");

INSERT INTO habilitado(musico,papel,nivel) #MUSICO = ID #PAPEL=PAPEL
VALUES (1,"guitarrista","P"),
       (2,"guitarrista","P"),
       (3,"pianista","A"),
       (4,"baterista","A");

INSERT INTO banda_artista(codigo,nome,tipo,ano) #NO FK
VALUES (6,"Amilcares","banda",1999),
       (3,"Ana","solo",2002),
       (1,"ToZé","banda",1967),
       (8,"Malandras","banda",1987);

INSERT INTO desempenha(banda_artista,musico,papel,cachet) #B_A=codigo #MUSICO,PAPEL
VALUES (6,1,"guitarrista",20),
       (6,3,"pianista",20),
       (1,2,"guitarrista",50),
       (8,4,"baterista",20);
SET FOREIGN_KEY_CHECKS=1;
