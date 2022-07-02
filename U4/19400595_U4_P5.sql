--PRACTICA 5
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 26/04/22
--DESCRIPCION: Practicar la creacion de backups

--PONER EN USO LA BD
USE pubs;

--CONTAR CUANTOS REGISTROS HAY EN CADA TABLA
SELECT COUNT(*) FROM authors;
SELECT COUNT(*) FROM discounts;
SELECT COUNT(*) FROM employee;
SELECT COUNT(*) FROM jobs;
SELECT COUNT(*) FROM pub_info;
SELECT COUNT(*) FROM publishers;
SELECT COUNT(*) FROM roysched;
SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM stores;
SELECT COUNT(*) FROM titleauthor;
SELECT COUNT(*) FROM titles;

--3. REALIZA UN RESPALDO COMPLETO DE LA BD ORIGINAL
BACKUP DATABASE pubs
TO DISK = 'C:\ABD2022\U4\Pubs_Completo1.BAK'
WITH
NAME = 'Pubs_Completo1',
DESCRIPTION = 'Primero respaldo completo';

--4. INSERTA 1000 REGISTROS EN LA BD, ELIGE UNA TABLA QUE SE PUEDA REALIZAR ESTA ACCI�N (PK AUTOINCREMENTAL)
INSERT INTO jobs VALUES
('Marketing Manager', 120, 200)
GO 1000

--5. REALIZA UN RESPALDO DIFERENCIAL CON AL MENOS 3 PARAMETROS
BACKUP DATABASE pubs
TO DISK = 'C:\ABD2022\U4\Pubs_Diferencial1.BAK'
WITH DIFFERENTIAL,
NAME = 'Pubs_Diferencial1',
DESCRIPTION = 'Se insertaron 1000 registros en jobs',
STATS = 10;

--6. ELIMINA UNA TABLA
DROP TABLE roysched;

--7. INSERTA UN AUTOR
INSERT INTO authors VALUES
('999-99-9999', 'Cesar', 'Inzunsa', '123456789123', '55 Hillsdale Bl.', 'Corvallis', 'OR', '97330', 1);

--8. REALIZA UN SEGUNDO RESPALDO DIFERENCIAL SIN COMPRIMIRLO, SOLO CON NAME, DESCRIPTION Y EXPIREDATE.
BACKUP DATABASE pubs
TO DISK = 'C:\ABD2022\U4\Pubs_Diferencial2.BAK'
WITH DIFFERENTIAL,
NAME = 'Pubs_Diferencial2',
DESCRIPTION = 'Se inserto un registro en authors',
EXPIREDATE = '2022-05-02';

--9. REALIZA UN RESPALDO DE LOG
BACKUP LOG pubs
TO DISK = 'C:\ABD2022\U4\Pubs_Log1.BAK'
WITH
NAME = 'Pubs_Log1',
DESCRIPTION = 'Primero respaldo del log';