--PRACTICA 8
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 22/03/22
--DESCRIPCION: Practicar la creación de indices.

--PONER EN USO LA BD
USE SUPERHERORES;

--NOTA: DETALLE EN FORMA DE COMENTARIOS PORQUE LOS CREASTE, COMO SE LLAMAN,--      DE QUE TIPO Y EL CAMPO O LOS CAMPOS QUE TIENE CADA INDICE DEL PUNTO 2 Y 3.

---1. CREA LOS SIGUIENTES INDICES PARA LA TABLA HEROES:

--1.1. UN INDICE CLUSTEREADO POR EL APODO.
ALTER TABLE PODEREs_HEROEs DROP CONSTRAINT [FK_PODHER_HEROE];
ALTER TABLE HEROEsVsVILLANOs DROP CONSTRAINT FK__RIVALES__HER_ID__59063A47;
ALTER TABLE HEROEs DROP CONSTRAINT PK_HEROES;
ALTER TABLE HEROEs ADD CONSTRAINT PK_HEROEs PRIMARY KEY NONCLUSTERED(HER_ID);
ALTER TABLE PODEREs_HEROEs
ADD CONsTRAINT FK_PODHER_HEROE  FOREIGN KEY (HER_ID) REFERENCEs HEROEs(HER_ID);
ALTER TABLE HEROEsVsVILLANOs
ADD CONsTRAINT FK__RIVALES__HER_ID__59063A47  FOREIGN KEY (HER_ID) REFERENCEs HEROEs(HER_ID);
--EL PRIMER PASO FUE ELIMINAR EL CONSTRAINT DE LLAVE PRIMARI QUE TENIA JUNTO CON LAS LLAVES FORANEAS,
--ESTO DEBIDO A QUE NO SE PODIA CREAR EL INDICE CLUSTERED POR EL ALIAS YA QUE LA LLAVE PRIMARIA 
--CREA UN INDICE CLUSTERED, Y SOLO SE PUEDE UNO POR TABLA.
CREATE CLUSTERED INDEX indice_apodoHeroes ON HEROES(HER_ALIAS);
--ESTE INDICE LO CREE DEL TIPO CLUSTERED PORQUE ES MEJOR TENER EL CAMPO APODO ORDENADO FISICAMENTE


--1.2. UN INDICE NO CLUSTEREADO PARA EL CAMPO DEL ID.
CREATE NONCLUSTERED INDEX indice_idHeroe ON HEROES(HER_ID);
--El indice se llama indice_idHeroe y es del tipo no cluster para el campo del id, lo cree porque
--pienso que dos personajes pueden tener el mismo nombre y seria mas facil para un programa buscar
--por id que por nombre o alias.


--1.3. UN INIDCE NO CLUSTEREADO PARA EL CAMPO DE NOMBRE DEL HEROE.
CREATE NONCLUSTERED INDEX indice_nombreHeroe ON HEROES(HER_NOMBRE);
--El indice se llama indice_nombreHeroe y es del tipo no cluster para el campo nombre, lo cree porque
--se suele buscar tambien bastante a un heroe por su nombre.

--2. CREA INDICES PARA LA TABLA ENEMIGOS.
CREATE NONCLUSTERED INDEX indice_idVillano ON VILLANOS(VIL_ID);
--El indice se llama indice_idVillano y es del tipo no cluster para el campo del id.
--lo cree porque si bien es cierto que cuando se realiza una busqueda directa se suele usar el nombre o el alias
--al momento de querer consultar todos los villanos mas populares el programa lo hara a traves del id.
--Esto debido a que pienso que dos personajes pueden tener el mismo nombre.
CREATE NONCLUSTERED INDEX indice_nombreVillano ON VILLANOS(VIL_NOMBRE);
--El indice se llama indice_nombreVillano para el campo nombre del villano, este indice lo cree
--porque los villanos se suelen buscar de forma directa a traves de su nombre.
CREATE NONCLUSTERED INDEX indice_aliasVillano ON VILLANOS(VIL_ALIAS);
--El indice se llama indice_aliasVillano para el campo nombre del villano, este indice lo cree
--porque los villanos se suelen buscar de forma directa a traves de su alias.

--3. CREA INDICES PARA LA TABLA LUGARES DE DEFENSA.
CREATE NONCLUSTERED INDEX indice_idTraje ON TRAJES(TRA_ID);
--El indice se llama indice_idTraje y es para el campo id del traje, lo cree porque
--pienso que los trajes mas comunes seran catalogados a traves de un programa por el id.
--Esto debido a que pienso que dos trajes pueden tener el mismo nombre.
CREATE NONCLUSTERED INDEX indice_fotoTraje ON TRAJES(TRA_FOTO);
--El indice se llama indice_fotoTraje para el campo de foto del traje, este indice lo cree porque
--un programa mostrara mas rapido una imagen de los trajes mas populares, y muchas veces
--los usuarios van a querer ver la imagen del traje de los personajes mas populares.
