--PRACTICA 1
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 09/05/22
--DESCRIPCION: Aprender a crear y activar auditorias

--CREAR EL SERVIDOR DE AUDITORIA
USE [master]

GO

CREATE SERVER AUDIT [Auditoria1]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

GO

--ACTIVAR EL SERVIDOR DE AUDITORIAS
ALTER SERVER AUDIT Auditoria1
WITH
(
	STATE = ON
);

--***************************CREAR LAS ESPECIFICACIONES***************************--

--CREANDO ESPECIFICACIONES A NIVEL SERVIDOR:
--BACKUP_RESTORE_GROUP
--LOGIN_CHANGE_PASSWORD_GROUP
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [EspServAuditoria1]
FOR SERVER AUDIT [Auditoria1]
ADD (BACKUP_RESTORE_GROUP),
ADD (LOGIN_CHANGE_PASSWORD_GROUP)

GO

--ACTIVAR LA ESPECIFICACION A NIVEL SERVIDOR
ALTER SERVER AUDIT SPECIFICATION [EspServAuditoria1]
WITH
(
	STATE = ON
);

--CREANDO ESPECIFICACIONES A NIVEL BD:
--DELETE
--SELECT EN LA TABLA DE [REGISTRO_ENT_SAL]
USE [GUARDERIA]

GO

CREATE DATABASE AUDIT SPECIFICATION [EspBDAuditoria1]
FOR SERVER AUDIT [Auditoria1]
ADD (DELETE ON DATABASE::[GUARDERIA] BY [dbo]),
ADD (SELECT ON OBJECT::[dbo].[REGISTRO_ENT_SAL] BY [dbo])

GO

--ACTIVAR LA AUDITORIA A NIVEL BD
ALTER SERVER AUDIT SPECIFICATION [EspBDAuditoria1]
WITH
(
	STATE = ON
);

--***************************PROBAR TODAS LAS ESP AL MENOS UNA VEZ***************************

--COMPROBAR: BACKUP_RESTORE_GROUP
BACKUP DATABASE Guarderia
TO DISK = 'C:\ABD2022\U6\Comprobaciones\GuarderiaCompleto1.BAK'
WITH
NAME = 'GuarderiaCompleto1',
STATS = 10;

--COMPROBAR: LOGIN_CHANGE_PASSWORD_GROUP
ALTER LOGIN soyUnLogin WITH PASSWORD = '1234';

--COMPROBAR: DELETE
DELETE FROM GUARDERIA.DBO.ALUMNO WHERE ALU_ID = 975;

--COMPROBAR: SELECT EN LA TABLA DE [REGISTRO_ENT_SAL]
SELECT * FROM GUARDERIA.DBO.REGISTRO_ENT_SAL;

--VER AUDITORIA
SELECT event_time,action_id,statement,database_name,server_principal_name
FROM fn_get_audit_file( 'C:\ABD2022\U6\Auditorias\*.sqlaudit' , DEFAULT , DEFAULT);