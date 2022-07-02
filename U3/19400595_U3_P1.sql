--PRACTICA 1
--AUTOR: INZUNSA DIAZ CESAR ALEJANDRO
--NO. CONTROL: 19400595
--FECHA: 01/03/22
--DESCRIPCION: Aprender a crear esquemas


--CREACIÓN DE LA BD
CREATE DATABASE pruebasEsquemas
ON PRIMARY
(
	NAME = 'pruebasEsquemas.MDF',
	FILENAME = 'C:\ABD2022\U3\pruebasEsquemas.MDF'
)
LOG ON
(
NAME = 'pruebasEsquemas.LDF',
FILENAME ='C:\ABD2022\U3\pruebasEsquemas.LDF'
);

--PONER EN USO LA BD
USE pruebasEsquemas;

--CREAR TABLA EMPLEADOS
CREATE TABLE empleados(
	id INT PRIMARY KEY IDENTITY(1,1),
	RFC VARCHAR(15),
	nombre VARCHAR(100),
	apellido VARCHAR(100)
);

--VER EL ESQUEMA DE LA TABLA EMPLEADOS
SELECT SC.NAME AS ESQUEMA, O.NAME AS OBJETO FROM SYS.OBJECTS O
JOIN SYS.SCHEMAS SC
ON O.SCHEMA_ID = SC.SCHEMA_ID WHERE O.type = 'U';

--CREAR ESQUEMAS
CREATE SCHEMA MATERIALES;
CREATE SCHEMA RECURSOSHUMANOS;
CREATE SCHEMA OBRAS;

--VERIFICAR QUE LOS ESQUEMAS SE CREARON
SELECT * FROM SYS.SCHEMAS;

--CREAR TABLA INVENTARIOS EN EL ESQUEMA MATERIALES
CREATE TABLE MATERIALES.Inventario(
	idInventario INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(100),
	descripcion VARCHAR(MAX),
	unidadesExistentes INT,
	idTipoMateriales INT
);

--AGREGAR UN ID A LA TABLA EMPLEADOS
ALTER TABLE empleados ADD idArea SMALLINT NOT NULL;

--CREAR LA TABLA TIPO MATERIAL EN EL ESQUEMA DE MATERIALES
CREATE TABLE MATERIALES.TipoMaterial(
	idTipoMaterial INT IDENTITY(1,1) PRIMARY KEY,
	nombreTipoMaterial VARCHAR(50)
);

--TRANSFERIR AL ESQUEMA DE RECURSOSHUMANOS LA TABLA EMPLEADOS QUE SE ENCUENTRA EN EL ESQUEMA DBO
ALTER SCHEMA RECURSOSHUMANOS TRANSFER dbo.empleados;

--CREAR TABLA DE AREAS DENTRO DEL ESQUEMA DE RECURSOS HUMANOS
CREATE TABLE RECURSOSHUMANOS.Areas(
	idArea SMALLINT IDENTITY PRIMARY KEY,
	nombreArea VARCHAR(100)
);

--AGREGAR LLAVE FORANEA A LA TABLA DE INVENTARIO CON TIPO MATERIAL
ALTER TABLE MATERIALES.Inventario
ADD CONSTRAINT InventarioTipoMaterial
FOREIGN KEY (idTipoMateriales)
REFERENCES MATERIALES.TipoMaterial(idTipoMaterial);

--AGREGAR LLAVE FORANEA A LA TABLA DE EMPLEADOS CON AREAS
ALTER TABLE RECURSOSHUMANOS.empleados
ADD CONSTRAINT EmpleadosArea
FOREIGN KEY (idArea)
REFERENCES RECURSOSHUMANOS.Areas(idArea);

--INSERTAR DATOS EN LA TABLA DE TIPO MATERIAL
INSERT INTO MATERIALES.TipoMaterial VALUES
('Piedra'),
('Metal'),
('Organico'),
('Sinteticos'),
('Maquinaria para construccion');

--TAREA INSERTAR 30 MATERIALES.
INSERT INTO MATERIALES.Inventario VALUES
('Grava', 'Piedra partida', 50, 1),
('Adoquin', 'Ladrillo de piedra con el que se pavimentan algunas calzadas.', 50, 1),
('Marmol', 'Piedra con buena estetica, se emplea en revestimientos.', 50, 1),
('Pizarra', 'Alternativa a la teja en la edificación tradicional.', 50, 1),
('Caliza', 'Piedra usa frecuentemente antes para paredes y antes.', 50, 1),
('Arenisca', 'Piedra compuesta de arena cementada.', 50, 1),
('Cemento', 'Producto de la calcinación de piedra caliza y otros óxidos.', 50, 1),

('Aceros', 'empleado para estructuras', 50, 2),
('Aluminio', 'Piedra partida', 50, 2),
('Zinc', 'Se utiliza en cubiertas de todo tipo.', 50, 2),
('Titanio', 'revestimiento inoxidable de reciente aparición.', 50, 2),
('Cobre', 'esencialmente en instalaciones de electricidad y fontanería.', 50, 2),
('Varilla corrugada', 'Diseñado especialmente para construir elementos estructurales de hormigón armado.', 50, 2),
('Alambron', 'Resiste la corrosión, es maleable y su acabado es liso y brillante', 50, 2),
('Castillo', 'Son refuerzos que se ponen en las cubiertas, calas y el resto de elementos que se ponen a nivel superior en la etapa de cimentación.', 50, 2),

('Madera tratada', 'Se emplean en carpinteria general', 50, 3),
('Madera terciada', 'Es un tablero elaborado con finas chapas de madera reforzada pegadas', 50, 3),
('Linoleo', 'suelo laminar creado con aceite de lino y harinas de madera o corcho sobre una base de tela.', 50, 3),
('Madera de pino cepillada', 'Util para el contacto estructural con el suelo y agua dulce.', 50, 3),
('Madera de pino', 'Util para la fabricación de muebles, repisas o trabajos en construcción.', 50, 3),

('PVC', 'Generalmente es utilizado en tuberías de agua potable', 50, 4),
('Suelo de PVC o suelo vinilico', 'Revestimiento plástico utilizado en lugares sin excesivo tránsito que precisan una limpieza frecuente.', 50, 4),
('Poliestireno expandido', 'material de relleno de buen aislamiento térmico', 50, 4),
('Poliestireno extrusionado', 'aislante térmico impermeable', 50, 4),
('Polipropileno', 'Sellante en canalizaciones diversas', 50, 4),
('Poliuretano', 'en forma de espuma se emplea como aislante térmico', 50, 4),
('Silicona', 'usado principalmente como sellante e impermeabilizante.', 50, 4),
('Asfalto', 'En carreteras y como impermeabilizante en forma de lámina.', 50, 4),

('Revolvedora', 'Ayuda a mezclar concreto, estuco, yeso, mortero y otros materiales', 50, 5),
('Cortadora de concreto', 'Util en mantenimiento de autopistas, instalación de tuberías y terminado de pisos.', 50, 5);

--CREAR TABLA DE TIPO OBRA
CREATE TABLE OBRAS.TipoObra(
	idTipoObra INT IDENTITY PRIMARY KEY,
	nombreTipoObra VARCHAR(50)
);

--INSERTAR DATOS EN LA TABLA DE TIPO OBRA
INSERT INTO OBRAS.TipoObra VALUES
('Residencial'),
('Comercial'),
('Industrial');

--CREAR TABLA PROYECTO
CREATE TABLE OBRAS.Proyecto(
	idProyecto INT IDENTITY PRIMARY KEY,
	nombreProyecto VARCHAR(50),
	descripcionProyecto VARCHAR(100),
	idTipoObra INT REFERENCES OBRAS.TipoObra(idTipoObra)
);

--ACREGAR CAMPO IDTIPOMATERIAL A LA TABLA PROYECTO
ALTER TABLE OBRAS.Proyecto ADD idTipoMaterial INT;

--AGREGAR LA LLAVE FORANEA AL CAMPO ANTERIOR CON LA TABLA TIPOMATERIAL
ALTER TABLE OBRAS.Proyecto
ADD CONSTRAINT ProyectoMateriales
FOREIGN KEY (idTipoMaterial)
REFERENCES MATERIALES.TipoMaterial(idTipoMaterial);

--AGREGAR CAMPO IDEMPLADO A LA TABLA DE PROYECTO
ALTER TABLE OBRAS.Proyecto ADD idEmpleado INT;

--CREAR LA LLAVE FORANEA A LA TABLA DE PROYECTO CON EMPLEADOS
ALTER TABLE OBRAS.Proyecto
ADD CONSTRAINT ProyectoEmpleados
FOREIGN KEY (idEmpleado)
REFERENCES RECURSOSHUMANOS.empleados(id);

--INSERTAR DATOS DENTRO DE PROYECTO
INSERT INTO OBRAS.Proyecto VALUES
('Poca madera','Proyecto residencial', 1, 1, 6),
('Cabaña Lila','Proyecto residencial', 1, 2, 7),
('Casa del mar','Proyecto residencial', 1, 3, 8),
('Tienda de Smith','Proyecto residencial', 1, 4, 9),

('Taja','Proyecto comercial', 2, 5, 10),
('A Bocado','Proyecto comercial', 2, 1, 11),
('La Charola Plateada','Proyecto comercial', 2, 2, 12),

('Catedral de San Basilio','Proyecto industrial', 3, 3, 13),
('Arco de Medinaceli','Proyecto industrial', 3, 4, 14),
('Alpha Industries','Proyecto industrial', 3, 5, 15);

--INSERTAR EN LA TABLA AREAS
INSERT INTO RECURSOSHUMANOS.Areas VALUES
('Departamento Tecnico'),
('Departamento Financiero'),
('Departamento Comercial'),
('Departamento Atención al cliente');

--INSERTAR EN LA TABLA EMPLEADOS
INSERT INTO RECURSOSHUMANOS.empleados VALUES
('MAOO220303PR4', 'Mark', 'Oliva', 1),
('BABB220316BKA', 'Bartolome', 'Bueno', 2),
('DOAA2203161D3', 'Dolores', 'Arias', 3),
('SACC220316LJ4', 'Salvadora', 'Caamaño', 4),
('IASS220316TR9', 'Ignacio', 'Sempere', 1),
('CALL220316JF6', 'Carmela', 'Llopis', 1),
('HOCC220316659', 'Hortensia', 'Carretero', 2),
('EIAA220316PB3', 'Elias', 'Acuña', 3),
('RAAA220228I86', 'Rayan', 'Alvaro', 4),
('DOMM2201309N8', 'Dolores', 'Monge', 1);

--REALIZAR CONSULTA DE TODAS LAS TABLAS
SELECT * FROM OBRAS.Proyecto OP
INNER JOIN OBRAS.TipoObra OT ON (OP.idTipoObra = OT.idTipoObra)
INNER JOIN MATERIALES.TipoMaterial TM ON (OP.idTipoMaterial = TM.idTipoMaterial)
INNER JOIN MATERIALES.Inventario IM ON (TM.idTipoMaterial = IM.idTipoMateriales)
INNER JOIN RECURSOSHUMANOS.empleados RE ON (RE.id = OP.idEmpleado)
INNER JOIN RECURSOSHUMANOS.Areas RA ON (RA.idArea = RE.idArea)
ORDER BY OP.idProyecto;