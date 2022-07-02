--PRACTICA 3
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 16/05/22
--DESCRIPCION: Practicar la creacion y activacion auditorias


/*
--Crear una auditoria para la Seguridad del Servidor. Auditar:

1. Intentos de ingresos fallidos: FAILED_LOGIN_GROUP

2. Cambios de password a los logins: LOGIN_CHANGE_PASSWORD_GROUP

3. Creación o modificación de auditorias: AUDIT_CHANGE_GROUP

4. Cambios que se han dado a nivel de operación del servidor: DATABASE_OPERATION_GROUP

5. Los cierres de sesión de distintos logins: LOGOUT_GROUP

6. Cuando se otorgan, revocan o deniegan permisos sobre objetos de cualquier base de datos: DATABASE_OBJECT_PERMISSION_CHANGE_GROUP

7. Comandos DBCC: DBCC_GROUP

8. Cuando se cambien de propietario a una BD: DATABASE_OWNERSHIP_CHANGE_GROUP
*/


--CREAR SERVIDOR DE AUDITORIA
USE [master]

GO

CREATE SERVER AUDIT [Auditoria_U6_P3]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias\Practica3'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

GO

--HABILITAR AUDITORIA
ALTER SERVER AUDIT Auditoria_U6_P3
WITH (STATE = ON);

--CREAR ESPECIFIFICACIONES A NIVEL SERVIDOR
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [ServerAuditoria_U6_P3]
FOR SERVER AUDIT [Auditoria_U6_P3]
ADD (FAILED_LOGIN_GROUP),
ADD (LOGIN_CHANGE_PASSWORD_GROUP),
ADD (AUDIT_CHANGE_GROUP),
ADD (DATABASE_OPERATION_GROUP),
ADD (LOGOUT_GROUP),
ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (DBCC_GROUP),
ADD (DATABASE_OWNERSHIP_CHANGE_GROUP)

GO

--HABILITAR ESPECIFIFICACIONES A NIVEL SERVIDOR
ALTER SERVER AUDIT SPECIFICATION ServerAuditoria_U6_P3
WITH (STATE = ON);

--***************************PROBAR TODAS LAS ESP AL MENOS UNA VEZ***************************

--1. Intentos de ingresos fallidos: FAILED_LOGIN_GROUP

--2. Cambios de password a los logins: LOGIN_CHANGE_PASSWORD_GROUP
ALTER LOGIN soyUnLogin WITH PASSWORD = '1234';

--3. Creación o modificación de auditorias: AUDIT_CHANGE_GROUP
CREATE SERVER AUDIT [Auditoria_U6_Prueba1]
TO FILE 
(	FILEPATH = N'C:\ABD2022\U6\Auditorias\Pruebas'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
) WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)
GO

--4. Cambios que se han dado a nivel de operación del servidor: DATABASE_OPERATION_GROUP
CHECKPOINT 1;

--5. Los cierres de sesión de distintos logins: LOGOUT_GROUP

--6. Cuando se otorgan, revocan o deniegan permisos sobre objetos de cualquier base de datos: DATABASE_OBJECT_PERMISSION_CHANGE_GROUP
GRANT SELECT ON TRAJES TO soyUnUsuario;

--7. Comandos DBCC: DBCC_GROUP
DBCC CHECKCONSTRAINTS(HEROES);

--8. Cuando se cambien de propietario a una BD: DATABASE_OWNERSHIP_CHANGE_GROUP
EXEC sp_changedbowner 'soyUnLogin';

--VER AUDITORIAS
SELECT event_time,action_id,statement,database_name,server_principal_name
FROM fn_get_audit_file( 'C:\ABD2022\U6\Auditorias\Practica3\Auditoria_U6_P3*.sqlaudit' , DEFAULT , DEFAULT);