
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


--tabelas do Gil
DROP TABLE IF EXISTS Desempenha;
DROP TABLE IF EXISTS TemCapacidade;
DROP TABLE IF EXISTS Representa;
DROP TABLE IF EXISTS Atua;
DROP TABLE IF EXISTS Solo;
DROP TABLE IF EXISTS Banda;
DROP TABLE IF EXISTS Atuante;
DROP TABLE IF EXISTS Concerto;
DROP TABLE IF EXISTS Papel;
DROP TABLE IF EXISTS AgenciaRepresentante;
DROP TABLE IF EXISTS Artista;
DROP TABLE IF EXISTS FormatoConcerto;

CREATE TABLE FormatoConcerto (
  nome VARCHAR(50) PRIMARY KEY,
  duracao TIME,
  sinopse VARCHAR(200)
);

CREATE TABLE Artista (
  id NUMERIC(4) PRIMARY KEY,
  nome VARCHAR(20),
  nomeArtistico VARCHAR(20) UNIQUE,
  CHECK (id > 0)
);

CREATE TABLE AgenciaRepresentante (
  codigo NUMERIC(4) PRIMARY KEY,
  nome VARCHAR(20),
  website VARCHAR(20) UNIQUE,
  email VARCHAR(20) UNIQUE,
  morada VARCHAR(100) UNIQUE,
  redeSocial VARCHAR(50) UNIQUE,
  telefone NUMERIC(9),
  CHECK (codigo > 0)
);

CREATE TABLE Papel (
  designacao VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Concerto (
  data TIMESTAMP,
  espaco VARCHAR(50),
  nomeConcerto VARCHAR(50),
  PRIMARY KEY (NomeConcerto, data),
  FOREIGN KEY (nomeConcerto) REFERENCES FormatoConcerto(nome) ON DELETE CASCADE
);

CREATE TABLE Atuante (
  nome VARCHAR(20) PRIMARY KEY ON DELETE CASCADE
);

CREATE TABLE Banda (
  nomeAtuante VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome)
);

CREATE TABLE Solo (
  nomeAtuante VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome)
);

CREATE TABLE Atua (
  nomeAtuante VARCHAR(20),
  ordem NUMERIC(1),
  cachet NUMERIC(3),
  formatoConcerto VARCHAR(50),
  CHECK (cachet > 0),
  CHECK (ordem > 0),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  FOREIGN KEY (formatoConcerto) REFERENCES FormatoConcerto(nome),
  PRIMARY KEY (nomeAtuante, formatoConcerto),
  CHECK (ordem > 0),
  CHECK (cachet > 0),
  CHECK (cachet < 101)DROP TABLE IF EXISTS Desempenha;
DROP TABLE IF EXISTS TemCapacidade;
DROP TABLE IF EXISTS Representa;
DROP TABLE IF EXISTS Atua;
DROP TABLE IF EXISTS Solo;
DROP TABLE IF EXISTS Banda;
DROP TABLE IF EXISTS Atuante;
DROP TABLE IF EXISTS Concerto;
DROP TABLE IF EXISTS Papel;
DROP TABLE IF EXISTS AgenciaRepresentante;
DROP TABLE IF EXISTS Artista;
DROP TABLE IF EXISTS FormatoConcerto;

CREATE TABLE FormatoConcerto (
  nome VARCHAR(50) PRIMARY KEY,
  duracao TIME,
  sinopse VARCHAR(200)
);

CREATE TABLE Artista (
  id NUMERIC(4) PRIMARY KEY,
  nome VARCHAR(20),
  nomeArtistico VARCHAR(20) UNIQUE,
  CHECK (id > 0)
);

CREATE TABLE AgenciaRepresentante (
  codigo NUMERIC(4) PRIMARY KEY,
  nome VARCHAR(20),
  website VARCHAR(20) UNIQUE,
  email VARCHAR(20) UNIQUE,
  morada VARCHAR(100) UNIQUE,
  redeSocial VARCHAR(50) UNIQUE,
  telefone NUMERIC(9),
  CHECK (codigo > 0)
);

CREATE TABLE Papel (
  designacao VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Concerto (
  data TIMESTAMP,
  espaco VARCHAR(50),
  nomeConcerto VARCHAR(50),
  PRIMARY KEY (NomeConcerto, data),
  FOREIGN KEY (nomeConcerto) REFERENCES FormatoConcerto(nome) ON DELETE CASCADE
);

CREATE TABLE Atuante (
  nome VARCHAR(20) PRIMARY KEY ON DELETE CASCADE
);

CREATE TABLE Banda (
  nomeAtuante VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome)
);

CREATE TABLE Solo (
  nomeAtuante VARCHAR(20) PRIMARY KEY,
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome)
);

CREATE TABLE Atua (
  nomeAtuante VARCHAR(20),
  ordem NUMERIC(1),
  cachet NUMERIC(3),
  formatoConcerto VARCHAR(50),
  CHECK (cachet > 0),
  CHECK (ordem > 0),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  FOREIGN KEY (formatoConcerto) REFERENCES FormatoConcerto(nome),
  PRIMARY KEY (nomeAtuante, formatoConcerto),
  CHECK (ordem > 0),
  CHECK (cachet > 0),
  CHECK (cachet < 101)
);

CREATE TABLE Representa (
  codigoAgencia NUMERIC(4),
  nomeAtuante VARCHAR(20),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  FOREIGN KEY (codigoAgencia) REFERENCES AgenciaRepresentante(codigo),
  PRIMARY KEY (codigoAgencia, nomeAtuante)
);

CREATE TABLE TemCapacidade (
  idArtista NUMERIC(4),
  designacaoPapel VARCHAR(50),
  FOREIGN KEY (idArtista) REFERENCES Artista(id),
  FOREIGN KEY (designacaoPapel) REFERENCES Papel(designacao),
  PRIMARY KEY (idArtista, designacaoPapel)
);

CREATE TABLE Desempenha (
  idArtista NUMERIC(4),
  designacaoPapel VARCHAR(50),
  nomeAtuante VARCHAR(20),
  cachet NUMERIC(3),
  FOREIGN KEY (idArtista) REFERENCES Artista(id),
  FOREIGN KEY (designacaoPapel) REFERENCES Papel(designacao),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  PRIMARY KEY (nomeAtuante, idArtista, designacaoPapel),
);

);

CREATE TABLE Representa (
  codigoAgencia NUMERIC(4),
  nomeAtuante VARCHAR(20),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  FOREIGN KEY (codigoAgencia) REFERENCES AgenciaRepresentante(codigo),
  PRIMARY KEY (codigoAgencia, nomeAtuante)
);

CREATE TABLE TemCapacidade (
  idArtista NUMERIC(4),
  designacaoPapel VARCHAR(50),
  FOREIGN KEY (idArtista) REFERENCES Artista(id),
  FOREIGN KEY (designacaoPapel) REFERENCES Papel(designacao),
  PRIMARY KEY (idArtista, designacaoPapel)
);

CREATE TABLE Desempenha (
  idArtista NUMERIC(4),
  designacaoPapel VARCHAR(50),
  nomeAtuante VARCHAR(20),
  cachet NUMERIC(3),
  FOREIGN KEY (idArtista) REFERENCES Artista(id),
  FOREIGN KEY (designacaoPapel) REFERENCES Papel(designacao),
  FOREIGN KEY (nomeAtuante) REFERENCES Atuante(nome),
  PRIMARY KEY (nomeAtuante, idArtista, designacaoPapel),
);

