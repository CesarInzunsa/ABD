--PRACTICA 11
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 30/03/22
--DESCRIPCION: Practicar la creacion de particiones horizontales

--PONER EN USO LA BD
use NorthwindParticiones;

--ACTUALIZAR LAS FECHAS DE LA TABLA ORDERS
UPDATE Orders setOrderDate = DATEADD(YEAR, 24, OrderDATE),shippedDate = DATEADD(YEAR, 24, shippedDate),RequiredDate = DATEADD(YEAR, 24, RequiredDate);--PASO 1: CREAR LOS FILEGROUPALTER DATABASE NorthwindParticiones ADD FILEGROUP Primera;ALTER DATABASE NorthwindParticiones ADD FILEGROUP Segunda;ALTER DATABASE NorthwindParticiones ADD FILEGROUP Tercera;ALTER DATABASE NorthwindParticiones ADD FILEGROUP Cuarta;ALTER DATABASE NorthwindParticiones ADD FILEGROUP Quinta;ALTER DATABASE NorthwindParticiones ADD FILEGROUP Seta;--PASO 2: CREAR LOS ARCHIVOS NDFALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Primera.NDF',
	FILENAME ='C:\ABD2022\U3\Disco1\Primera.NDF'
)
TO FILEGROUP Primera;

ALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Segunda.NDF',
	FILENAME ='C:\ABD2022\U3\Disco2\Segunda.NDF'
)
TO FILEGROUP Segunda;

ALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Tercera.NDF',
	FILENAME ='C:\ABD2022\U3\Disco3\Tercera.NDF'
)
TO FILEGROUP Tercera;

ALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Cuarta.NDF',
	FILENAME ='C:\ABD2022\U3\Disco4\Cuarta.NDF'
)
TO FILEGROUP Cuarta;

ALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Quinta.NDF',
	FILENAME ='C:\ABD2022\U3\Disco5\Quinta.NDF'
)
TO FILEGROUP Quinta;

ALTER DATABASE NorthwindParticiones
ADD FILE(
	NAME = 'Seta.NDF',
	FILENAME ='C:\ABD2022\U3\Disco6\Seta.NDF'
)
TO FILEGROUP Seta;

--PASO 3: CREAR LA FUNCION DE PARTICION
CREATE PARTITION FUNCTION F_PartitionById(INT)
AS RANGE RIGHT FOR VALUES
(
10301,
10501,
10701,
10901,
11101
);

--PASO 4: CREAR EL ESQUEMA DE PARTICION
CREATE PARTITION SCHEME EsquemaById
As PARTITION F_PartitionById
TO (Primera, Segunda, Tercera, Cuarta, Quinta, Seta);

--ELIMINAR LAS LLAVES FORANEAS EN ORDERS Y ORDER DETAILS
ALTER TABLE [Order Details] DROP CONSTRAINT [FK_Order_Details_Orders];
ALTER TABLE Orders DROP CONSTRAINT [PK_Orders];

--CREAR LLAVE PRIMARI NO CLUSTERED EN ORDER
ALTER TABLE Orders ADD CONSTRAINT pk_Order PRIMARY KEY NONCLUSTERED (OrderId);

--CREAR INDEX CLUSTERED
CREATE CLUSTERED INDEX IDX_OrderId
ON Orders(OrderId)
ON EsquemaById(OrderId);

--CREAR LLAVE FORANEA EN ORDER DETAILS CON ORDER
ALTER TABLE [Order Details]
ADD CONSTRAINT FK_Order_Details_Orders
FOREIGN KEY (OrderId)
REFERENCEs Orders(OrderId);


--LLENAR LA TABLA DE ORDER CON 50 REGISTROS
DECLARE @i int
DECLARE @CustomerID VARCHAR(5)
DECLARE @EmployeeID INT
DECLARE @ShipVia INT
DECLARE @OrderDate DATETIME
DECLARE @RequiredDate DATETIME
DECLARE @ShippedDate DATETIME
SET @i = 1

BEGIN TRAN
WHILE @i<=50
BEGIN 
  IF @i between 1 and 10
	 SET @CustomerID = 'VINET'
	 SET @EmployeeID = (RAND() * (5 - 1)) + 1
	 SET @ShipVia = (RAND() * (3 - 1)) + 1
     SET @OrderDate = '2020/01/05'
	 SET @RequiredDate = '2020/05/05' 
     SET @ShippedDate = '2020/03/10'
  IF @i between 11 and 20
     SET @CustomerID = 'TOMSP'
	 SET @EmployeeID = (RAND() * (5 - 1)) + 1
	 SET @ShipVia = (RAND() * (3 - 1)) + 1
     SET @OrderDate = '2020/01/10'
	 SET @RequiredDate = '2020/02/05' 
     SET @ShippedDate = '2020/01/10'
  IF @i between 21 and 30
     SET @CustomerID = 'HANAR'
	 SET @EmployeeID = (RAND() * (5 - 1)) + 1
	 SET @ShipVia = (RAND() * (3 - 1)) + 1
     SET @OrderDate = '2020/01/15'
	 SET @RequiredDate = '2020/06/15' 
     SET @ShippedDate = '2020/05/15'
  IF @i between 31 and 40
     SET @CustomerID = 'CHOPS'
	 SET @EmployeeID = (RAND() * (5 - 1)) + 1
	 SET @ShipVia = (RAND() * (3 - 1)) + 1
     SET @OrderDate = '2020/01/20'
	 SET @RequiredDate = '2020/01/21' 
     SET @ShippedDate = '2020/01/19'
  IF @i between 41 and 50
  SET @CustomerID = 'RICSU'
	 SET @EmployeeID = (RAND() * (5 - 1)) + 1
	 SET @ShipVia = (RAND() * (3 - 1)) + 1
     SET @OrderDate = '2020/01/30'
	 SET @RequiredDate = '2020/03/30' 
     SET @ShippedDate = '2020/03/25'
	 
  INSERT INTO ORDERS
  ( CustomerID, EmployeeID,  ShipVia, OrderDate, RequiredDate, ShippedDate)
  VALUES
  (@CustomerID, @EmployeeID, @ShipVia, @OrderDate, @RequiredDate, @ShippedDate)
  SET @i=@i+1
 END
COMMIT TRAN
GO


--VERIFICAR SI SE CREARON LOS FIILEGROUPS Y DATAFILES
SELECT name AS NombresFilegroups
FROM sys.filegroups
WHERE type = 'FG';

SELECT name AS [FIleName], physical_name AS [FilePath]
FROM sys.database_files
WHERE TYPE_DESC = 'ROWS';

--MOSTRAR CUANTOS REGISTROS TIENE CADA PARTICION
SELECT p.partition_number AS Num_Particion, f.name AS Nombre, p.rows AS Columnas
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Orders'
AND p.index_id = 1;


--MUESTRE LOS REGISTROS DE LA TABLA
SELECT * FROM Orders;
SELECT TOP(50) * FROM Orders ORDER BY OrderID DESC

--MUESTRE LOS REGISTROS DE CADA PARTICION
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 1;
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 2;
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 3;
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 4;
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 5;
SELECT * FROM Orders WHERE $partition.F_PartitionById(OrderID) = 6;