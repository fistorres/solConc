"""DROP TABLE IF EXISTS desempenha;
DROP TABLE IF EXISTS temCapacidade;
DROP TABLE IF EXISTS representa;
DROP TABLE IF EXISTS integra;
DROP TABLE IF EXISTS solo;
DROP TABLE IF EXISTS banda;
DROP TABLE IF EXISTS atuante;
DROP TABLE IF EXISTS concerto;
DROP TABLE IF EXISTS papel;
DROP TABLE IF EXISTS agenciaRepresentante;
DROP TABLE IF EXISTS artista;"""


DROP TABLE IF EXISTS Compram;
DROP TABLE IF EXISTS Lugares;
DROP TABLE IF EXISTS TemLug;
DROP TABLE IF EXISTS Zonas;
DROP TABLE IF EXISTS Tem;
DROP TABLE IF EXISTS Salas;
DROP TABLE IF EXISTS Inclui;
DROP TABLE IF EXISTS Espaço;
DROP TABLE IF EXISTS Realizam;
DROP TABLE IF EXISTS FormatoConcerto;



CREATE TABLE FormatoConcerto (
  nomeF VARCHAR(50), 
  duracao TIME,
  sinopse VARCHAR(200),
  PRIMARY KEY(nomeF)
  
);

CREATE TABLE Realizam (
  nomeF VARCHAR(50),
  codigoEs VARCHAR(50),
  PRIMARY KEY (codigoEs,nomeF),
  FOREIGN KEY (codigoEs) REFERENCES Espaço,
  FOREIGN KEY (nomeF) REFERENCES FormatoConcerto
);


CREATE TABLE Espaço (
  redesocialEs VARCHAR(50) UNIQUE,
  telefoneEs NUMERIC(12) UNIQUE,
  webesp VARCHAR(50) UNIQUE,
  emailEs VARCHAR(50) UNIQUE,
  nomeE VARCHAR(50) UNIQUE,
  codigoEs NUMERIC(5),
  horario TIME,   
  PRIMARY KEY (codigoEs),
  CHECK(codigoEs>0)
  
);

CREATE TABLE Inclui (
 codigoEs VARCHAR(50),
 sigla VARCHAR(10),
 PRIMARY KEY(codigoEs,sigla),
 FOREIGN KEY(codigoEs) REFERENCES Espaço,
 FOREIGN KEY(sigla) REFERENCES Salas 
);

CREATE TABLE Salas (
  nomeS VARCHAR(50),
  sigla VARCHAR(10) ,
  lotação NUMERIC(5) ,
  codigoEs NUMERIC(5),
  PRIMARY KEY(sigla,codigoEs) REFERENCES Espaço ON DELETE CASCADE
  CHECK(lotação>0),
  CHECK(codigoEs>0),
  );


CREATE TABLE Tem (
  sigla VARCHAR(50),
  nomeZ VARCHAR(50),
  PRIMARY KEY(sigla,nomeZ)
  FOREIGN KEY(sigla) REFERENCES Salas
  FOREIGN KEY(nomeZ) REFERENCES Zonas
);

CREATE TABLE Zonas (
  nomeZ VARCHAR(50),
  codigoEs NUMERIC(5),
  PRIMARY KEY(nome,codigoEs),
  FOREIGN KEY(codigoEs) REFERENCES Salas ON DELETE CASCADE
);

CREATE TABLE TemLug (
 nomeZ VARCHAR(50),
 numeroLetra VARCHAR(50),
 PRIMARY KEY(nomeZ,numeroLetra)
 FOREIGN KEY(nomeZ) REFERENCES Zonas
 FOREIGN KEY(numeroLetra) REFERENCES Lugares
);

CREATE TABLE Lugares (
 nomeZ VARCHAR(50),
 numeroLetra VARCHAR(50),
 codigoEsEs NUMERIC(5),
 PRIMARY KEY(nomeZ,numeroLetra,codigoEs),
 FOREIGN KEY(nomeZ,codigoEs) REFERENCES Zonas ON DELETE CASCADE
 );


CREATE TABLE Compram (
 telemovelEsp NUMERIC(12),
 preço NUMERIC(3),
 numeroLetra VARCHAR(50),
 nomeF VARCHAR(50),
 PRIMARY KEY(numeroLetra,nomeF,telemovelEsp)
 FOREIGN KEY(nomeF) REFERENCES FormatoConcerto
 FOREIGN KEY(numeroLetra) REFERENCES Lugares
 FOREIGN KEY(telemovelEsp) REFERENCES Espectadores

);

