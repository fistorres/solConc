
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

DROP TABLE IF EXISTS Contribuem;
DROP TABLE IF EXISTS SaoFeitos;
DROP TABLE IF EXISTS RespondemA;
DROP TABLE IF EXISTS Partilham;
DROP TABLE IF EXISTS Compram;
DROP TABLE IF EXISTS Organizacoes;
DROP TABLE IF EXISTS OrganizacoesApoioSolidario;
DROP TABLE IF EXISTS OrganizacoesPatrocinadoras;
DROP TABLE IF EXISTS Causas;
DROP TABLE IF EXISTS Comentarios;
DROP TABLE IF EXISTS Espectadores;

CREATE TABLE Espectadores (
    telemovel NUMERIC(9) PRIMARY KEY,
    email VARCHAR(50),
    nome VARCHAR (50),
    nif NUMERIC(9)
    descontoAcumulado NUMERIC(3)
);

CREATE TABLE Comentarios (
    numeroSequencial INTEGER(10000000) PRIMARY KEY,
    data TIMESTAMP,
    likes INTEGER(10000000)
    dislike INTEGER(10000000)
);

CREATE TABLE Causas (
    iban NUMERIC(23) PRIMARY KEY,
    objetivo VARCHAR(200),
    nome VARCHAR(20)
);

CREATE TABLE OrganizacoesPatrocinadoras (
    nif NUMERIC(9),
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50)
    montanteAtribuido REAL(10000)
    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES Organizações ON DELETE CASCADE
);

CREATE TABLE OrganizacoesApoioSolidario (
    nif NUMERIC(9),
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50)
    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES Organizações ON DELETE CASCADE
);

CREATE TABLE Organizacoes (
    nif NUMERIC(9) PRIMARY KEY,
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50)
);

CREATE TABLE SaoFeitos (
    data 

CREATE TABLE RespondemA (
    original_numeroSequencial INTEGER INTEGER(10000000)
    resposta_numeroSequencial INTEGER(10000000)
    PRIMARY KEY (original_numeroSequencial, resposta_numeroSequencial)
    FOREIGN KEY (original_numeroSequencial) REFERENCES Comentarios
    FOREIGN KEY (resposta_numeroSequencial) REFERENCES Comentarios
);

CREATE TABLE Partilham (
    telemovel NUMERIC(9),
    numeroSequencial INTEGER(10000000)
    PRIMARY KEY (telemovel, numeroSequencial)
    FOREIGN KEY (telemove) REFERENCES Espectadores
    FOREIGN KEY (numeroSequencial) REFERENCES Comentarios
);    

CREATE TABLE Compram (
    nome VARCHAR(50),
    numeroLetra VARCHAR(50),
    telemovel NUMERIC(9),
    preço INTEGER(3)
    PRIMARY KEY (nome, numeroLetra),
    FOREIGN KEY (nome) REFERENCES FormatoConcerto
    FOREIGN KEY (numeroLetra) REFERENCES LUGARES
    FOREIGN KEY (telemovel) REFERENCES Espectadores
);

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

