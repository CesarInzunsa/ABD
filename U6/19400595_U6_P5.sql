--PRACTICA 5
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 16/05/22
--DESCRIPCION: Practicar la creacion y activacion auditorias

/*
En la base de datos CAMPEONATO DE AJEDREZ debe realizar lo siguiente:1.  Entrada de usuario exitosos y fallidos: SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP y FAILED_DATABASE_AUTHENTICATION_GROUP
2.  Select en todas las tablas: SELECT
3.  Execute en cualquier SP: EXECUTE
4.  Realización de respaldos: BACKUP_RESTORE_DATABASE
5.  Ejecución de una transacción: BATCH_STARTED_GROUP
6.  Cambio en el password de un role de aplicación: APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
7.  Cuando se modifique el modo de recuperación de la BD: ?????
8.  Cuando se modifique o se den permisos a los objetos de BD: DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
9.  Cuando agregues un miembro a un rol o lo quites: DATABASE_ROLE_MEMBER_CHANGE_GROUP
10. Cuando se ejecuta una transacción: BATCH_STARTED_GROUP
*/

--CREAR SERVIDOR DE AUDITORIA
USE [master]

GO

CREATE SERVER AUDIT [Auditoria_U6_P5]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias\Practica5'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

GO

--HABILITAR AUDITORIA
ALTER SERVER AUDIT Auditoria_U6_P5
WITH (STATE = ON);

--CREAR ESPECIFIFICACIONES DE LA AUDITORIA A NIVEL BD
USE [CAMPEONATO_DE_AJEDREZ]

GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAudit_U6_P5]
FOR SERVER AUDIT [Auditoria_U6_P5]
ADD (SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP),
ADD (FAILED_DATABASE_AUTHENTICATION_GROUP),
ADD (SELECT ON DATABASE::[CAMPEONATO_DE_AJEDREZ] BY [dbo]),
ADD (EXECUTE ON DATABASE::[CAMPEONATO_DE_AJEDREZ] BY [dbo]),
ADD (BACKUP_RESTORE_GROUP),
ADD (BATCH_STARTED_GROUP),
ADD (APPLICATION_ROLE_CHANGE_PASSWORD_GROUP),
ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP)

GO

--HABILITAR ESPECIFIFICACIONES DE LA AUDITORIA
ALTER DATABASE AUDIT SPECIFICATION DatabaseAudit_U6_P5
WITH (STATE = ON);

--***************************PROBAR TODAS LAS ESP AL MENOS UNA VEZ***************************
--1.  Entrada de usuario exitosos y fallidos: SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP y FAILED_DATABASE_AUTHENTICATION_GROUP

--2.  Select en todas las tablas: SELECT
SELECT * FROM BITACORAMOVTOS;
SELECT * FROM CARRERAS;
SELECT * FROM PARTICIPANTES;
SELECT * FROM RESULTADOS;
SELECT * FROM TIPO_CONCURSO;

--3.  Execute en cualquier SP: EXECUTE
EXECUTE sp_help;

--4.  Realización de respaldos: BACKUP_RESTORE_DATABASE
BACKUP DATABASE CAMPEONATO_DE_AJEDREZ
TO DISK = 'C:\ABD2022\U6\Comprobaciones\CAMPEONATO_DE_AJEDREZ_COMPLETO1.BAK'
WITH
NAME = 'CAMPEONATO_DE_AJEDREZ_COMPLETO1';

--5.  Ejecución de una transacción: BATCH_STARTED_GROUP
EXECUTE sp_help;

--6.  Cambio en el password de un role de aplicación: APPLICATION_ROLE_CHANGE_PASSWORD_GROUP
ALTER LOGIN soyUnLogin WITH PASSWORD = '1234';

--7.  Cuando se modifique el modo de recuperación de la BD: ?????
ALTER DATABASE CAMPEONATO_DE_AJEDREZ SET RECOVERY FULL;  

--8.  Cuando se modifique o se den permisos a los objetos de BD: DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
CREATE LOGIN soyUnLogin2 WITH PASSWORD = '19400595';
CREATE USER soyUnUsuario2 FOR LOGIN soyUnLogin2;
GRANT ALL ON DBO.CARRERAS TO soyUnUsuario2;

--9.  Cuando agregues un miembro a un rol o lo quites: DATABASE_ROLE_MEMBER_CHANGE_GROUP
EXECUTE sp_addrolemember db_datareader, soyUnUsuario2;

--10. Cuando se ejecuta una transacción: BATCH_STARTED_GROUP
EXECUTE sp_help;

--VER AUDITORIAS
SELECT event_time,action_id,statement,database_name,server_principal_name
FROM fn_get_audit_file( 'C:\ABD2022\U6\Auditorias\Practica5\Auditoria_U6_P5*.sqlaudit' , DEFAULT , DEFAULT);