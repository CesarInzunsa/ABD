--PRACTICA 2
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 03/03/22
--DESCRIPCION: Aprender a crear esquemas y tablas dentro de estos.

--CREAR BD
CREATE DATABASE siiTec
ON PRIMARY
(
	NAME = 'siiTec.MDF',
	FILENAME = 'C:\ABD2022\U3\siiTec.MDF'
)
LOG ON
(
NAME = 'siiTec.LDF',
FILENAME ='C:\ABD2022\U3\siiTec.LDF'
);

--PONER EN USO LA BD
USE siiTec;

--CREAR ESQUEMAS
CREATE SCHEMA alumnos;
CREATE SCHEMA rechum;
CREATE SCHEMA escolares;
CREATE SCHEMA maestros;
CREATE SCHEMA uvp;

--CREAR TABLAS EN EL ESQUEMA DE maestros
CREATE TABLE maestros.Maestro(
	idMaestro INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50)
);
CREATE TABLE maestros.Materia(
	idMateria INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50),
	hora TIME,
	inicioSemana DATE,
	finSemana DATE
);
CREATE TABLE maestros.MateriaMaestro(
	idMateriaMaestro INT IDENTITY PRIMARY KEY,
	idMateria INT REFERENCES maestros.Materia(idMateria),
	idMaestro INT REFERENCES maestros.Maestro(idMaestro)
);

--CREAR TABLAS EN EL ESQUEMA DE rechum
CREATE TABLE rechum.GestionNomina(
	idGestionNomina INT IDENTITY PRIMARY KEY,
	idMaestro INT REFERENCES maestros.Maestro(idMaestro),
	clabeInterbancaria SMALLINT,
	banco VARCHAR(30)
);
CREATE TABLE rechum.Asistencia(
	idAsistencia INT IDENTITY PRIMARY KEY,
	idMaestro INT REFERENCES maestros.Maestro(idMaestro),
	idMateria INT REFERENCES maestros.Materia(idMateria)
);
CREATE TABLE rechum.GestionPersonal(
	idGestionPersonal INT IDENTITY PRIMARY KEY,
	idMaestro INT REFERENCES maestros.Maestro(idMaestro),
	idAsistencia INT REFERENCES rechum.Asistencia(idAsistencia),
	notas VARCHAR(300),
	idGestionNomina INT REFERENCES rechum.GestionNomina(idGestionNomina)
);

--CREAR TABLAS EN EL ESQUEMA alumnos
CREATE TABLE alumnos.Carrera(
	idCarrera INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(60),
);
CREATE TABLE alumnos.Alumno(
	idAlumno INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50),
	apellido1 VARCHAR(50),
	apellido2 VARCHAR(50)
);
CREATE TABLE alumnos.CarreraAlumno(
	idCarreraAlumno INT IDENTITY PRIMARY KEY,
	fechaInicio DATE,
	fechaFin DATE,
	idCarrera INT REFERENCES alumnos.Carrera(idCarrera),
	idAlumno INT REFERENCES alumnos.Alumno(idAlumno)
);
CREATE TABLE alumnos.MateriaAlumno(
	idMateriaAlumno INT IDENTITY PRIMARY KEY,
	idMateria INT REFERENCES maestros.Materia(idMateria),
	idAlumno INT REFERENCES alumnos.Alumno(idAlumno)
);

--CREAR TABLAS EN EL ESQUEMA DE uvp UNIDAD DE VINCULACION Y POSGRADOS
CREATE TABLE uvp.ServicioSocial(
	idServicioSocial INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50),
	lugar VARCHAR(100),
	contacto VARCHAR(50),
	idCarrera INT REFERENCES alumnos.Carrera(idCarrera)
);
CREATE TABLE uvp.Residencia(
	idResidencias INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50),
	lugar VARCHAR(100),
	contacto VARCHAR(50),
	idCarrera INT REFERENCES alumnos.Carrera(idCarrera)
);
CREATE TABLE uvp.ServicioAlumno(
	idServicioAlumno INT IDENTITY PRIMARY KEY,
	fechaInicio DATE,
	fechaFin DATE,
	idServicioSocial INT REFERENCES uvp.ServicioSocial(idServicioSocial),
	IdAlumno INT REFERENCES alumnos.Alumno(idAlumno),
);
CREATE TABLE uvp.ResidenciaAlumno(
	idResidenciaAlumno INT IDENTITY PRIMARY KEY,
	fechaInicio DATE,
	fechaFin DATE,
	idResidencias INT REFERENCES uvp.Residencia(idResidencias),
	IdAlumno INT REFERENCES alumnos.Alumno(idAlumno)
);
CREATE TABLE uvp.TipoPosgrado(
	idTipoPosgrado INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(10)
);
CREATE TABLE uvp.Posgrado(
	idPosgrado INT IDENTITY PRIMARY KEY,
	idTipoPosgrado INT REFERENCES uvp.TipoPosgrado(idTipoPosgrado),
	idCarrera INT REFERENCES alumnos.Carrera(idCarrera)
);
CREATE TABLE uvp.PosgradoAlumno(
	idPosgradoAlumno INT IDENTITY PRIMARY KEY,
	fechaInicio DATE,
	fechaFin DATE,
	idPosgrado INT REFERENCES uvp.Posgrado(idPosgrado),
	idAlumno INT REFERENCES alumnos.Alumno(idAlumno),
	idServicioAlumno INT REFERENCES uvp.ServicioAlumno(idServicioAlumno),
	idResidenciaAlumno INT REFERENCES uvp.ResidenciaAlumno(idResidenciaAlumno)
);

--CREAR TABLAS EN EL ESQUEMA DE escolares
CREATE TABLE escolares.ExpedienteEscolar(
	idExpedienteEscolar INT IDENTITY PRIMARY KEY,
	idCarrera INT REFERENCES alumnos.Carrera(idCarrera),
	idAlumno INT REFERENCES alumnos.Alumno(idAlumno),
	idMateria INT REFERENCES maestros.Materia(idMateria),
	calObtenida FLOAT
);
CREATE TABLE escolares.Aula(
	idAula INT IDENTITY PRIMARY KEY,
	idMateria INT REFERENCES maestros.Materia(idMateria),
	capacidad SMALLINT
);

--INSERTAR DATOS EN:

--INSERTAR DATOS EN: ESQUEMA MAESTROS
INSERT INTO maestros.Maestro VALUES
('Juan','Ramon','Velasco'),
('Maria ','Nieves','Lorenzo'),
('Manuel','Alejandro','Muñoz'),
('Maria','Auxiliadora','Cubero'),
('Antonio','Jesus','Roman');

INSERT INTO maestros.Materia VALUES
('Lenguajes y Autonomas 1','19:00:00','Lunes','Viernes'),
('Administracion de Base de Datos','18:00:00','Lunes','Viernes'),
('Taller de Sistemas Operativos','20:00:00','Lunes','Jueves'),
('Redes de computadoras','17:00:00','Lunes','Viernes'),
('Lenguajes de Interfaz','14:00:00','Lunes','Viernes');

--INSERTAR DATOS EN: ESQUEMA ALUMNOS
INSERT INTO alumnos.Alumno VALUES
('Juan','Vicente','Cardenas'),
('Maria ','Isabel','Botella'),
('Juan','Carlos','Rebollo'),
('Silvia','Maria','Coll'),
('Jose','Javier','San Martin');

--INSERTAR DATOS EN: ESQUEMA uvp UNIDAD DE VINCULACION Y POSGRADOS
INSERT INTO uvp.TipoPosgrado VALUES
('Maestria'),
('Doctorado');

--INSERTAR DATOS EN: ESQUEMA ESCOLARES
INSERT INTO escolares.Aula VALUES
(1,30),
(2,24),
(3,41),
(4,33),
(5,31);

--INSERTAR DATOS EN: ESQUEMA RECHUM
INSERT INTO rechum.GestionNomina VALUES
(1, 047927026591306091, 'BBVA'),
(2, 009609538165421033, 'Citibanamex'),
(3, 481396441308457484, 'Santander'),
(4, 316414077214850943, 'BBVA'),
(5, 656258778847970019, 'BBVA');