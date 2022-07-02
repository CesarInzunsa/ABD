--PRACTICA 9
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 28/03/22
--DESCRIPCION: Aprender a crear particiones


--CREACIÓN DE LA BD
CREATE DATABASE BDParticiones
ON PRIMARY
(
	NAME = 'BDParticiones.MDF',
	FILENAME = 'C:\ABD2022\U3\BDParticiones.MDF'
)
LOG ON
(
	NAME = 'BDParticiones.LDF',
	FILENAME = 'C:\ABD2022\U3\BDParticiones.LDF'
);

--PONER EN USO LA BD
USE BDParticiones;

--CREAR TABLA DE REPORTES
CREATE TABLE Reports(
	idReport INT IDENTITY (1,1) PRIMARY KEY,
	ReportDate DATE NOT NULL DEFAULT GETDATE(),
	ReportName VARCHAR(100),
	ReportNumber VARCHAR(20),
	ReportDeScription VARCHAR(MAX)
);

--LLENAR LA TABLA DE REPORTES
DECLARE @i int
DECLARE @fecha date
SET @i = 1

BEGIN TRAN
WHILE @i<=120000
BEGIN 
  IF @i between 1 and 10000
     SET @fecha = '2018/01/15'
  IF @i between 10001 and 25000
     SET @fecha = '2018/03/15'
  IF @i between 25001 and 28000
     SET @fecha = '2018/04/15'
  IF @i between 28001 and 29500
     SET @fecha = '2018/03/15'
  IF @i between 29501 and 31000
     SET @fecha = '2019/02/15'
  IF @i between 31001 and 32000
     SET @fecha = '2019/03/15'
  IF @i between 32001 and 35000
     SET @fecha = '2019/04/15'
  IF @i between 35001 and 42500
     SET @fecha = '2019/05/15'
  IF @i between 42501 and 45000
     SET @fecha = '2019/06/15'
  IF @i between 45001 and 47500
     SET @fecha = '2019/07/15'
  IF @i between 47501 and 52500
     SET @fecha = '2019/08/15'
  IF @i between 52501 and 55000
     SET @fecha = '2019/09/15'
  IF @i between 55001 and 60000
     SET @fecha = '2019/10/15'
  IF @i between 60001 and 62475
     SET @fecha = '2019/11/15'
  IF @i between 62476 and 65345
     SET @fecha = '2019/12/15'
IF @i between 65346 and 66000
     SET @fecha = '2020/01/15'
  IF @i between 66001 and 67000
     SET @fecha = '2020/02/15'
  IF @i between 67001 and 68000
     SET @fecha = '2020/03/15' 
  IF @i between 68001 and 69000
     SET @fecha = '2020/04/15'  
  IF @i between 69001 and 70000
     SET @fecha = '2020/05/15' 
  IF @i between 70001 and 70500
     SET @fecha = '2020/06/15'
  IF @i between 70500 and 72000
     SET @fecha = '2020/07/15' 
  IF @i between 72001 and 73000
     SET @fecha = '2020/08/15'  
  IF @i between 73001 and 73800
     SET @fecha = '2020/09/15' 
  IF @i between 73801 and 73950
     SET @fecha = '2020/10/15' 
  IF @i between 73951 and 75700
     SET @fecha = '2020/11/15' 
  IF @i between 75701 and 75802
     SET @fecha = '2021/12/15' 
  IF @i between 75803 and 80000
     SET @fecha = '2021/01/15' 
  IF @i between 80001 and 90000
     SET @fecha = '2021/02/15' 
  IF @i between 90001 and 100000
     SET @fecha = '2021/03/15' 
  IF @i between 100001 and 110000
     SET @fecha = '2022/01/15' 
  IF @i between 110001 and 120000
     SET @fecha = '2022/02/15' 

  INSERT INTO Reports
  (
   ReportDate,
   ReportName,
   ReportNumber,
   ReportDescription
  )
  VALUES
  (
   @fecha,
   'ReportName' + CONVERT (varchar (20), @i) ,
   CONVERT (varchar (20), @i),
   REPLICATE ('Report', 1000)
  )
  SET @i=@i+1
 END
COMMIT TRAN
GO

--CONTAR LOS REGISTROS EN LA TABLA DE REPORTES: HAY 120,000.
SELECT COUNT(*) FROM Reports;


--PASO 1: CREAR LOS FILEGROUP
ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2018;

ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2019;

ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2020;

ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2021;

ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2022;

--PASO 2: CREAR LOS ARCHIVOS NDF
ALTER DATABASE BDParticiones
ADD FILE
(
	NAME = 'Particiones2018.NDF',
	FILENAME = 'C:\ABD2022\U3\DISCO1\Particion2018.NDF'
)
TO FILEGROUP Histo2018;

ALTER DATABASE BDParticiones
ADD FILE
(
	NAME = 'Particiones2019.NDF',
	FILENAME = 'C:\ABD2022\U3\DISCO2\Particion2019.NDF'
)
TO FILEGROUP Histo2019;

ALTER DATABASE BDParticiones
ADD FILE
(
	NAME = 'Particiones2020.NDF',
	FILENAME = 'C:\ABD2022\U3\DISCO3\Particion2020.NDF'
)
TO FILEGROUP Histo2020;

ALTER DATABASE BDParticiones
ADD FILE
(
	NAME = 'Particiones2021.NDF',
	FILENAME = 'C:\ABD2022\U3\DISCO4\Particion2021NDF'
)
TO FILEGROUP Histo2021;

ALTER DATABASE BDParticiones
ADD FILE
(
	NAME = 'Particiones2022.NDF',
	FILENAME = 'C:\ABD2022\U3\DISCO5\Particion2022.NDF'
)
TO FILEGROUP Histo2022;


--PASO 3: CREAR LA FUNCION DE PARTICION
CREATE PARTITION FUNCTION F_PartitionByAnio(DATE)
AS RANGE LEFT FOR VALUES ('2018-12-31', '2019-12-31', '2020-12-31');

--PASO 4: CREAR EL ESQUEMA DE PARTICION
CREATE PARTITION SCHEME EsquemaByAnio
As PARTITION F_PartitionByAnio
TO (Histo2018, Histo2019, Histo2020, Histo2021, Histo2022);

--PASO 5: CREAR TABLA DE REPORTES 2
CREATE TABLE Reports_Particionada(
	idReport INT PRIMARY KEY NONCLUSTERED,
	ReportDate DATE NOT NULL DEFAULT GETDATE(),
	ReportName VARCHAR(100),
	ReportNumber VARCHAR(20),
	ReportDeScription VARCHAR(MAX)
);

--CREAR INDEX CLUSTERED
CREATE CLUSTERED INDEX IDX_RepPart
ON Reports_Particionada (ReportDate)
ON EsquemaByAnio (ReportDate);

--OBSERVAR EL TIEMPO QUE TARDA EN REALIZAR UNA CONSULTA: 34 SEGUNDOS
SELECT * FROM Reports WHERE YEAR(ReportDate) = '2019';

--VACIAR REGISTROS EN LA TABLA NUEVA Y VERIFICAR
INSERT INTO Reports_Particionada SELECT * FROM Reports;
SELECT COUNT(*) FROM Reports_Particionada;

--OBSERVAR VELOCIDAD DE CONSULTA: 18 SEGUNDOS
SELECT * FROM Reports_Particionada WHERE YEAR(ReportDate) = '2019';

--BORRAR TABLA DE REPORTES (ANTIGUA)
DROP TABLE Reports;

--CAMBIAR EL NOMBRE A LA TABLA NUEVA POR LA DE REPORTES
EXEC sp_rename 'Reports_Particionada', 'Reports';

--VERIFICAR LAS PARTICIONES
SELECT p.partition_number AS Num_Particion, f.name AS Nombre, p.rows AS ColumnasFROM sys.partitions pJOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_idJOIN sys.filegroups f ON dds.data_space_id = f.data_space_idWHERE OBJECT_NAME(OBJECT_ID) = 'Reports'AND p.index_id = 1-- CONSULTAR TODA LA TABLA
SELECT * FROM Reports
-- MOSTRAR LOS REGISTROS DE CADA PARTICION
-- SE USA EL NOMBRE DE LA FUNCION DE PARTICION
-- Y EL NOMBRE DEL CAMPO QUE USAMOS PARA 
-- PARTICIONAR
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=1;
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=2;
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=3;
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=4;

-- otra forma de hacerlo
SELECT * FROM Reports
WHERE Year(ReportDate) = '2018'

--Cuantos registros tiene cada aparticion
SELECT Prt.partition_number AS Num_Particion,
fg.name AS Nombre, Prt.rows AS Columnas
FROM sys.partitions Prt
JOIN sys.destination_data_spaces dds
ON Prt.partition_number = dds.destination_id
JOIN sys.filegroups fg ON dds.data_space_id =
fg.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'
AND Prt.index_id = 1;

--FileGroup
SELECT name AS NombresFilegroups
FROM sys.filegroups
WHERE type = 'FG';

--DataFiles
SELECT
name as [FileName], physical_name as [FilePath] 
FROM sys.database_files
where type_desc = 'ROWS';