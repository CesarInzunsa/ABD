--PRACTICA 11
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 03/05/22
--DESCRIPCION: Practicar la restauracion de backups

--A) DROPEA LA BD FARMACIA.
DROP DATABASE Farmacia;

/*
  B) UPPSSSSS ……. EQUIVOCACION PORQUE TE ATREVISTE A DROPEAR LA BASE DE DATOS, LO
  BUENO QUE ERES UN DBA PREVENIDO Y TIENES RESPALDADA LA BD. RECUPERALA CON
  TODOS LAS TRANSACCIONES QUE SE HICIERON.
  PON EN COMENTARIOS SI LO LOGRASTE …. O SI PERDISTE ALGO.
*/
RESTORE DATABASE Farmacia
FROM DISK = 'C:\ABD2022\U4\Farmacia_Completo2.BAK'
WITH REPLACE, NORECOVERY;

RESTORE DATABASE Farmacia
FROM DISK = 'C:\ABD2022\U4\Farmacia_Diferencial3.BAK'
WITH REPLACE, RECOVERY;

--Despues de realizar la restauracion y revisando las tablas y el query (en este caso). No perdimos nada al restaurar la BD.
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

--De igual forma, al final comprobamos con el siguiente query que la BD si esta disponible.
SELECT NAME,STATE_DESC
FROM SYS.DATABASES 
WHERE NAME ='Farmacia';