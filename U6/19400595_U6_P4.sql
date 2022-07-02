--PRACTICA 4
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 16/05/22
--DESCRIPCION: Practicar la creacion y activacion auditorias

--PONER EN USO LA BD
USE PRESTAMOS;

/*
Crear una auditoria; de la BD de datos de PRESTAMOS actualizada que utilizaste en la unidad pasada. Auditar:
1. Todas las acciones DML: INSERT, DELETE, UPDATE, SELECT
2.  Execute: EXECUTE
3.  References: REFERENCES
NOTA: del esquema DBO y de entidad de Seguridad DBO
4.  Todos los select en la BD de la Entidad de Seguridad que creaste en el examen: ?????
5.  Cuando se le cambie el propietario a un esquema: SCHEMA_OBJECT_OWNDERSHIP_CHANGE_GROUP
6.  Cuando se le otorguen o revoquen permisos a los usuarios: DATABASE_PERMISSION_CHANGE_GROUP
7.  Cuando se agreguen o quiten miembros a los roles de bd: DATABASE_ROLE_MEMBER_CHANGE_GROUP
8.  Cuando se ejecuten un DBCC en la BD: DBCC_GROUP
9.  Cuando se modifique un esquema: SCHEMA_OBJECT_CHANGE_GROUP
10. Proceso por lotes, transacción o procedimientos: BATCH_STARTED_GROUP
11. Las siguientes operaciones: 
		DELETE en cualquier tabla y de la entidad de seguridad ROL PUBLIC:
		INSERT en dos tablas en específico y la entidad de seguridad DATA_READER: 
		EXCECUTE cualquier SP y entidad DBO: 
*/

--CREAR SERVIDOR DE AUDITORIA
USE [master]

GO

CREATE SERVER AUDIT [Auditoria_U6_P4]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias\Practica4'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

GO

--HABILITAR AUDITORIA
ALTER SERVER AUDIT Auditoria_U6_P4
WITH (STATE = ON);

--CREAR ESPECIFIFICACIONES DE LA AUDITORIA A NIVEL BD
USE [PRESTAMOS]

GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAudit_U6_P4]
FOR SERVER AUDIT [Auditoria_U6_P4]
ADD (INSERT ON SCHEMA::[dbo] BY [dbo]),
ADD (DELETE ON SCHEMA::[dbo] BY [dbo]),
ADD (UPDATE ON SCHEMA::[dbo] BY [dbo]),
ADD (SELECT ON SCHEMA::[dbo] BY [dbo]),
ADD (EXECUTE ON SCHEMA::[dbo] BY [dbo]),
ADD (REFERENCES ON SCHEMA::[dbo] BY [dbo]),
--AQUI PONDRIA EL PUNTO 4, SI TAN SOLO SUPIERA QUE ES!!
ADD (SCHEMA_OBJECT_OWNERSHIP_CHANGE_GROUP),
ADD (DATABASE_PERMISSION_CHANGE_GROUP),
ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP),
ADD (DBCC_GROUP),
ADD (SCHEMA_OBJECT_CHANGE_GROUP),
ADD (BATCH_STARTED_GROUP),
ADD (DELETE ON OBJECT::[dbo].[ABONO] BY [public]),
ADD (INSERT ON OBJECT::[dbo].[ABONO] BY [db_datareader]),
ADD (INSERT ON OBJECT::[dbo].[PRESTAMOS] BY [db_datareader]),
ADD (EXECUTE ON DATABASE::[PRESTAMOS] BY [dbo])

GO

--HABILITAR ESPECIFIFICACIONES DE LA AUDITORIA
ALTER DATABASE AUDIT SPECIFICATION DatabaseAudit_U6_P4
WITH (STATE = ON);

--***************************PROBAR TODAS LAS ESP AL MENOS UNA VEZ***************************
--1. Todas las acciones DML: INSERT, DELETE, UPDATE, SELECT
SELECT * FROM PRESTAMOS.DBO.ABONO;

--2.  Execute: EXECUTE
EXECUTE sp_clean_db_free_space PRESTAMOS;

--3.  References: REFERENCES

--NOTA: del esquema DBO y de entidad de Seguridad DBO
--4.  Todos los select en la BD de la Entidad de Seguridad que creaste en el examen: ?????

--5.  Cuando se le cambie el propietario a un esquema: SCHEMA_OBJECT_OWNDERSHIP_CHANGE_GROUP
CREATE SCHEMA soyUnEsquema1;
ALTER USER soyUnUsuario WITH DEFAULT_SCHEMA = soyUnEsquema1;
EXECUTE sp_changeobjectowner [dbo.ABONO], soyUnEsquema1;

--6.  Cuando se le otorguen o revoquen permisos a los usuarios: DATABASE_PERMISSION_CHANGE_GROUP
CREATE LOGIN soyUnLogin7 WITH PASSWORD = '19400595';
CREATE USER soyUnUsuario7 FOR LOGIN soyUnLogin7;
GRANT ALL ON DBO.ABONO TO soyUnUsuario7;

--7.  Cuando se agreguen o quiten miembros a los roles de bd: DATABASE_ROLE_MEMBER_CHANGE_GROUP
EXECUTE sp_addrolemember db_datareader, soyUnUsuario7;

--8.  Cuando se ejecuten un DBCC en la BD: DBCC_GROUP
DBCC CHECKCONSTRAINTS(ABONO);

--9.  Cuando se modifique un esquema: SCHEMA_OBJECT_CHANGE_GROUP
ALTER SCHEMA soyUnEsquema1 TRANSFER dbo.PRESTAMOS;

--10. Proceso por lotes, transacción o procedimientos: BATCH_STARTED_GROUP
EXECUTE sp_help;

--11. Las siguientes operaciones: 
--		DELETE en cualquier tabla y de la entidad de seguridad ROL PUBLIC:
--		INSERT en dos tablas en específico (Abono y Prestamos) y la entidad de seguridad DATA_READER: 
--		EXCECUTE cualquier SP y entidad DBO: 
DELETE FROM PRESTAMOS.DBO.ABONO WHERE PRESTAMOS.DBO.ABONO.PREID = 26;
INSERT INTO PRESTAMOS.DBO.ABONO VALUES (52, NULL, 1000.00, 'T');

--VER AUDITORIAS
SELECT event_time,action_id,statement,database_name,server_principal_name
FROM fn_get_audit_file( 'C:\ABD2022\U6\Auditorias\Practica4\Auditoria_U6_P4*.sqlaudit' , DEFAULT , DEFAULT)
WHERE database_name = 'PRESTAMOS';