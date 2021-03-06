--PRACTICA 17
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 03/05/22
--DESCRIPCION: Practicar la importacin y exportacion de registros con BCP y el Wizard

--CREAR LA BD
CREATE DATABASE PRUEBASIMPEXP
ON PRIMARY
(
	NAME = 'PRUEBASIMPEXP',
	FILENAME = 'C:\ABD2022\U4\PRUEBASIMPEXP.MDF' 
)
LOG ON
(
	NAME = 'PRUEBASIMPEXP_LOG',
	FILENAME = 'C:\ABD2022\U4\PRUEBASIMPEXP.LDF' 
);

--PONER EN USO LA BD
USE PRUEBASIMPEXP;

--CREAR TABLA: DATOS
CREATE TABLE DATOS
(
NOMBRE VARCHAR(50),
APELLIDO VARCHAR(30),
FECHA_NACIMIENTO DATE
);

--INSETAR REGISTROS DEL GRUPO A EN LA TABLA DATOS
BULK INSERT DATOS
FROM 'C:\ABD2022\U4\DATOSGA.CSV'
WITH (FIELDTERMINATOR = ',');

--VERIFICAR QUE SE INSERTARON LOS REGISTROS
SELECT * FROM PRUEBASIMPEXP.DBO.DATOS;

--EXPORTAR REGISTROS DE LA TABLA DE DATOS CON EL BCP
--ESTE COMANDO ES EN EL CMD
--PARA EXPORTAR: BCP "SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE FECHA_NACIMIENTO BETWEEN '2001-08-01' AND '2001-12-31';" QUERYOUT "C:\ABD2022\U4\ALUMNOS_EXPORTAR.TXT" -c -T
SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE FECHA_NACIMIENTO BETWEEN '2001-08-01' AND '2001-12-31';

--INSERTA REGISTROS DEL GRUPO B A LA TABLA DE DATOS
--PARA IMPORTAR: BCP "PRUEBASIMPEXP.DBO.DATOS" IN "C:\ABD2022\U4\DATOSGB.TXT" -c -T -t "|"

--VERIFICAR QUE SE IMPORTARON LOS DATOS
SELECT * FROM DATOS;

--EXPORTAR DATOS DE LA TABLA PERO QUE EL NOMBRE O EL APELLIDO EMPIECE CON VOCAL; SEPARADOS CON ARROBA CON EL BCP
--COMANDO: BCP "SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE NOMBRE LIKE '[AEIOU]%' OR APELLIDO LIKE '[AEIOU]%'" QUERYOUT "C:\ABD2022\U4\DATOS.TXT" -c -T -t "@"
SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE NOMBRE LIKE '[AEIOU]%' OR APELLIDO LIKE '[AEIOU]%';

--IMPORTAR REGISTROS DEL GRUPO C CON EL WIZARD

---INSERTAR REGISTROS DE GRUPO D CON BULK INSERT, BCP Y ASISTENTE
BULK INSERT DATOS
FROM 'C:\ABD2022\U4\DATOS GD.CSV'
WITH (FIELDTERMINATOR = ',');
select * from PRUEBASIMPEXP.dbo.datos;
--CON EL BCP: BCP "PRUEBASIMPEXP.DBO.DATOS" IN "C:\ABD2022\U4\DATOS-GDtxt.TXT" -c -T -t "|"

--Exportar con BCP los alumnos cuyo apellido contenga 'ez' o su fecha de nacimiento
--sea en el 200 o su fecha de nacimiento sea de Octubre A noviembre del 2011
--CON EL BCP: BCP "SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE APELLIDO LIKE '%ez%' OR YEAR(FECHA_NACIMIENTO) = 2000 OR FECHA_NACIMIENTO BETWEEN '2001-10-01' AND '2001-11-30'" QUERYOUT "C:\ABD2022\U4\exportar\DATOS-2022-05-05.TXT" -c -T
SELECT * FROM PRUEBASIMPEXP.DBO.DATOS WHERE APELLIDO LIKE '%ez%' OR YEAR(FECHA_NACIMIENTO) = 2000 OR FECHA_NACIMIENTO BETWEEN '2001-10-01' AND '2001-11-30';

--EXPORTAR LOS REGISTROS DE LA TABLA DATOS PERO QUE SEA A UN ARCHIVO DE EXCEL CON EL WIZARD