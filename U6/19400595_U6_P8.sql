--PRACTICA 8
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 25/05/22
--DESCRIPCION: Practicar la creacion de bitacoras con triggers

--PONER EN USO LA BD
USE Northwind;

--CREAR UNA BITÁCORA LOS MOVIMIENTOS DE LAS CANTIDADES EN EXISTENCIA DE LOS PRODUCTOS
CREATE TRIGGER TR_OrderDetails ON [Order Details] FOR INSERT, UPDATE, DELETE AS
BEGIN 
	SET NOCOUNT ON;

	DECLARE @Usuario VARCHAR(50), @Fecha DATETIME, @IdEquipo VARCHAR(50), @IdProducto INT, @Cantidad INT;
	DECLARE @CursorOrderDetails CURSOR;

	IF NOT EXISTS (SELECT * FROM BITACORAS.sys.OBJECTS WHERE TYPE = 'U' AND NAME = 'ProductoBitacora')
	BEGIN
		CREATE TABLE BITACORAS.DBO.ProductoBitacora(
			Operacion VARCHAR(30),
			Usuario VARCHAR(50),
			Fecha DATETIME,
			IdEquipo VARCHAR(50),
			IdProducto INT,
			CantSalida INT
		);
	END

	--PUNTO A
	IF (SELECT COUNT(*) FROM inserted) > 0 AND (SELECT COUNT(*) FROM deleted) = 0
	BEGIN
		--INICIALIZAR EL CURSOR
		SET @CursorOrderDetails = CURSOR FOR SELECT ProductID, Quantity FROM inserted;

		--ABRIR EL CURSOR
		OPEN @CursorOrderDetails;

		--POSICIONARNOS AL PRIMER REGISTRO
		FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad

			--EMPEZAMOS CICLO; 0 SI LO PUDO LEER, 1 SI NO PUDO LEERLO
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			--ACTUALIZAR CANTIDAD DE EXISTENCIA EN EL INVENTARIO
			UPDATE Northwind.dbo.Products
			SET UnitsInStock = (UnitsInStock - @Cantidad)
			WHERE ProductID = @IdProducto

			INSERT INTO BITACORAS.DBO.ProductoBitacora VALUES ('SALIDA', USER_NAME(), GETDATE(), HOST_NAME(), @IdProducto, @Cantidad);

			--MOVER AL SIGUIENTE REGISTRO
			FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad
		END --FIN WHILE

		CLOSE @CursorOrderDetails;
		--LIBERAR
		DEALLOCATE @CursorOrderDetails;
	END


	--PUNTO B
	IF (SELECT COUNT(*) FROM inserted) = 0 AND (SELECT COUNT(*) FROM deleted) > 0
	BEGIN
		--INICIALIZAR EL CURSOR
		SET @CursorOrderDetails = CURSOR FOR SELECT ProductID, Quantity FROM deleted;

		--ABRIR EL CURSOR
		OPEN @CursorOrderDetails;

		--POSICIONARNOS AL PRIMER REGISTRO
		FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad

			--EMPEZAMOS CICLO; 0 SI LO PUDO LEER, 1 SI NO PUDO LEERLO
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			--ACTUALIZAR CANTIDAD DE EXISTENCIA EN EL INVENTARIO
			UPDATE Northwind.dbo.Products
			SET UnitsInStock = (UnitsInStock + @Cantidad)
			WHERE ProductID = @IdProducto

			INSERT INTO BITACORAS.DBO.ProductoBitacora VALUES ('ENTRADA POR DEVOLUCION', USER_NAME(), GETDATE(), HOST_NAME(), @IdProducto, @Cantidad);

			--MOVER AL SIGUIENTE REGISTRO
			FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad
		END --FIN WHILE

		CLOSE @CursorOrderDetails;
		--LIBERAR
		DEALLOCATE @CursorOrderDetails;
	END -- FIN PUNTO B


	--PUNTO C
	IF (SELECT COUNT(*) FROM inserted) > 0 AND (SELECT COUNT(*) FROM deleted) > 0 AND EXISTS (SELECT Quantity FROM inserted) AND EXISTS (SELECT Quantity FROM deleted)
	BEGIN
		--INICIALIZAR EL CURSOR
		SET @CursorOrderDetails = CURSOR FOR SELECT ProductID, Quantity FROM inserted;

		--ABRIR EL CURSOR
		OPEN @CursorOrderDetails;

		--POSICIONARNOS AL PRIMER REGISTRO
		FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad

			--EMPEZAMOS CICLO; 0 SI LO PUDO LEER, 1 SI NO PUDO LEERLO
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			DECLARE @Diferencia INT;

			IF (SELECT Quantity FROM inserted WHERE ProductID = @IdProducto) > (SELECT Quantity FROM deleted WHERE ProductID = @IdProducto)
			BEGIN
				SET @Diferencia = (SELECT Quantity FROM inserted WHERE ProductID = @IdProducto) - (SELECT Quantity FROM deleted WHERE ProductID = @IdProducto);
				--ACTUALIZAR CANTIDAD DE EXISTENCIA EN EL INVENTARIO
				UPDATE Northwind.dbo.Products
				SET UnitsInStock = (UnitsInStock - @Diferencia)
				WHERE ProductID = @IdProducto;
			END

			IF (SELECT Quantity FROM inserted WHERE ProductID = @IdProducto) < (SELECT Quantity FROM deleted WHERE ProductID = @IdProducto)
			BEGIN
				SET @Diferencia = (SELECT Quantity FROM deleted WHERE ProductID = @IdProducto) - (SELECT Quantity FROM inserted WHERE ProductID = @IdProducto);
				--ACTUALIZAR CANTIDAD DE EXISTENCIA EN EL INVENTARIO
				UPDATE Northwind.dbo.Products
				SET UnitsInStock = (UnitsInStock + @Diferencia)
				WHERE ProductID = @IdProducto;
			END

			INSERT INTO BITACORAS.DBO.ProductoBitacora VALUES ('ACTUALIZACION', USER_NAME(), GETDATE(), HOST_NAME(), @IdProducto, @Cantidad);

			--MOVER AL SIGUIENTE REGISTRO
			FETCH FROM @CursorOrderDetails INTO @IdProducto, @Cantidad
		END --FIN WHILE

		CLOSE @CursorOrderDetails;
		--LIBERAR
		DEALLOCATE @CursorOrderDetails;
	END -- FIN PUNTO C


END
--FIN TRIGGER


--**************************COMPROBAR QUE FUNCIONA EL TRIGGER**************************--

--INSERT (PUNTO A)
INSERT INTO [Order Details] VALUES
(10327, 1, 23.30, 2, 0),
(10327, 3, 23.30, 2, 0);

--35
--9

--33
--7

SELECT * FROM Products WHERE ProductID = 1 OR ProductID = 3;
SELECT * FROM [Order Details] WHERE OrderID = 10327 AND ProductID IN (1, 3);
SELECT * FROM BITACORAS.DBO.ProductoBitacora;

--DELETE (PUNTO B)
DELETE FROM [Order Details] WHERE OrderID = 10327 AND ProductID IN (1, 3);
SELECT * FROM Products WHERE ProductID = 1 OR ProductID = 3;
SELECT * FROM BITACORAS.DBO.ProductoBitacora;

--UPDATE (PUNTO C)
UPDATE [Order Details]
SET Quantity = 24
WHERE OrderID = 10248 AND ProductID = 11;

SELECT * FROM [Order Details] WHERE OrderID = 10248 AND ProductID = 11;
SELECT * FROM Products WHERE ProductID = 11;
SELECT * FROM BITACORAS.DBO.ProductoBitacora;

--DATOS ORIGINALES
--QUANTITY: 20
--PRODUCS id: 11: Unidades en stock: 14

--DATOS NUEVOS
--QUANTITY: 24
--PRODUCS id: 11: Unidades en stock: 10