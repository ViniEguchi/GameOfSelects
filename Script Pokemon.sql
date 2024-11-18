DROP DATABASE POKEMON;

CREATE DATABASE IF NOT EXISTS POKEMON;

USE POKEMON;

CREATE TABLE equipe (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    lider VARCHAR(45)
);

-- INSERT INTO equipe VALUES
-- 	();
    
CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45),
    cidade VARCHAR(45),
    numero INT
);

-- INSERT INTO endereco VALUES
--     ();

CREATE TABLE treinador (
    idTreinador INT PRIMARY KEY AUTO_INCREMENT,
    fkEndereco INT,
    fkEquipe INT,
    nome VARCHAR(45),
    dtNasc DATE,
    CONSTRAINT fkEnderecoTreinador FOREIGN KEY (fkEndereco)
        REFERENCES treinador (idTreinador),
    CONSTRAINT fkEquipeTreinador FOREIGN KEY (fkEquipe)
        REFERENCES equipe (idEquipe)
);

-- INSERT INTO treinador VALUES
--     ();

CREATE TABLE pokebola (
    idPokebola INT PRIMARY KEY AUTO_INCREMENT,
    fkTreinador INT,
    tipo VARCHAR(45),
    CONSTRAINT fkTreinadorPokebola FOREIGN KEY (fkTreinador)
        REFERENCES treinador (idTreinador)
);

-- INSERT INTO pokebola VALUES
--     ();

CREATE TABLE ataque (
    idAtaque INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    PP INT
);

-- INSERT INTO ataque VALUES
--     ();

CREATE TABLE pokemon (
    idPokemon INT PRIMARY KEY,
    fkPokebola INT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    nivel INT,
    CONSTRAINT fkPokebolaPokemon FOREIGN KEY (fkPokebola)
        REFERENCES pokebola (idPokebola)
);

-- INSERT INTO pokemon VALUES
--     ();

CREATE TABLE moveset (
    fkAtaque INT,
    fkPokemon INT,
    CONSTRAINT pkMoveset PRIMARY KEY (fkAtaque , fkPokemon),
    CONSTRAINT fkMovesetAtaque FOREIGN KEY (fkAtaque)
        REFERENCES ataque (idAtaque),
    CONSTRAINT fkMovesetPokemon FOREIGN KEY (fkPokemon)
        REFERENCES pokemon (idPokemon)
);

-- INSERT INTO moveset VALUES
-- 	();

CREATE TABLE ginasio (
    idGinasio INT PRIMARY KEY AUTO_INCREMENT,
    fkEndereco INT,
    tipo VARCHAR(45),
    lider VARCHAR(45),
    CONSTRAINT fkEnderecoGinasio FOREIGN KEY (fkEndereco)
        REFERENCES endereco (idEndereco)
);

-- INSERT INTO ginasio VALUES
--     ();

CREATE TABLE insignia (
    fkGinasio INT,
    fkTreinador INT,
    dtAquisicao DATE,
    CONSTRAINT pkInsignia PRIMARY KEY (fkGinasio , fkTreinador),
    CONSTRAINT fkGinasioInsignia FOREIGN KEY (fkGinasio)
        REFERENCES ginasio (idGinasio),
    CONSTRAINT fkTreinadorInsignia FOREIGN KEY (fkTreinador)
        REFERENCES treinador (idTreinador)
);

-- INSERT INTO insignia VALUES
--     ();

CREATE TABLE batalha (
    idBatalha INT AUTO_INCREMENT,
    fkGinasio INT,
    fkTreinador INT,
    vencedor VARCHAR(45),
    CONSTRAINT pkBatalha PRIMARY KEY (idBatalha , fkGinasio , fkTreinador),
    CONSTRAINT fkGinasioBatalha FOREIGN KEY (fkGinasio)
        REFERENCES ginasio (idGinasio),
    CONSTRAINT fkTreinadorBatalha FOREIGN KEY (fkTreinador)
        REFERENCES treinador (idTreinador),
    CONSTRAINT chkResultadoBatalha CHECK (vencedor IN ('ginasio' , 'treinador'))
);

-- INSERT INTO batalha VALUES
--     ();