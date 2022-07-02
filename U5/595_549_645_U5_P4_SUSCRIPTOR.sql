/*******************
	SUSCRIPTOR
********************/

--2. Intenta AGREGAR 3 sucursales en la tabla SUCURSAL, uno en cada suscripción.
INSERT INTO SUCURSAL (suc_calle, suc_colonia, suc_ciudad) VALUES
('Quarzo Rosa', 'Colonia Rosa', 'Col Rosa');

--3. AGREGA 3 empleados, 1 por cada suscripción con el nombre de cada integrante
--y con una sucursal distinta a la que agregaste, osea agregar una de otra suscripción.
INSERT INTO EMPLEADOS (emp_nombre, emp_telefono, emp_edad, emp_puesto, emp_turno, suc_ID) VALUES
('Cesar', '3115855555', 21, 'Gerente', 'Matutino', 1);

--4. Verifica los cambios con un SELECT en la tabla EMPLEADOS.
SELECT * FROM EMPLEADOS;

--5. Cada suscriptor AGREGARA 2 productos los que quiera.
INSERT INTO PRODUCTOS (pro_nombre, pro_precio, pro_stock, pro_contenido) VALUES
('Pizza', '300', 5000, 'Pues unas pizzas'),
('Tacos', '100', 1000, 'Pues unos tacos');

--6. Verificar los productos con un SELECT en la tabla PRODUCTOS
SELECT * FROM PRODUCTOS;

--7. AGREGAR una venta cada suscriptor
INSERT INTO VENTAS (ven_Folio, pro_ID, ven_cantidad, ven_monto, emp_ID, suc_ID) VALUES
(10000, 4, 1, '600', 2, 1);

--8. REALIZAR UN INNER JOIN CON TODAS LAS TABLAS
SELECT (V.ven_ID) AS [NUMERO DE VENTA],(V.ven_Folio) AS FOLIO,
(P.pro_nombre) AS PRODUCTO,(V.ven_cantidad) AS CANTIDAD,
(V.ven_monto) AS MONTO,(E.emp_nombre) AS EMPLEADO,
(S.suc_calle+' '+S.suc_colonia+' '+S.suc_ciudad) AS SUCURSAL
FROM Ventas V
INNER JOIN Productos P ON (V.pro_ID = P.pro_ID)
INNER JOIN Empleados E ON (V.emp_ID = E.emp_ID)
INNER JOIN Sucursal S ON (V.suc_ID = S.suc_ID);
