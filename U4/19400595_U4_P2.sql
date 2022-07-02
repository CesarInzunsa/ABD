--PRACTICA 2
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 27/04/22
--DESCRIPCION: Practicar la creacion de backups

--1. EJECUTA EL QUERY DE LA BD DE DATOS NORTHWIND Y CREALA
USE Northwind;

--CONTAR CUANTOS REGISTROS HAY EN CADA TABLA
SELECT COUNT(*) FROM Categories;
SELECT COUNT(*) FROM CustomerCustomerDemo;
SELECT COUNT(*) FROM CustomerDemographics;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Employees;
SELECT COUNT(*) FROM EmployeeTerritories
SELECT COUNT(*) FROM [Order Details];
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Region;
SELECT COUNT(*) FROM Shippers;
SELECT COUNT(*) FROM Suppliers;
SELECT COUNT(*) FROM Territories;

--2. REALIZA UN RESPALDO COMPLETO CON AL MENOS TRES PARAMETROS
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoFull_Northwind.BAK'
WITH
NAME = 'Completo1 de Northwind',
DESCRIPTION = 'Primer respaldo completo',
STATS = 10;

--3. INSERTAR COMPAÑEROS EN TABLA EMPLEADOS
INSERT INTO Employees (FirstName, LastName, Title, BirthDate, ReportsTo) VALUES
('LEONEL', 'NAVARRO', 'Sales Manager', '2001-04-15 00:00:00.000', 2),
('MARLETH', 'MARIN', 'Sales Manager', '2001-06-12 00:00:00.000', 2),
('FERNANDA', 'FLORES', 'Sales Representative', '2001-09-27 00:00:00.000', 5),
('DORIS', 'QUEZADA', 'Sales Representative', '2001-07-1 00:00:00.000', 2),
('EDWIN', 'MONTOYA', 'Sales Representative', '2001-06-28 00:00:00.000', 2),
('BRYAN', 'MACHAIN', 'Sales Representative', '2001-11-8 00:00:00.000', 5),
('VICTOR', 'PACHECO', 'Sales Manager', '2001-10-19 00:00:00.000', 5),
('ISAAC', 'HERNANDEZ', 'Sales Manager', '2001-01-23 00:00:00.000', 2),
('ZARA', 'LOPEZ', 'Sales Manager', '2001-06-30 00:00:00.000', 5),
('CESAR', 'INSUNZA', 'Sales Representative', '2001-11-3 00:00:00.000', 2),
('ANDRES', 'RAMOS', 'Sales Manager', '2001-08-7 00:00:00.000', 2),
('PAUL', 'OCHOA', 'Sales Representative', '2001-01-30 00:00:00.000', 2),
('IVAN', 'ROBLES', 'Sales Manager', '2001-07-19 00:00:00.000', 2),
('EDUARDO', 'MEZA', 'Sales Manager', '2001-02-24 00:00:00.000', 5),
('CARLOS', 'OROZCO', 'Sales Manager', '2001-05-8 00:00:00.000', 2),
('CESAR', 'ROJO', 'Sales Manager', '2001-03-7 00:00:00.000', 2),
('PEDRO', 'FIGUEROA', 'Sales Representative', '2001-02-21 00:00:00.000', 5),
('MAURICIO', 'MARTINEZ', 'Sales Manager', '2001-10-14 00:00:00.000', 2),
('ERICK', 'RAMIREZ', 'Sales Manager', '2001-11-27 00:00:00.000', 2);

--4. ACTUALIZA LAS FECHAS DE LAS ORDENES 2019, 2020, 2021
UPDATE Orders SET
OrderDate =  DATEADD(YEAR, 23, OrderDate),
RequiredDate =  DATEADD(YEAR, 23, OrderDate),
ShippedDate =  DATEADD(YEAR, 23, OrderDate)
WHERE OrderDate BETWEEN '1996-1-1' AND '1996-12-31';

UPDATE Orders SET
OrderDate =  DATEADD(YEAR, 23, OrderDate),
RequiredDate =  DATEADD(YEAR, 23, OrderDate),
ShippedDate =  DATEADD(YEAR, 23, OrderDate)
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-12-31';

UPDATE Orders SET
OrderDate =  DATEADD(YEAR, 23, OrderDate),
RequiredDate =  DATEADD(YEAR, 23, OrderDate),
ShippedDate =  DATEADD(YEAR, 23, OrderDate)
WHERE OrderDate BETWEEN '1998-1-1' AND '1998-12-31';

--5. REALIZA UN RESPALDO DIFERENCIAL
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoDif1_Northwind.BAK'
WITH DIFFERENTIAL,
NAME = 'Diferencial1 de Northwind',
DESCRIPTION = 'Primer respaldo diferencial',
STATS = 10;

--6. CREA UNA VISTA CON EL NO.EMPLEADO, NOMBRE EMPLEADO Y CANTIDAD DE ORDENES QUE HA VENDIDO
CREATE VIEW VISTA_Empleados_Ordenes AS
SELECT E.EmployeeID, E.FirstName, E.LastName, COUNT(O.OrderID) AS [NO. ORDENES] FROM Employees E
LEFT JOIN Orders O ON (E.EmployeeID = O.EmployeeID)
GROUP BY E.EmployeeID, E.FirstName, E.LastName;

--7. REALIZA UN RESPALDO DE SOLO COPIA
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoSoloCopia_Northwind.BAK'
WITH COPY_ONLY,
COMPRESSION;

--8. REALIZA UN RESPALDO DIFERENCIAL CON AL MENOS 5 PARAMETROS
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoDif2_Northwind.BAK'
WITH DIFFERENTIAL,
NAME = 'Diferencial2 de Northwind',
DESCRIPTION = 'Se creo una vista para empleados y su no. de ordenes',
EXPIREDATE = '2022-05-1',
RETAINDAYS = 2,
STATS = 10;

--9. ACTUALIZA LAS FECHAS DE NACIMIENTOS DE LOS EMPLEADOS QUE SON MAS VIEJOS Y HAZLOS MAS JOVENES DE 30 A 35 AÑOS
UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 20, BirthDate)
WHERE YEAR(BirthDate) = 1972; 

UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 15, BirthDate)
WHERE YEAR(BirthDate) = 1975;

UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 10, BirthDate)
WHERE YEAR(BirthDate) = 1978;

UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 10, BirthDate)
WHERE YEAR(BirthDate) = 1980;

UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 5, BirthDate)
WHERE YEAR(BirthDate) = 1983;

UPDATE Employees
SET BirthDate =  DATEADD(YEAR, 3, BirthDate)
WHERE YEAR(BirthDate) = 1986;

--10. REALIZA UN RESPLADO DIFERENCIAL CON 3 PARAMETROS
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoDif3_Northwind.BAK'
WITH DIFFERENTIAL,
NAME = 'Diferencial3 de Northwind',
DESCRIPTION = 'Se actualizaron las fechas de nacimiento de los empleados',
STATS = 10;

--11. CREA UNA TABLA CON LOS EMPLEADOS QUE NO HAN VENDIDO ORDENES
SELECT E.EmployeeID, E.FirstName, E.LastName, E.Title, E.BirthDate, E.ReportsTo
INTO EmpleadosNoOrdenes
FROM Employees E
INNER JOIN VISTA_Empleados_Ordenes VEO ON (E.EmployeeID = VEO.EmployeeID)
WHERE VEO.[NO. ORDENES] = 0;

--12. BORRA LOS EMPLEADOS QUE NO HAN VENDIDO ORDENS
DELETE FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM VISTA_Empleados_Ordenes VEO WHERE VEO.[NO. ORDENES] = 0);

--13. CREA UN RESPALDO COMPLETO CON TRES PARAMETROS
BACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoFull2_Northwind.BAK'
WITH
NAME = 'Completo2 de Northwind',
DESCRIPTION = 'Se creo una tabla con empleados que no tienen ordenes y se eliminaron de Employees',
STATS = 10;

--14. INSERTA 20 PRODUCTOS
INSERT INTO Products VALUES
('Queso', '1', '1', '20 Cajas', 20.00, 120, 0, 0, 0)
GO 5

INSERT INTO Products VALUES
('Bebida Energetica', '2', '2', '300 Cajas', 97.00, 86, 0, 10, 0)
GO 5

INSERT INTO Products VALUES
('Satoru Empanizador', '3', '3', '200 Cajas', 21.00, 29, 0, 0, 0)
GO 5

INSERT INTO Products VALUES
('Trufas', '4', '4', '80 Cajas', 62.50, 42, 0, 5, 0)
GO 5

SELECT * FROM Products;

--15. MODIFICA LA CATEGORIA DE LOS PRODUCTOS INSERTADOSUPDATE ProductsSET CategoryID = 5WHERE ProductID IN (SELECT TOP(20) ProductID FROM Products ORDER BY ProductID DESC);--16. CREA UN RESPALDO DIFERENCIALBACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoDif4_Northwind.BAK'
WITH DIFFERENTIAL,
NAME = 'Diferencial4 de Northwind',
DESCRIPTION = 'Se inserto 20 en productos y modifico categoria productos insertados',
STATS = 10;--17. BORRA LA TABLA DE LOS EMPLEADOS QUE CREASTE EN EL PUNTO 11DROP TABLE EmpleadosNoOrdenes;--18. REALIZA OTRO RESPALDO DIFERENCIALBACKUP DATABASE Northwind
TO DISK = 'C:\ABD2022\U4\RespaldoDif5_Northwind.BAK'
WITH DIFFERENTIAL,
NAME = 'Diferencial5 de Northwind',
DESCRIPTION = 'Se borro tabla EmpleadosNoOrdenes',
STATS = 10;