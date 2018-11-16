
DROP TABLE IF EXISTS TemLugares;
DROP TABLE IF EXISTS TemZonas;
DROP TABLE IF EXISTS IncluiSalas;
DROP TABLE IF EXISTS Espaço;
DROP TABLE IF EXISTS Realizam;
DROP TABLE IF EXISTS FormatoConcerto;
DROP TABLE IF EXISTS Compram;


DROP TABLE IF EXISTS Beneficiam;
DROP TABLE IF EXISTS Patrocinam;
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

CREATE TABLE Organizacoes (
    nif NUMERIC(9) PRIMARY KEY,
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50),
    CHECK (nif > 0),
    CHECK (telefone > 0)
);

CREATE TABLE Causas (
    iban NUMERIC(23) PRIMARY KEY,
    objetivo VARCHAR(200),
    nome VARCHAR(20),
    CHECK (iban > 0)
);

CREATE TABLE OrganizacoesApoioSolidario (
    nif NUMERIC(9),
    iban NUMERIC(23) NOT NULL,
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50),
    montanteAngariado REAL(10000000),
    FOREIGN KEY (iban) REFERENCES Causas(iban) ON DELETE NO ACTION,
    FOREIGN KEY (nif) REFERENCES Organizações(nif) ON DELETE CASCADE,
    PRIMARY KEY (nif),
    CHECK (nif > 0),
    CHECK (iban > 0),
    CHECK (telefone > 0),
    CHECK (montanteAngariado >= 0)
);

CREATE TABLE OrganizacoesPatrocinadoras (
    nif NUMERIC(9),
    website VARCHAR(100),
    nome VARCHAR(50),
    redeSocial VARCHAR(50),
    email VARCHAR(50),
    telefone NUMERIC(9),
    morada VARCHAR(50),
    montanteAtribuido REAL(10000000),
    FOREIGN KEY (nif) REFERENCES Organizações ON DELETE CASCADE,
    PRIMARY KEY (nif),
    CHECK (nif > 0),
    CHECK (telefone > 0),
    CHECK (montanteAtribuido >= 0)
);

CREATE TABLE Espectadores (
    telemovel NUMERIC(9) PRIMARY KEY,
    email VARCHAR(50),
    nome VARCHAR (50),
    nif NUMERIC(9),
    descontoAcumulado NUMERIC(3),
    CHECK (telemovel > 0),
    CHECK (nif > 0)
);

CREATE TABLE Espaço (
  redesocialEs VARCHAR(50) UNIQUE,
  telefoneEs NUMERIC(9) UNIQUE,
  webesp VARCHAR(50) UNIQUE,
  emailEs VARCHAR(50) UNIQUE,
  nomeE VARCHAR(50) UNIQUE,
  codigoEs NUMERIC(5),
  horario TIME,   
  PRIMARY KEY (codigoEs),
  CHECK(codigoEs>0)
);

CREATE TABLE IncluiSalas (
  nomeS VARCHAR(50) UNIQUE,
  sigla VARCHAR(10) ,
  lotação NUMERIC(5) ,
  codigoEs NUMERIC(5),
  PRIMARY KEY(sigla,codigoEs) ,
  FOREIGN KEY(codigoEs) REFERENCES Espaço ON DELETE CASCADE,
  CHECK(lotacao>0)  
);
   
CREATE TABLE TemZonas (
  nomeZ VARCHAR(50),
  sigla VARCHAR(10),
  codigoEs NUMERIC(5),
  PRIMARY KEY(nomeZ,codigoEs,sigla),
  FOREIGN KEY(codigoEs) REFERENCES Espaço,
  FOREIGN KEY(sigla) REFERENCES IncluiSalas ON DELETE CASCADE,
  CHECK(codigoEs>0)
);

CREATE TABLE TemLugares (
 numeroLetra VARCHAR(50),
 nomeZ VARCHAR(50),
 sigla VARCHAR(10),
 codigoEs NUMERIC(5),
 PRIMARY KEY(nomeZ,numeroLetra,codigoEs,sigla),
 FOREIGN KEY(sigla) REFERENCES IncluiSalas,
 FOREIGN KEY(codigoEs) REFERENCES Espaço,
 FOREIGN KEY(nomeZ) REFERENCES TemZonas ON DELETE CASCADE,
 );
 
 CREATE TABLE FormatoConcerto (
  nomeF VARCHAR(50), 
  duracao TIME,
  sinopse VARCHAR(200),
  PRIMARY KEY(nomeF),
  CHECK(duracao>0)
);

CREATE TABLE Concerto (
  data TIMESTAMP,
  espaco VARCHAR(50),
  nomeConcerto VARCHAR(50),
  PRIMARY KEY (nomeConcerto, data),
  FOREIGN KEY (nomeConcerto) REFERENCES FormatoConcerto(nomeF) ON DELETE CASCADE
);

CREATE TABLE Comentarios (
    numeroSequencial INTEGER(10000000) PRIMARY KEY,
    data TIMESTAMP,
    likes INTEGER(10000000),
    dislikes INTEGER(10000000),
    data TIMESTAMP NOT NULL,
    nome VARCHAR(50) NOT NULL,
    telemovel NUMERIC(9) NOT NULL,
    FOREIGN KEY (data) REFERENCES Concerto ON DELETE NO ACTION,
    FOREIGN KEY (nome) REFERENCES FormatoConcerto ON DELETE NO ACTION,
    FOREIGN KEY (telemovel) REFERENCES Espectadores ON DELETE NO ACTION
    CHECK (numeroSequencial > 0),
    CHECK (likes >= 0),
    CHECK (dislikes >= 0),
    CHECK (telemovel > 0)
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

CREATE TABLE Beneficiam (
    data TIMESTAMP,
    nome VARCHAR(50),
    montanteAngariado REAL(10000000),
    nif NUMERIC(9),
    FOREIGN KEY (data) REFERENCES Concerto,
    FOREIGN KEY (nome) REFERENCES FormatoConcerto,
    FOREIGN KEY (montanteAngariado) REFERENCES OrganizacoesApoioSolidario,
    FOREIGN KEY (nif) REFERENCES Organizacoes,
    PRIMARY KEY (data, nome, montanteAngariado, nif),
    CHECK (montanteAngariado >= 0),
    CHECK (nif > 0)
);

CREATE TABLE Patrocinam (
    data TIMESTAMP,
    nome VARCHAR(50),
    montanteAtribuido REAL(10000000),
    nif NUMERIC(9),
    FOREIGN KEY (data) REFERENCES Concerto,
    FOREIGN KEY (nome) REFERENCES FormatoConcerto,
    FOREIGN KEY (montanteAtribuido) REFERENCES OrganizacoesPatrocinadoras,
    FOREIGN KEY (nif) REFERENCES Organizacoes,
    PRIMARY KEY (data, nome, montanteAtribuido, nif),
    CHECK (montanteAtribuido >= 0),
    CHECK (nif > 0)
);
    
CREATE TABLE Contribuem (
    iban NUMERIC (23),
    nif NUMERIC (9),
    montanteAngariado REAL(10000000),
    FOREIGN KEY (iban) REFERENCES Causas,
    FOREIGN KEY (nif) REFERENCES Organizacoes,
    FOREIGN KEY (montangeAngariado) REFERENCES OrganizacoesApoioSolidario,
    PRIMARY KEY (iban, nif, montanteAngariado),
    CHECK (iban > 0),
    CHECK (nif > 0),
    CHECK (montanteAngariado > 0)
);

CREATE TABLE SaoFeitos (
    data TIMESTAMP,
    nome VARCHAR(50),
    numeroSequencial INTEGER(10000000),
    FOREIGN KEY (data) REFERENCES Concerto,
    FOREIGN KEY (nome) REFERENCES FormatoConcerto,
    PRIMARY KEY (data, nome, numeroSequencial),
    CHECK (numeroSequencial > 0)
);    

CREATE TABLE RespondemA (
    originalNumeroSequencial INTEGER(10000000),
    respostaNumeroSequencial INTEGER(10000000),
    FOREIGN KEY (original_numeroSequencial) REFERENCES Comentarios,
    FOREIGN KEY (resposta_numeroSequencial) REFERENCES Comentarios,
    PRIMARY KEY (original_numeroSequencial, resposta_numeroSequencial),
    CHECK (originalNumeroSequencial > 0),
    CHECK (respostaNumeroSequencial > 1)
);

CREATE TABLE Partilham (
    telemovel NUMERIC(9),
    numeroSequencial INTEGER(10000000),
    FOREIGN KEY (telemovel) REFERENCES Espectadores,
    FOREIGN KEY (numeroSequencial) REFERENCES Comentarios,
    PRIMARY KEY (telemovel, numeroSequencial),
    CHECK (telemovel > 0),
    CHECK (numeroSequencial > 0)
);    

 CREATE TABLE Compram (
    nomeF VARCHAR(50),
    numeroLetra VARCHAR(50),
    nomeZ VARCHAR(50),
    sigla VARCHAR(10),
    codigoEs NUMERIC(5),
    preco INTEGER(3),
    telemovel NUMERIC(9) UNIQUE,
    PRIMARY KEY (nomeF,numeroLetra,nomeZ,sigla,codigoEs),
    PRIMARY KEY (nomeF) REFERENCES FormatoConcerto,
    FOREIGN KEY (numeroLetra) REFERENCES Lugares,
    FOREIGN KEY (nomeZ) REFERENCES Zonas,
    FOREIGN KEY (sigla) REFERENCES Salas,
    FOREIGN KEY (codigoEs) REFERENCES Espaço  ,
    FOREIGN KEY (telemovem) REFERENCES Espectadores,
    CHECK(preco>0)
);

CREATE TABLE Realizam (
  nomeF VARCHAR(50),
  sigla VARCHAR(10),
  codigoEs VARCHAR(50),
  PRIMARY KEY (codigoEs,nomeF,sigla),
  FOREIGN KEY (codigoEs) REFERENCES Espaço,
  FOREIGN KEY (nomeF) REFERENCES FormatoConcerto,
  FOREIGN KEY(siga) REFERENCES Salas
);


--as cenas do Gil começam aqui
    
"""CREATE TABLE FormatoConcerto (
  nomeF VARCHAR(50), 
  duracao TIME,
  sinopse VARCHAR(200),
  PRIMARY KEY(nomeF),
  CHECK(duracao>0)
);"""

CREATE TABLE Atuante (
  nome VARCHAR(20) PRIMARY KEY,
  codAgenciaRepresentante NUMERIC(4) NOT NULL,
  idArtista NUMERIC(4) NOT NULL,
  papel VARCHAR(50) NOT NULL,
  FOREIGN KEY (codAgenciaRepresentante) REFERENCES AgenciaRepresentante(codigo),
  FOREIGN KEY (idArtista) REFERENCES Artista(id),
  FOREIGN KEY (papel) REFERENCES Papel(designacao) ON DELETE NO ACTION
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
  FOREIGN KEY (formatoConcerto) REFERENCES FormatoConcerto(nomeF),
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
