--PRACTICA 6
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 01/05/22
--DESCRIPCION: Practicar la creacion de backups

--PONER EN USO LA BD
USE Northwind;

--CONTAR CUANTOS REGISTROS HAY EN CADA TABLA
SELECT COUNT(*) FROM Categories;
SELECT COUNT(*) FROM CustomerCustomerDemo;
SELECT COUNT(*) FROM CustomerDemographics;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Employees;
SELECT COUNT(*) FROM EmployeeTerritories
SELECT COUNT(*) FROM  [Order Details];
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Region;
SELECT COUNT(*) FROM Shippers;
SELECT COUNT(*) FROM Suppliers;
SELECT COUNT(*) FROM Territories;

--CREAR RESPALDO COMPLETO
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_Completo1.BAK'
WITH
NAME = 'Northwind_Completo1',
DESCRIPTION = 'Primer respaldo completo';

--A. AUMENTA UN 10% A LOS PRECIOS DE LOS PRODUCTOS CUYA CATEGORIA EMPIECE CON UNA ‘C’ O ‘S’.
UPDATE Products
SET UnitPrice = ( (UnitPrice * 0.10) + UnitPrice )
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName LIKE 'C%' OR CategoryName LIKE 'S%');

--B. ACTUALIZA LA REGION DE TODOS CLIENTES(CUSTOMERS) POR UNA VALIDA A AQUELLOS QUE TENGAN NULL
UPDATE Customers
SET Region = 'México D.F.'
WHERE Region IS NULL;

--C. REALIZA UN RESPALDO DIFERENCIAL CON PARAMETROS
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_Diferencial1.BAK'
WITH DIFFERENTIAL,
NAME = 'Northwind_Diferencial1',
DESCRIPTION = 'Se actualizo registros de productos y clientes';

--D. INSERTA 1000 EMPLEADOS CON UNA FECHA DE NACIMIENTO VARIADOS, ASI QUE IMPLEMENTA UN CICLO DE REPETICION DESDE 1998 HASTA 2005.
DECLARE @i int
DECLARE @LastName NVARCHAR(20)
DECLARE @FirstName NVARCHAR(10)
DECLARE @Title NVARCHAR(30)
DECLARE @BirthDate DATETIME
DECLARE @ReportsTo INT
SET @i = 1

BEGIN TRAN
WHILE @i<=1000
BEGIN 
  IF @i between 1 and 50
     SET @LastName = 'Pedro'
	 SET @FirstName = 'Gomez'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1998/01/15'
	 SET @ReportsTo = 2
  IF @i between 51 and 100
     SET @LastName = 'Fernando'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1998/06/15'
	 SET @ReportsTo = 5
  IF @i between 101 and 150
     SET @LastName = 'Maria'
	 SET @FirstName = 'Juan'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1998/12/15'
	 SET @ReportsTo = 2
  IF @i between 151 and 200
     SET @LastName = 'Alejandro'
	 SET @FirstName = 'Martin'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1999/01/15'
	 SET @ReportsTo = 5
  IF @i between 201 and 250
	 SET @LastName = 'Martin'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1999/06/15'
	 SET @ReportsTo = 2
  IF @i between 251 and 300
     SET @LastName = 'Chalio'
	 SET @FirstName = 'Hernandez'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '1999/12/15'
	 SET @ReportsTo = 5
  IF @i between 301 and 350
     SET @LastName = 'Rosalio'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2000/01/15'
	 SET @ReportsTo = 2
  IF @i between 351 and 400
     SET @LastName = 'Maria'
	 SET @FirstName = 'Antonieta'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2000/06/15'
	 SET @ReportsTo = 5
  IF @i between 401 and 450
     SET @LastName = 'Jose'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2000/12/15'
	 SET @ReportsTo = 2
  IF @i between 451 and 500
     SET @LastName = 'Eduardo'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2002/01/15'
	 SET @ReportsTo = 5
  IF @i between 501 and 550
     SET @LastName = 'Alba'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2002/06/15'
	 SET @ReportsTo = 2
  IF @i between 551 and 600
     SET @LastName = 'Emma'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2002/12/15'
	 SET @ReportsTo = 5
  IF @i between 601 and 650
     SET @LastName = 'Lucas'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2003/01/15'
	 SET @ReportsTo = 2
  IF @i between 651 and 700
     SET @LastName = 'Manuel'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2003/06/15'
	 SET @ReportsTo = 5
  IF @i between 701 and 750
     SET @LastName = 'Ana'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2003/12/15'
	 SET @ReportsTo = 2
  IF @i between 751 and 800
     SET @LastName = 'Alvaro'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2004/01/15'
	 SET @ReportsTo = 5
  IF @i between 801 and 850
     SET @LastName = 'Gerardo'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2004/06/15'
	 SET @ReportsTo = 2
  IF @i between 851 and 900
     SET @LastName = 'Neymar'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2004/12/15' 
	 SET @ReportsTo = 5
  IF @i between 901 and 950
     SET @LastName = 'Eric'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2005/01/15' 
	 SET @ReportsTo = 2
  IF @i between 951 and 1000
     SET @LastName = 'Ivan'
	 SET @FirstName = 'Jose'
	 SET @Title = 'Sales Manager'
     SET @BirthDate = '2005/06/15'
	 SET @ReportsTo = 5

  INSERT INTO Employees
  (
   LastName,
   FirstName,
   Title,
   BirthDate,
   ReportsTo
  )
  VALUES
  (
   @LastName,
   @FirstName,
   @Title,
   @BirthDate,
   @ReportsTo
  )
  SET @i=@i+1
 END
COMMIT TRAN
GO

--E. INSERTA DOS ORDENES DE COMPRA COMPLETAS ( ES DECIR LA ORDEN Y SU DETALLE DE ORDEN CON AL MENOS 2 ARTICULOS VENDIDOS EN CADA UNA)INSERT INTO Orders VALUES('VINET', 5, '2022-07-04 00:00:00.000', '2022-07-04 00:00:00.000', '2022-07-04 00:00:00.000', 3, 32.38, 'Vins et alcools Chevalier', '59 rue de l Abbaye', 'Reims', 'RJ', '05454-876', 'Brazil'),('WELLI', 3, '2022-07-15 00:00:00.000', '2022-08-12 00:00:00.000', '2022-07-17 00:00:00.000', 2, 13.97, 'Wellington Importadora', 'Rua do Mercado, 12', 'Resende', 'SP', '08737-363', 'Brazil');INSERT INTO [Order Details] VALUES(11090, 44, 19.45, 10, 0),(11091, 29, 123.79, 6, 0);--F. REALIZA UN RESPALDO DIFERENCIA ELIGE PARAMENTROS DISTINTOS AL ANTERIOR.BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_Diferencial2.BAK'
WITH DIFFERENTIAL,
STATS = 10,COMPRESSION;--G. CREA UNA TABLA DE EMPLEADOS_HISTORICO.CREATE TABLE EMPLEADOS_HISTORICO(EmployeeID INT NOT NULL,LastName NVARCHAR(20) NOT NULL,FirstName NVARCHAR(10) NOT NULL,Title NVARCHAR(30),TitleOfCourtesy NVARCHAR(30),BirthDate DATETIME,HireDate DATETIME,[Address] NVARCHAR(60),City NVARCHAR(15),Region NVARCHAR(15),PostalCode NVARCHAR(10),Country NVARCHAR(15),HomePhone NVARCHAR(24),Extension NVARCHAR(4),Photo IMAGE,Notes NTEXT,ReporsTo INT,PhotoPath NVARCHAR(255));--H. INSERTA TODOS LOS EMPLEADOS CUYA FECHA DE NACIMIENTO SEA MENOR AL 2000 EN LA TABLA CREADA.INSERT INTO EMPLEADOS_HISTORICO SELECT * FROM Employees WHERE YEAR(BirthDate) < 2000;--I. REALIZA UN RESPALDO DIFERENCIAL UTILIZANDO OTRO JUEGO DE PARAMETROS.BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_Diferencial3.BAK'
WITH DIFFERENTIAL,
NO_COMPRESSION,NOSKIP;--J. INSERTA 20 NUEVOS PRODUCTOSINSERT INTO Products VALUES
('Caviar Almas', '1', '1', '20 Cajas', 20.00, 120, 0, 0, 0)
GO 5INSERT INTO Products VALUES
('Trufa blanca de Alba', '2', '2', '300 Cajas', 97.00, 86, 0, 10, 0)
GO 5

INSERT INTO Products VALUES
('Buey de Kobe', '3', '3', '200 Cajas', 21.00, 29, 0, 0, 0)
GO 5

INSERT INTO Products VALUES
('Fugu', '4', '4', '80 Cajas', 62.50, 42, 0, 5, 0)
GO 5--K. ACTUALIZA LAS EDADES DE LOS EMPLEADOS HAZLOS MAS JOVENES QUE TENGAN ENTRE 20 Y 30 AÑOSUPDATE Employees
SET BirthDate =  DATEADD(YEAR, 5, BirthDate)
WHERE YEAR(BirthDate) <= 1992; UPDATE Employees
SET BirthDate =  DATEADD(YEAR, -5, BirthDate)
WHERE YEAR(BirthDate) >= 2005; --L. REALIZA UN RESPALDO DE SOLO COPIABACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_SoloCopia1.BAK'
WITH COPY_ONLY;--M. REALIZA UN RESPALDO DIFERENCIALBACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\Northwind_Diferencial4.BAK'
WITH DIFFERENTIAL,
NAME = 'Northwind_Diferencia4',
DESCRIPTION = 'Se creo un respaldo de solo copia';