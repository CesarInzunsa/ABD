--PRACTICA 5
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 16/03/22
--DESCRIPCION: Practicar la creación y las operaciones con logins, roles y esquemas


--PONER EN USO LA BD
USE Farmacia;

---3.ANALIZA LA BD HACIENDO CONSULTAS EN CADA TABLA
SELECT * FROM Categoria;
SELECT * FROM Clientes;
SELECT * FROM DetalleOrdenPedido;
SELECT * FROM Distrito;
SELECT * FROM Empleado;
SELECT * FROM OrdenPedido;
SELECT * FROM Presentacion;
SELECT * FROM Producto;
SELECT * FROM Proveedor;
SELECT * FROM Ticket;
SELECT * FROM Usuario;

---4. CREA UN LOGIN Y SU USUARIO. QUE TENGA PERMISOS PARA MODIFICAR LA ESTRUCTURA DE LA BD, CONSULTAS
--    QUE PUEDA CREAR LOGINS Y USUARIOS, ROLES.
CREATE LOGIN farmaciau1 WITH PASSWORD = '12345';
CREATE USER farmaciau1 FOR LOGIN farmaciau1;

EXECUTE sp_addrolemember db_ddladmin, farmaciau1;
EXECUTE sp_addrolemember db_datareader, farmaciau1;
EXECUTE sp_addrolemember db_securityadmin, farmaciau1;
EXECUTE sp_addrolemember db_accessadmin, farmaciau1;
EXECUTE sp_addsrvrolemember farmaciau1, sysadmin;

---5. CREAR UNA TABLA Y RELACIONALA CON OTRA. ANOTA POR MEDIO DE COMENTARIOS EN DONDE QUEDO
--Quedo relacionada con la tabla proveedor a traves de una llave foranea que agregue en la tabla Proveedor
CREATE TABLE TipoProveedor(
idTipoProveedor VARCHAR(8) PRIMARY KEY,
nombreTipoProveedor VARCHAR(30),
);
ALTER TABLE Proveedor ADD idTipoProveedor VARCHAR(8) REFERENCES TipoProveedor(idTipoProveedor);


---6.CONECTATE CON EL LOGIN CREADO

---7. CREAR AL MENOS DOS ESQUEMAS Y REORGANIZAZA LA BD , ACOMODANDO LAS TABLAS EN LOS ESQUEMAS QUE CREAS CONVENIENTES.
CREATE SCHEMA Inventario;
--Inventario a: Producto, Categoria
ALTER SCHEMA Inventario TRANSFER dbo.Producto;
ALTER SCHEMA Inventario TRANSFER dbo.Categoria;

CREATE SCHEMA Historial;
--Ordenes a: DetalleOrdenPedido, OrdenPedido, Ticket
ALTER SCHEMA Historial TRANSFER dbo.DetalleOrdenPedido;
ALTER SCHEMA Historial TRANSFER dbo.OrdenPedido;
ALTER SCHEMA Historial TRANSFER dbo.Ticket;

CREATE SCHEMA Usuario;
ALTER SCHEMA Usuario TRANSFER dbo.Usuario;
ALTER SCHEMA Usuario TRANSFER dbo.Clientes;

CREATE SCHEMA Proveedor;
ALTER SCHEMA Proveedor TRANSFER dbo.Proveedor;
ALTER SCHEMA Proveedor TRANSFER dbo.TipoProveedor;

CREATE SCHEMA Ubicacion;
ALTER SCHEMA Ubicacion TRANSFER dbo.Distrito;
ALTER SCHEMA Ubicacion TRANSFER dbo.Presentacion;

CREATE SCHEMA Personal;
ALTER SCHEMA Personal TRANSFER dbo.Empleado;

---8. CAMBIALE SU ESQUEMA POR DEFAULT AL USUARIO CREADO
ALTER USER farmaciau1 WITH DEFAULT_SCHEMA = Inventario;

---9. CREA UN ROL QUE TENGA PERMISOS DE CONSULTA E INSERCION.
USE Farmacia;
CREATE ROLE farmaciarol1;
EXECUTE sp_addrolemember db_datareader, farmaciarol1;
EXECUTE sp_addrolemember db_datawriter, farmaciarol1;

---10. CREAR UN LOGIN QUE TENGA LA BD FARMACIA POR DEFAULT Y UN USUARIO
CREATE LOGIN farmaciau2 WITH PASSWORD = '12345';
CREATE USER farmaciau2 FOR LOGIN farmaciau2;
ALTER LOGIN farmaciau2 WITH DEFAULT_DATABASE = Farmacia;

---11. CAMBIALE AL USUARIO SU ESQUEMA POR DEFAULT QUE SEA UNO E LOS CREADOS 
ALTER USER farmaciau2 WITH DEFAULT_SCHEMA = Historial;

---12. CONECTATE CON EL SEGUNDO USUARIO Y HAZ CONSULTAS QUE INTERVENGAN DE 2 O MAS TABLAS.
SELECT * FROM Ubicacion.Distrito D 
INNER JOIN Usuario.Clientes C ON (D.cod_dis = C.cod_dis)
INNER JOIN Personal.Empleado E ON (E.cod_dis = D.cod_dis);

---13. CAMBIATE AL USUARIO sa Y CAMBIALE EL PASSWORD AL LOGIN 1
ALTER LOGIN farmaciau1 WITH PASSWORD = '123' OLD_PASSWORD = '12345';


--14.DESCONECTATE DEL LOGIN 1Y VUELVE A ENTRAR CON EL NUEVO PASSWORD.