--PRACTICA 8
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 29/04/22
--DESCRIPCION: Aprender la restauración de headers en superherores

--PONER EN USO LA BD master
USE master;

--RESTAURAR LOS ENCABEZADOS DE LOS BACKUP DE LA BD DE SUPERHERORES
RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\RespaldoFull_SUPERHERORES.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Dif1.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Full2.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Dif2.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Full3.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_Dif3.BAK';

RESTORE HEADERONLY
FROM DISK = 'C:\ABD2022\U4\SUPERHERORES_ResLog1.TRN';