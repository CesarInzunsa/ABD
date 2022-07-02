

USE AdventureWorks;

--REALIZAR PARTICION HORIZONTAL EN TRES ARCHIVOS DE LA TABLA Person.Addres DE
--AdventureWorks POR LA COLUMNA DE 'City‘ TOMANDO EL SIGUIENTE ORDEN
--Particion1 de A -> I
--Particion2 de J -> P
--Particion3 de Q -> ZSELECTOBJECT_NAME(IDX.object_id) AS [NOMBRE TABLA],IDX.name AS [Nom_Indice],idxps.index_type_desc AS [TIPO INDICE],idxps.avg_fragmentation_in_percent AS [PORCENTAJE DE FRAGMENTACION]FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) idxpsINNER JOIN sys.indexes IDX ON (idxps.object_id = IDX.object_id AND idxps.index_id = IDX.index_id)WHERE OBJECT_NAME(IDX.object_id) = '[Person].[Address]'ORDER BY [Nom_Indice];ALTER DATABASE AdventureWorksADD FILEGROUP Particion1;ALTER DATABASE AdventureWorksADD FILEGROUP Particion2;ALTER DATABASE AdventureWorksADD FILEGROUP Particion3;ALTER DATABASE AdventureWorksADD FILE(	NAME = 'Particion1.NDF',	FILENAME = 'C:\ABD2022\U3\Particion1.NDF')TO FILEGROUP Particion1;ALTER DATABASE AdventureWorksADD FILE(	NAME = 'Particion2.NDF',	FILENAME = 'C:\ABD2022\U3\Particion2.NDF')TO FILEGROUP Particion2;ALTER DATABASE AdventureWorksADD FILE (	NAME = 'Particion3.NDF',	FILENAME = 'C:\ABD2022\U3\Particion3.NDF')TO FILEGROUP Particion3;CREATE PARTITION FUNCTION F_ParticionByCity(NVARCHAR(30))AS RANGE RIGHT FOR VALUES ('J', 'Q');CREATE PARTITION SCHEME esquemaByCityAS PARTITION F_ParticionByCityTO (Particion1, Particion2, Particion3);ALTER TABLE ALTER TABLE Person.AddressDROP CONSTRAINT [PK_Address_AddressID]