--PUBLICADOR
--PRINCIPAL
--31/05/22


EXECUTE sp_get_distributor;

--QUITAR DISTRIBUCION
EXECUTE sp_dropdistributor 1;

--HACER DISTRUBUIDOR
USE master;
EXECUTE sp_adddistributor
@distributor = 'LAPTOP-F5RH6SNB',
@PASSWORD = '12345'
GO

EXECUTE sp_adddistributiondb
@database = 'distribution',
@data_folder = 'C:\Users\Public\Documents\replicacion',
@LOG_folder = 'C:\Users\Public\Documents\replicacion',
@security_mode = 1;

EXECUTE sp_adddistpublisher
@publisher = 'LAPTOP-F5RH6SNB',
@distribution_db = 'distribution',
@security_mode = 0,
@login = 'sa',
@password = 'admin123',
@working_directory = 'C:\Users\Public\Documents\replicacion';

USE GRANJA;

EXECUTE sp_replicationdboption
@dbname = 'GRANJA',
@optname = 'merge publish',
@value = 'true';

EXECUTE sp_addmergepublication
@publication = 'PUBLICACION',
@description = 'Publication merge',
@allow_push = 'true';

EXECUTE sp_addpublication_snapshot
@publication = 'PUBLICACION',
@frequency_type = 4,
@frequency_interval = 14,
@job_login = null,
@job_password = null,
@publisher_security_mode = 0,
@publisher_login = 'sa',
@publisher_password = 'admin123';

--agregar articulos a la publicacion
EXECUTE sp_addmergearticle
@publication = 'PUBLICACION',
@article = 'ESPECIES',
@source_owner = 'dbo',
@source_object = 'ESPECIES',
@force_reinit_subscription = 1,
@identityrangemanagementoption = 'auto',
@pub_identity_range = 10000,
@identity_range = 100,
@threshold = 80;

--PARA OTRA TABLA
EXECUTE sp_addmergearticle
@publication = 'PUBLICACION',
@article = 'ANIMALES',
@source_owner = 'dbo',
@source_object = 'ANIMALES',
@force_reinit_subscription = 1,
@identityrangemanagementoption = 'auto',
@pub_identity_range = 10000,
@identity_range = 100,
@threshold = 80;

--
EXECUTE sp_addmergearticle
@publication = 'PUBLICACION',
@article = 'ENTRADAS_SALIDAS',
@source_owner = 'dbo',
@source_object = 'ENTRADAS_SALIDAS',
@force_reinit_subscription = 1,
@identityrangemanagementoption = 'auto',
@pub_identity_range = 10000,
@identity_range = 100,
@threshold = 80;


--AGREGAR SUSCRIPTORES
EXECUTE sp_addmergesubscription
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-F5RH6SNB\SERVIDORABD2022',
@subscriber_db = 'Granja_R',
@subscriber_type = 'GLOBAL',
@subscription_priority = 50;

EXECUTE sp_addmergepushsubscription_agent
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-F5RH6SNB\SERVIDORABD2022',
@subscriber_db = 'Granja_R',
@job_password = null,
@subscriber_security_mode = 0,
@subscriber_login = 'sa',
@subscriber_password = 'admin123',
@frequency_type = 64;

--LAPTOP-L47NRHH9
EXECUTE sp_addmergesubscription
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-L47NRHH9',
@subscriber_db = 'GRANJA_R',
@subscriber_type = 'GLOBAL',
@subscription_priority = 50;

EXECUTE sp_addmergepushsubscription_agent
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-L47NRHH9',
@subscriber_db = 'GRANJA_R',
@job_password = null,
@subscriber_security_mode = 0,
@subscriber_login = 'sa',
@subscriber_password = '12345',
@frequency_type = 64;

--\\LAPTOP-LNQODOUR
EXECUTE sp_addmergesubscription
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-LNQODOUR',
@subscriber_db = 'Granja_R',
@subscriber_type = 'GLOBAL',
@subscription_priority = 50;

EXECUTE sp_addmergepushsubscription_agent
@publication = 'PUBLICACION',
@subscriber = 'LAPTOP-LNQODOUR',
@subscriber_db = 'Granja_R',
@job_password = null,
@subscriber_security_mode = 0,
@subscriber_login = 'sa',
@subscriber_password = '130290',
@frequency_type = 64;

--para que se sincronicen
EXECUTE sp_startpublication_snapshot
@publication = 'PUBLICACION';

--INSERTAR EN LA TABLA DE ANIMALES DESDE LA SEGUNDA INSTANCIA
INSERT INTO ANIMALES (NOMBREANIMAL, IDESPECIE, PESO, EDAD) VALUES
('CONEJITO', 1, 5, 5);

--ACTUALIZAR EL PESO Y LA EDAD DE UN ANIMAL
UPDATE ANIMALES SET
PESO = 10,
EDAD = 6
WHERE IDANIMAL = 3;

--VERIFICAR CAMBIOS CON UN SELECT
SELECT * FROM ANIMALES;

--AGREGAR UNA ESPECIE
INSERT INTO ESPECIES (NOMBREESPECIE, NOMBRECIENTIFICO, EXISTENCIA) VALUES
('CONEJITO', 'CONEJITO CIENTIFICO', 30);

--AGREGAR UNA SALIDA A LA ULTIMA ESPECIE EN LA TABLA ENTRADAS_SALIDAS
INSERT INTO ENTRADAS_SALIDAS (TIPO, CANTIDAD, IDESPECIE, MONTO) VALUES
('S', 50, 8, '5000');

--ELIMINAR UN ANIMAL DISTINTO POR SUSCRIPTOR
DELETE FROM ANIMALES WHERE IDANIMAL = 3;

--HACER UN SELECT EN TODAS LAS TABLAS
SELECT * FROM ANIMALES;
SELECT * FROM ENTRADAS_SALIDAS;
SELECT * FROM ESPECIES;