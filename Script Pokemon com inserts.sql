DROP DATABASE POKEMON;

CREATE DATABASE IF NOT EXISTS POKEMON;

USE POKEMON;

CREATE TABLE equipe (
    idEquipe INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    lider VARCHAR(45)
);

 INSERT INTO equipe (nome, lider) VALUES 
('Rocket', 'Giovanni'),
('Aqua', 'Archie'),
('Magma', 'Maxie'),
('Galáxia', 'Cynthia'),
('CBSAFE', 'Aoki');

select * from equipe;

    
CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45),
    cidade VARCHAR(45),
    numero INT
)auto_increment = 10;


INSERT INTO endereco (logradouro, cidade, numero) VALUES
('Rua dos Rattatas', 'Pallet Town', 1),
('Avenida Cerulean', 'Cerulean City', 25),
('Rua da Vitória', 'Vermilion City', 15),
('Avenida Indigo', 'Indigo Plateau', 100),
('Rua de Saffron', 'Saffron City', 200),
('Rua do Lago', 'Goldenrod City', 50),
('Rua do Desafio', 'Lavender Town', 12),
('Avenida do Centro', 'Celadon City', 18),
('Rua da Professora', 'Eterna City', 33),
('Rua do Safari', 'Fuchsia City', 45);

select * from endereco;

CREATE TABLE treinador (
    idTreinador INT PRIMARY KEY AUTO_INCREMENT,
    fkEndereco INT,
    fkEquipe INT,
    nome VARCHAR(45),
    dtNasc DATE,
    CONSTRAINT fkEnderecoTreinador FOREIGN KEY (fkEndereco)
        REFERENCES endereco (idEndereco),
    CONSTRAINT fkEquipeTreinador FOREIGN KEY (fkEquipe)
        REFERENCES equipe (idEquipe)
) auto_increment = 21;

INSERT INTO treinador (fkEndereco, fkEquipe, nome, dtNasc) VALUES
(15, 1, 'Ash Ketchum', '1990-05-22'),
(16, 2, 'Misty', '1992-08-12'),
(17, 3, 'Brock', '1991-04-07'),
(18, 4, 'Xinforinvola', '1985-03-14'),
(19, 5, 'Epaminondas', '1986-07-14');

select * from treinador;

CREATE TABLE pokebola (
    idPokebola INT PRIMARY KEY AUTO_INCREMENT,
    fkTreinador INT,
    tipo VARCHAR(45),
    CONSTRAINT fkTreinadorPokebola FOREIGN KEY (fkTreinador)
        REFERENCES treinador (idTreinador)
);

INSERT INTO pokebola (fkTreinador, tipo) VALUES
(21, 'Pokébola'),        
(22, 'Great Ball'),      
(23, 'Ultra Ball'),      
(24, 'Master Ball'),    
(25, 'Safari Ball'); 

select * from pokebola;

CREATE TABLE ataque (
    idAtaque INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    PP INT
);

INSERT INTO ataque (nome, tipo, PP) VALUES
('Thunderbolt', 'Elétrico', 15),
('Flamethrower', 'Fogo', 15),
('Earthquake', 'Terrestre', 10),
('Surf', 'Água', 15),
('Psychic', 'Psíquico', 10);

select * from ataque;

CREATE TABLE pokemon (
    idPokemon INT PRIMARY KEY,
    fkPokebola INT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    nivel INT,
    CONSTRAINT fkPokebolaPokemon FOREIGN KEY (fkPokebola)
        REFERENCES pokebola (idPokebola)
);

INSERT INTO pokemon (idPokemon, fkPokebola, nome, tipo, nivel) VALUES
(1, 1, 'Pikachu', 'Elétrico', 25),
(2, 2, 'Charizard', 'Fogo/Voador', 36),
(3, 3, 'Bulbasaur', 'Grama/Veneno', 5),
(4, 4, 'Squirtle', 'Água', 5),
(5, 5, 'Alakazam', 'Psíquico', 45);

select * from pokemon;

CREATE TABLE moveset (
    fkAtaque INT,
    fkPokemon INT,
    CONSTRAINT pkMoveset PRIMARY KEY (fkAtaque , fkPokemon),
    CONSTRAINT fkMovesetAtaque FOREIGN KEY (fkAtaque)
        REFERENCES ataque (idAtaque),
    CONSTRAINT fkMovesetPokemon FOREIGN KEY (fkPokemon)
        REFERENCES pokemon (idPokemon)
);

INSERT INTO moveset (fkAtaque, fkPokemon) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

CREATE TABLE ginasio (
    idGinasio INT PRIMARY KEY AUTO_INCREMENT,
    fkEndereco INT,
    tipo VARCHAR(45),
    lider VARCHAR(45),
    CONSTRAINT fkEnderecoGinasio FOREIGN KEY (fkEndereco)
        REFERENCES endereco (idEndereco)
);

INSERT INTO ginasio (fkEndereco, tipo, lider) VALUES
(10, 'Normal', 'Brock'),
(11, 'Água', 'Misty'),
(12, 'Elétrico', 'Lt. Surge'),
(13, 'Psíquico', 'Sabrina'),
(14, 'Fogo', 'Blaine');

select * from ginasio;


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

INSERT INTO insignia (fkGinasio, fkTreinador, dtAquisicao) VALUES
(1, 21, '1996-06-15'),
(2, 22, '1996-06-20'),
(3, 23, '1996-06-25'),
(4, 24, '1996-07-05'),
(5, 24, '1996-07-10');


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
)auto_increment = 100;

INSERT INTO batalha (fkGinasio, fkTreinador, vencedor) VALUES
(1, 21, 'treinador'),
(2, 22, 'treinador'),
(3, 23, 'ginasio'),
(4, 24, 'treinador'),
(5, 25, 'treinador');
