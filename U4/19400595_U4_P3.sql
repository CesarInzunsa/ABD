--PRACTICA 3
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 01/05/22
--DESCRIPCION: Practicar la creacion de backups

--2. RETOMA LA BD DE DATOS FARMACIA DE LA UNIDAD TRES, NO LA PARTICIONADA SI NO LA ORIGINAL
USE Farmacia;

--CONTAR CUANTOS REGISTROS HAY EN CADA TABLA
SELECT COUNT(*) FROM Categoria;
SELECT COUNT(*) FROM Clientes;
SELECT COUNT(*) FROM DetalleOrdenPedido;
SELECT COUNT(*) FROM Distrito;
SELECT COUNT(*) FROM Empleado;
SELECT COUNT(*) FROM OrdenPedido;
SELECT COUNT(*) FROM Presentacion;
SELECT COUNT(*) FROM Producto;
SELECT COUNT(*) FROM Proveedor;
SELECT COUNT(*) FROM Ticket;
SELECT COUNT(*) FROM Usuario;

--3. CREALE UN RESPALDO COMPLETO CON AL MENOS 4 PARAMETROS UTILIZA DISTINTOS A LOS QUE HAZ USADO HASTA AHORITA.BACKUP DATABASE FarmaciaTO DISK = 'C:\ABD2022\U4\Farmacia_Completo1.BAK'WITHNAME = 'Farmacia_Completo1',DESCRIPTION = 'Primero respaldo completo',STATS = 10,COMPRESSION;--4. INSERTA 2 EMPLEADOSINSERT INTO Empleado VALUES('1', 'Cesar Inzunsa', 'LIMA S/N', '065', 'FARMACEUTICO', '21', 2224562, 137287253, '2022-05-01 00:00:00.000', '1234'),('2', 'Alejandro Diaz', 'LIMA S/N', '065', 'ADMIN', '21', 9994556, 137987223, '2022-05-01 00:00:00.000', '1234');--5. INSERTA 10 CATEGORIASINSERT INTO Categoria VALUES('1', 'Analgesicos'),('2', 'Antiacidos'),('3', 'Antialérgicos'),('4', 'Antidiarreicos'),('5', 'Antiinfecciosos'),('6', 'Antiinflamatorios'),('7', 'Antipiréticos'),('8', 'Antitusivos y mucolíticos'),('9', 'antiulcerosos'),('10', 'laxantes');--6. INSERTA 3 PRODUCTOS DE CADA CATEGORIA QUE ACABAS DE INSERTARINSERT INTO Producto VALUES(1, 'Morfina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '1', '00127', '0030'),(2, 'Simvastatina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '1', '00127', '0030'),(3, 'Aspirina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '1', '00127', '0030'),(4, 'Omeprazol', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '2', '00127', '0030'),(5, 'Lexotiroxina sódica', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '2', '00127', '0030'),(6, 'Morfina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '2', '00127', '0030'),(7, 'Ramipril', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '3', '00127', '0030'),(8, 'Amlodipina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '3', '00127', '0030'),(9, 'Paracetamol', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '3', '00127', '0030'),(10, 'Atorvastatina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '4', '00127', '0030'),(11, 'Salbutamol', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '4', '00127', '0030'),(12, 'Lansoprazol', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '4', '00127', '0030'),(13, 'AMLODIPINO', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '5', '00127', '0030'),(14, 'AMOXICILINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '5', '00127', '0030'),(15, 'Morfina', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '5', '00127', '0030'),(16, 'ATORVASTATINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '6', '00127', '0030'),(17, 'CAPTOPRIL', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '6', '00127', '0030'),(18, 'CARBAMAZEPINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '6', '00127', '0030'),(19, 'CLINDAMICINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '7', '00127', '0030'),(20, 'CEFALEXINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '7', '00127', '0030'),(21, 'CLINDAMICINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '7', '00127', '0030'),(22, 'CLONAZEPAM', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '8', '00127', '0030'),(23, 'CLOTRIMAZOL', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '8', '00127', '0030'),(24, 'ENALAPRIL MALEATO', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '8', '00127', '0030'),(25, 'FENITOINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '9', '00127', '0030'),(26, 'FLUCONAZOL', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '9', '00127', '0030'),(27, 'GLIBENCLAMIDA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '9', '00127', '0030'),(28, 'IBUPROFENO', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '10', '00127', '0030'),(29, 'LORATADINA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '10', '00127', '0030'),(30, 'PREDNISONA', 4.0, 2.0, '2030-01-01 00:00:00.000', 20, '10', '00127', '0030');--7. CREA UN RESPALDO DIFERENCIAL DE CON NOMBRE, DESCRIPCION Y STATSBACKUP DATABASE FarmaciaTO DISK = 'C:\ABD2022\U4\Farmacia_Diferencial1.BAK'WITH DIFFERENTIAL,NAME = 'Farmacia_Diferencial1',DESCRIPTION = 'Se inserto en empleado, categoria y producto',STATS = 10;--8. BORRA LOS EMPLEADOS QUE ACABAS DE CAPTURARDELETE FROM Empleado WHERE cod_emp IN ('1', '2');--9. INSERTA 3 PRESENTACIONESINSERT INTO Presentacion VALUES('1', 'SIMILARES'),('2', 'PFIZER'),('3', 'ROCHE GROUP');--10. CREA UN RESPALDO DIFERENCIAL CON 3 PARAMETROSBACKUP DATABASE FarmaciaTO DISK = 'C:\ABD2022\U4\Farmacia_Diferencial2.BAK'WITH DIFFERENTIAL,NAME = 'Farmacia_Diferencial2',DESCRIPTION = 'Se inserto en 3 registros en presentacion',STATS = 10;--11. BORRA DOS TABLAS ELIGE TU CUALESDROP TABLE Usuario;DROP TABLE Ticket;--12. CREA UN RESPALDO COMPLETO COMPRIMIDO, CON NOMBRE Y DESCCRIPCIONBACKUP DATABASE FarmaciaTO DISK = 'C:\ABD2022\U4\Farmacia_Completo2.BAK'WITHNAME = 'Farmacia_Completo2',DESCRIPTION = 'Se inserto borro la tabla usuario y ticket',COMPRESSION;--13. INSERTA DOS ORDENESINSERT INTO OrdenPedido VALUES('1', '2022-06-01 00:00:00.000', '34984835', 'HARRY VARGAS', '24360992', '44333475', 245),('2', '2022-07-01 00:00:00.000', '45346576', 'LUIS BARIOS', '65646454', '43334634', 80);--14. ACTUALIZA LOS PRECIOS DE TODOS LOS PRODUCTOS DE 3 CATEGORIAS TU ELIGELAS SUBIENDOLES UN 30%
UPDATE Producto SET
pre_venta = ( (pre_venta * .30) + pre_venta),
pre_compra = ( (pre_compra * .30) + pre_venta)
WHERE cod_cate IN ('1', '2', '3');

--15. CREA UN RESPALDO DIFERENCIAL CON 4 PARAMETROS
BACKUP DATABASE FarmaciaTO DISK = 'C:\ABD2022\U4\Farmacia_Diferencial3.BAK'WITH DIFFERENTIAL,NAME = 'Farmacia_Diferencial3',DESCRIPTION = 'Se inserto en OrdenPedido y actualizo precio en productos en 30 porciento',STATS = 10,COMPRESSION;

--16. CREA UN RESPALDO DE LOG DE TRANSACCIONES
BACKUP LOG Farmacia
TO DISK = 'C:\ABD2022\U4\Farmacia_log1.BAK'WITHNAME = 'Farmacia_log1',DESCRIPTION = 'Primer respaldo de log';