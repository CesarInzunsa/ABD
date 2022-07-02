--PRACTICA 14
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 05/04/22
--DESCRIPCION: Aprender sobre la creacion de particiones verticales.

--CREAR LA BD
CREATE DATABASE ParticionVertical
ON PRIMARY
(
	NAME = 'ParticionVertical.MDF',	
	FILENAME = 'C:\ABD2022\U3\ParticionVertical.MDF'
)
LOG ON
(
	NAME = 'ParticionVertical.LDF',	
	FILENAME = 'C:\ABD2022\U3\ParticionVertical.LDF'
);

--PONER EN USO LA BD
USE ParticionVertical;

--CREAR LA TABLA DE EmployeeReports
CREATE TABLE EmployeeReports(
ReportID INT IDENTITY (1,1) NOT NULL,
ReportName VARCHAR (100),
ReportNumber VARCHAR(20),
ReportDescription VARCHAR(MAX)
CONSTRAINT PK_EReport PRIMARY KEY
clustered (ReportID)
)

--LLENAR LA TABLA CREADA CON 100,000 REGISTROS
DECLARE @i intSET @i = 1 BEGIN TRANWHILE @i<=100000 BEGININSERT INTO EmployeeReports(ReportName,ReportNumber,ReportDescription)VALUES('ReportName' + CONVERT (varchar (20), @i) ,CONVERT (varchar (20), @i),REPLICATE ('Report', 1000))SET @i=@i+1ENDCOMMIT TRANGO

--OBSERVAR EL TIEMPO QUE TARDA EN REALIZAR LA CONSULTA
SET STATISTICS IO ONSET STATISTICS TIME ONSELECT er.ReportID, er.ReportName, er.ReportNumberFROM dbo.EmployeeReports erWHERE er.ReportNumber LIKE '%33%'SET STATISTICS IO OFFSET STATISTICS TIME OFF

--CREAR LA TABLA DE ReportsDesc
CREATE TABLE ReportsDesc
(
ReportID INT REFERENCES EmployeeReports(ReportID),
ReportDescription VARCHAR (MAX)
CONSTRAINT PK_ReportDesc PRIMARY KEY CLUSTERED (ReportID)
);

--CREAR LA TABLA DE ReportsData
CREATE TABLE ReportsData(
ReportID INT NOT NULL,
ReportName VARCHAR(100),
ReportNumber VARCHAR(20)
CONSTRAINT DReport_PK PRIMARY KEY CLUSTERED (ReportID)
);

--INSERTAR EN LA TABLA DE ReportsData REGISTROS DE LA TABLA DE EmployeeRepots
INSERT INTO dbo.ReportsData
(
ReportID,
ReportName,
ReportNumber
)
SELECT er.ReportID, er.ReportName, er.ReportNumber FROM dbo.EmployeeReports er;

--INSERTAR REGISTROS EN ReportsDesc DE LA TABLA DE EmployeeReports
INSERT INTO dbo.ReportsDesc
(
ReportID,
ReportDescription
)
SELECT er.ReportID, er.ReportDescription FROM dbo.EmployeeReports er

--OBSERVAMOS EL TIEMPO QUE TARDA EN REALIZAR LA CONSULTA EN ReportsData
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT er.ReportID, er.ReportName,
er.ReportNumber
FROM ReportsData er
WHERE er.ReportNumber LIKE '%33%'
SET STATISTICS IO OFF
SET STATISTICS TIME OFF

--muestra el procetnaje de fragmentacion de los indices

---PORCENTAJE DE FRAGMENTACION EN ReportsData
SELECT OBJECT_NAME(idx.OBJECT_ID) AS [Nom_Tabla], 
idx.name AS [Nom_Indice],idxps.index_type_desc AS [Tipo_de_Indice], 
idxps.avg_fragmentation_in_percent AS [Porcentaje_Fragmentacion]
FROM sys.dm_db_index_physical_stats(DB_ID(), null, null, null, null) idxps 
INNER JOIN sys.indexes idx  ON idx.object_id = idxps.object_id  AND idx.index_id = idxps.index_id 
WHERE  OBJECT_NAME(IDX.OBJECT_ID)= 'ReportsData' 
ORDER BY [Nom_Indice];

---PORCENTAJE DE FRAGMENTACION EN ReportsDesc
SELECT OBJECT_NAME(idx.OBJECT_ID) AS [Nom_Tabla], 
idx.name AS [Nom_Indice],idxps.index_type_desc AS [Tipo_de_Indice], 
idxps.avg_fragmentation_in_percent AS [Porcentaje_Fragmentacion]
FROM sys.dm_db_index_physical_stats(DB_ID(), null, null, null, null) idxps 
INNER JOIN sys.indexes idx  ON idx.object_id = idxps.object_id  AND idx.index_id = idxps.index_id 
WHERE  OBJECT_NAME(IDX.OBJECT_ID)= 'ReportsDesc' 
ORDER BY [Nom_Indice];

---PORCENTAJE DE FRAGMENTACION EN EmployeeReports
SELECT OBJECT_NAME(idx.OBJECT_ID) AS [Nom_Tabla], 
idx.name AS [Nom_Indice],idxps.index_type_desc AS [Tipo_de_Indice], 
idxps.avg_fragmentation_in_percent AS [Porcentaje_Fragmentacion]
FROM sys.dm_db_index_physical_stats(DB_ID(), null, null, null, null) idxps 
INNER JOIN sys.indexes idx  ON idx.object_id = idxps.object_id  AND idx.index_id = idxps.index_id 
WHERE  OBJECT_NAME(IDX.OBJECT_ID)= 'EmployeeReports' 
ORDER BY [Nom_Indice];