--PRACTICA 2
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 12/05/22
--DESCRIPCION: Practicar la creacion y activacion auditorias

--Crear una auditoria para la monitorear las tareas en el servidor y de base de datos. Auditar:

/*
1.  Backup y Restores: BACKUP_RESTORE_GROUP

2.  Cuando se ejecuta un evento batch: BATCH_STARTED_GROUP

3.  Cuando se crea o elimina una BD: DATABASE_CHANGE_GROUP

4.  Insert y Delete en una tabla determinada de una BD, elígela tu, tanto la BD como las tabla:
    INSERT PARA HEROES Y VILLANOS; PARA DELETE PARA PODERES-VILLANOS

5.  Cuando creas login y/o usuarios: SERVER_PRINCIPAL_CHANGE_GROUP y DATABASE-PRINCIPAL-CHANGE-GROUP

6.  Cuando le cambias el password a un login: LOGIN_CHANGE_PASSWORD_GROUP

7.  Cuando ejecutas un comando pero suplantando a otro usuario (EXECUTE AS): DATABASE_PRINCIPAL_IMPERSONATION_GROUP

8.  Cuando cambias el propietario a un objeto de BD: DATABASE_OBJECTS_OWNERSHIP_CHANGE_GROUP

9.  Cuando haces un select en cualquier tabla de la BD elegida: SELECT

10. Cuando se cierra la sesión o se desconectan del servidor: LOGOUT_GROUP

11. Autentificación fallidas: FAILED_LOGIN_GROUP
*/


--CREAR SERVIDOR DE AUDITORIA
USE [master]

GO

CREATE SERVER AUDIT [AuditP2U6]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

GO

--HABILITAR AUDITORIA
ALTER SERVER AUDIT AuditP2U6
WITH (STATE = ON);

--CREAR ESPECIFIFICACIONES A NIVEL SERVIDOR
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [EspServerP2U6]
FOR SERVER AUDIT [AuditP2U6]
ADD (BACKUP_RESTORE_GROUP),
ADD (BATCH_STARTED_GROUP),
ADD (DATABASE_CHANGE_GROUP),
ADD (SERVER_PRINCIPAL_CHANGE_GROUP),
ADD (LOGIN_CHANGE_PASSWORD_GROUP),
ADD (LOGOUT_GROUP),
ADD (FAILED_LOGIN_GROUP)

GO

--HABILITAR ESPECIFIFICACIONES A NIVEL SERVIDOR
ALTER SERVER AUDIT SPECIFICATION EspServerP2U6
WITH (STATE = ON);

--CREAR ESPECIFIFICACIONES A NIVEL BD
USE [HeroesDelMundo]

GO

CREATE DATABASE AUDIT SPECIFICATION [EspBDP2U6]
FOR SERVER AUDIT [AuditP2U6]
ADD (INSERT ON OBJECT::[dbo].[HEROES] BY [dbo]),
ADD (INSERT ON OBJECT::[dbo].[VILLANOS] BY [dbo]),
ADD (DELETE ON OBJECT::[dbo].[PODERES_VILLANOS] BY [dbo]),
ADD (DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP),
ADD (DATABASE_PRINCIPAL_CHANGE_GROUP),
ADD (DATABASE_PRINCIPAL_IMPERSONATION_GROUP),
ADD (SELECT ON DATABASE::[HeroesDelMundo] BY [dbo])

GO

--HABILITAR ESPECIFIFICACIONES A BD
ALTER DATABASE AUDIT SPECIFICATION EspBDP2U6
WITH (STATE = ON);

--***************************PROBAR TODAS LAS ESP AL MENOS UNA VEZ***************************

--1. Backup y Restores
BACKUP DATABASE HeroesDelMundo
TO DISK = 'C:\ABD2022\U6\Comprobaciones\HeroesDelMundoCompleto1.BAK'
WITH
NAME = 'HeroesDelMundoCompleto1',
STATS = 10;

--2. Cuando se ejecuta un evento batchEXECUTE sp_clean_db_free_space HeroesDelMundo;
--3. Cuando se crea o elimina una BD
CREATE DATABASE PRUEBAS_AUDITORIA
ON PRIMARY
(
	NAME = 'PRUEBAS_AUDITORIA.MDF',
	FILENAME = 'C:\ABD2022\U6\BD\PRUEBAS_AUDITORIA.MDF'
)
LOG ON
(
	NAME = 'PRESTAMOS.LDF',
	FILENAME = 'C:\ABD2022\U6\BD\PRUEBAS_AUDITORIA.LDF'
);

DROP DATABASE PRUEBAS_AUDITORIA;

--4. Insert y Delete en una tabla determinada de una BD, elígela tu, tanto la BD como las tabla.
--INSERT PARA HEROES Y VILLANOS; PARA DELETE PARA PODERES-VILLANOS
INSERT INTO HEROES VALUES
('heroe', 'alias', 30, 1, 35, 'nada', 1, 'Marvel');

DELETE FROM PODERES_VILLANOS WHERE VIL_ID = 5;

--5. Cuando creas login y/o usuarios
CREATE LOGIN soyUnLogin WITH PASSWORD = '19400595';
CREATE USER soyUnUsuario FOR LOGIN soyUnLogin;

--6. Cuando le cambias el password a un login
ALTER LOGIN soyUnLogin WITH PASSWORD = '1234';

--7. Cuando ejecutas un comando pero suplantando a otro usuario (EXECUTE AS)
EXECUTE sp_addrolemember db_datareader, soyUnUsuario;
EXECUTE AS USER = 'soyUnUsuario';
SELECT * FROM dbo.VILLANOS;
REVERT

--8. Cuando cambias el propietario a un objeto de BD
CREATE SCHEMA hola;
ALTER USER soyUnUsuario WITH DEFAULT_SCHEMA = hola;
EXECUTE sp_changeobjectowner [dbo.VILLANOS], [hola];

--9. Cuando haces un select en cualquier tabla de la BD elegidaSELECT * FROM VILLANOS;
--10. Cuando se cierra la sesión o se desconectan del servidor

--11. Autentificación fallidas

--VER AUDITORIA
SELECT event_time,action_id,statement,database_name,server_principal_name
FROM fn_get_audit_file( 'C:\ABD2022\U6\Auditorias\AuditP2U6*.sqlaudit' , DEFAULT , DEFAULT);