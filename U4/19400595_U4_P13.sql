--PRACTICA 13
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 02/05/22
--DESCRIPCION: Practicar la recuperacion de headers y restauracion de bd cambiando de ubicacion y nombre

--BORRAR BD
DROP DATABASE SUPERHERORES;

--RECUPERAR INFORMACION DEL RESPALDO 4
RESTORE FILELISTONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Full4.BAK';
--SUPERHERORES
--SUPERHERORES_log

--RESTAURAR LA BD PERO CAMBIANDO LA UBICACION
RESTORE DATABASE HeroesDelMundo
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Full4.BAK'
WITH
MOVE 'SUPERHERORES'
TO 'C:\ABD2022\U4\INFORMACION\HeroesDelMundo.MDF',
MOVE 'SUPERHERORES_log'
TO 'C:\ABD2022\U4\INFORMACION\HeroesDelMundo.LDF';