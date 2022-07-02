--PRACTICA 4
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 17/03/22
--DESCRIPCION: Practicar la creación y el manejo de esquemas.


--1. CREACIÓN DE LA BD
CREATE DATABASE BDAHORCADO
ON PRIMARY
(
	NAME = 'BDAHORCADO.MDF',
	FILENAME = 'C:\ABD2022\U3\BDAHORCADO.MDF'
)
LOG ON
(
	NAME = 'BDAHORCADO.LDF',
	FILENAME ='C:\ABD2022\U3\BDAHORCADO.LDF'
);

--PONER EN USO LA BD
USE BDAHORCADO;

--2.  CREA UN INICIO DE SESION: sqlAhorcado.
CREATE LOGIN sqlAhorcado WITH PASSWORD = '12345';

--3.  CREAR EL ESQUEMA "reglasAhorcado".
CREATE SCHEMA reglasAhorcado;

--4.  CREAR UN USUARIO CON EL MISMO NOMBRE Y ASIGNALE EL LOGIN PONIENDOLE UN ESQUEMA POR DEFAULT LLAMADO "reglasAhorcado".
CREATE USER sqlAhorcado FOR LOGIN sqlAhorcado WITH DEFAULT_SCHEMA = reglasAhorcado;

--5.  DARLE PRIVILEGIOS AL USUARIO CON ROLES DE BASES DE DATOS:
--    db_ddladmin
--    db_datawriter
--    db_datareader
EXECUTE sp_addrolemember db_ddladmin, sqlAhorcado;
EXECUTE sp_addrolemember db_datawriter, sqlAhorcado;
EXECUTE sp_addrolemember db_datareader, sqlAhorcado;


--***************CON EL USUARIO sqlAhorcado*********************
--6.  INICIA SESION CON EL USUARIO CREADO.
USE BDAHORCADO;

--7.  CREA LAS TABLAS CON LLAVE PRIMARIA AUTOINCREMENTAL, PERO CON UNA PROYECCION DE RELACIONARLAS
--    (COMO SI FUERA UN JUEGO DE AHORCADO EL QUE SE ALMACENARA EN LA BD).
CREATE TABLE Categorias
(
	idCategoria INT IDENTITY PRIMARY KEY,
	nombreCategoria VARCHAR(50),
	dificultadCategoria VARCHAR(7) CHECK (dificultadCategoria IN ('Dificil', 'Medio', 'Facil'))
)
CREATE TABLE Jugadores
(
	idJugador INT IDENTITY PRIMARY KEY,
	nombreJugador VARCHAR(30),
	puntajeMaximo INT
);
CREATE TABLE Palabras
(
	idPalabra INT IDENTITY PRIMARY KEY,
	palabra VARCHAR(50),
	idCategoria INT
);
CREATE TABLE Resultados
(
	idResultado INT IDENTITY PRIMARY KEY,
	idJugador INT,
	idPalabra INT,
	resultado VARCHAR(6) CHECK (resultado IN ('Gano', 'Perdio'))
);

--8.  VERIFICA LA CREACION Y PON COMENTARIOS COMO TE QUEDARON.

--9.  CREA AL MENOS OTRO ESQUEMA Y DISTRIBUYE ENTRE LOS ESQUEMAS LAS TABLAS Y
--    APLICA LOS CONSTRAINTS DE FK QUE NECESITES.
CREATE SCHEMA Juego;
ALTER SCHEMA Juego TRANSFER reglasAhorcado.Jugadores;
ALTER SCHEMA Juego TRANSFER reglasAhorcado.Palabras;
ALTER SCHEMA Juego TRANSFER reglasAhorcado.Categorias;

ALTER TABLE Juego.Resultados
ADD CONSTRAINT jugador_resultados
FOREIGN KEY (idJugador)
REFERENCES Juego.Jugadores(idJugador);

ALTER TABLE Juego.Resultados
ADD CONSTRAINT palabras_resultados
FOREIGN KEY (idPalabra)
REFERENCES Juego.Palabras(idPalabra);

ALTER TABLE Juego.Palabras
ADD CONSTRAINT palabras_categoria
FOREIGN KEY (idCategoria)
REFERENCES Juego.Categorias(idCategoria);

--10. INSERTAR DATOS EN LAS TABLAS.
INSERT INTO Juego.Categorias VALUES
('Ciencia', 'Dificil'),
('Ciencia', 'Dificil'),
('Ciencia', 'Dificil'),
('Programacion', 'Dificil'),
('Calles', 'Facil'),
('Deporte', 'Facil');

INSERT INTO Juego.Jugadores VALUES 
('Cesar', 958),
('Juan', 1459),
('Diego', 8521),
('Rosa', 4259),
('Ana', 3896);

INSERT INTO Juego.Palabras VALUES
('Palindromo', 4),
('Aramara', 5),
('Gimnsaio', 6),
('Tecnologico', 4),
('Microsoft', 4),
('Juego', 1),
('SQLServer', 4),
('Azure', 4),
('Computadora', 4),
('Sistemas', 4);

INSERT INTO reglasAhorcado.Resultados VALUES
(1, 1, 'Gano'),
(2, 2, 'Perdio'),
(3, 3, 'Perdio'),
(4, 4, 'Perdio'),
(5, 5, 'Gano'),
(1, 6, 'Gano'),
(2, 7, 'Perdio'),
(3, 8, 'Gano'),
(4, 9, 'Perdio'),
(5, 10, 'Gano');

--11. MUESTRA LA INFORMACION DE LAS TABLAS EN UNA SOLA CONSULTA (CON INNER JOIN).
SELECT JJ.nombreJugador, JP.palabra, JC.nombreCategoria, RR.resultado FROM reglasAhorcado.Resultados RR
INNER JOIN Juego.Palabras JP ON (RR.idPalabra = JP.idPalabra)
INNER JOIN Juego.Jugadores JJ ON (RR.idJugador = JJ.idJugador)
INNER JOIN Juego.Categorias JC ON (JP.idCategoria = JC.idCategoria)
ORDER BY JP.palabra ASC;

--***************FIN USUARIO sqlAhorcado*********************