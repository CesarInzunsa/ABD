--PRACTICA 7
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 19/05/2022
--DESCRIPCION: Practicar la creacion de bitacoras y triggers

--PONER EN USO LA BD
USE Northwind;

--CREAR EL TRIGGER EN Orders
CREATE TRIGGER TR_MVTS_ORDERS ON Orders FOR INSERT,UPDATE,DELETE AS
BEGIN
	SET NOCOUNT ON;
	DECLARE	@OPERACION  VARCHAR(15), @ORDERID INT, @FECHAORDEN DATETIME, @FECHAREQUERIDA DATETIME,
			@FECHAENVIO DATETIME, @CLIENTE NCHAR(5), @EMPLEADO INT, @VIADEENVIO INT, @CANTINSERT INT,
			@CANTDELETE INT;

	-- DELCARAR CURSOR
	DECLARE @CURORDER CURSOR;

	IF (NOT EXISTS (SELECT * FROM BITACORAS.sys.objects WHERE TYPE = 'U' AND NAME = 'BITORDERS'))
	BEGIN
		CREATE TABLE BITACORAS.DBO.BITORDERS(
			OPERACION  VARCHAR(15),
			ORDERID INT,
			FECHAORDEN DATETIME,
			FECHAREQUERIDA DATETIME,
			FECHAENVIO DATETIME,
			CLIENTE NCHAR(5),
			EMPLEADO INT,
			VIADEENVIO INT,
			USUARIO VARCHAR(30),
			APLICACION VARCHAR(200),
			FECHAMOVIMIENTO DATE,
			COMPUTADORA VARCHAR(100)
		)
	END -- Fin del IF

	--OBTENER CANTIDAD DE REGISTROS AFECTADOS
	SET @CANTINSERT = (SELECT COUNT(*) FROM INSERTED)
	SET @CANTDELETE = (SELECT COUNT(*) FROM DELETED)

	--UPDATE
	IF(@CANTINSERT > 0 AND @CANTDELETE > 0)
	BEGIN
		SET @OPERACION = 'UPDATE'
		SET @CURORDER = CURSOR FOR SELECT OrderID,OrderDate,RequiredDate,
		ShippedDate,CustomerID,EmployeeID,ShipVia FROM DELETED
	END
	ELSE
	BEGIN
		--INSERT
		IF(@CANTINSERT > 0 AND @CANTDELETE = 0)
		BEGIN
			SET @OPERACION = 'INSERT'
			SET @CURORDER = CURSOR FOR SELECT OrderID,OrderDate,RequiredDate,
				ShippedDate,CustomerID,EmployeeID,ShipVia FROM INSERTED
		END
		ELSE 
		BEGIN
			SET @OPERACION = 'DELETE'
			SET @CURORDER = CURSOR FOR SELECT OrderID,OrderDate,RequiredDate,
			ShippedDate,CustomerID,EmployeeID,ShipVia FROM DELETED
		END
	END --FIN

	-- ABRIR CURSOR
	OPEN @CURORDER;

	-- LEER LA PRIMERA FILA
	FETCH FROM @CURORDER INTO @ORDERID, @FECHAORDEN, @FECHAREQUERIDA, @FECHAENVIO, @CLIENTE, @EMPLEADO, @VIADEENVIO;

	-- RECORRER EL CURSOR
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO BITACORAS.DBO.BITORDERS VALUES
		(@OPERACION, @ORDERID, @FECHAORDEN, @FECHAREQUERIDA, @FECHAENVIO, @CLIENTE, @EMPLEADO, @VIADEENVIO,
		 USER_NAME(), APP_NAME(), GETDATE(), HOST_NAME())

		FETCH NEXT FROM @CURORDER INTO @ORDERID, @FECHAORDEN, @FECHAREQUERIDA, @FECHAENVIO, @CLIENTE,
			            @EMPLEADO, @VIADEENVIO

	END -- FIN DE WHILE

	-- CERRAR CURSOR
	CLOSE @CURORDER;

	--LIBERAR CURSOR
	DEALLOCATE @CURORDER;

END -- FIN TRIGGER

--DISPARAR EL TRIGGER
UPDATE Orders 
SET EmployeeID = 4
WHERE OrderID BETWEEN 10250 AND 10255;

--COMPROBAR QUE EL TRIGGER SE DISPARO REVISANDO LA BITACORA
SELECT * FROM BITACORAS.DBO.BITORDERS;