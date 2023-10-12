/*
Curso:      Administración de Bases de Datos
Grupo:      42
Programa:   Ingeniería de Sistemas
Autor:      Wilson Tumiña Tumiña
Fecha:      12/10/2023
*/

/*
4.
Se ha decidido agregar al servidor dos nuevos discos para almacenar datos,
se solicita que usted simule estos discos mediante carpetas y cree los
espacios de almacenamiento.
*/
-- Crear TABLESPACE VENTAS
CREATE TABLESPACE ventas
DATAFILE 'C:\app\fase3_paso4\disco1\ventas.dbf'
SIZE 1M
AUTOEXTEND ON NEXT 200K MAXSIZE 1400K
DEFAULT STORAGE
(
INITIAL 16K
NEXT 17K
MINEXTENTS 1
MAXEXTENTS 3
);

-- Crear TABLESPACE PEDIDOS
CREATE TABLESPACE pedidos
DATAFILE 'C:\app\fase3_paso4\disco2\pedidos.dbf'
SIZE 1M
AUTOEXTEND ON NEXT 100K MAXSIZE 2000K
DEFAULT STORAGE
(
INITIAL 16K
NEXT 17K
MINEXTENTS 1
MAXEXTENTS 3
);

-- Crear TABLESPACE FACTURACION
CREATE TABLESPACE facturacion
DATAFILE 'C:\app\fase3_paso4\disco3\facturacion.dbf'
SIZE 1M
AUTOEXTEND ON NEXT 100K MAXSIZE 5000K
DEFAULT STORAGE
(
INITIAL 16K
NEXT 17K
MINEXTENTS 1
MAXEXTENTS 3
);

-- Consultas de los Tablespaces creados
SELECT * FROM DBA_TABLESPACES;

SELECT * FROM DBA_DATA_FILES;


/*
6.
Realizar las consultas a las siguientes vistas del diccionario de datos en su SGBD:
DBA_PROFILES, DBA_ROLES, DBA_USERS, DBA_ROLE_PRIVS, DBA_TAB_PRIVS, DBA_SYS_PRIVS,
DBA_OBJECTS, DBA_POLICIES, DBA_OBJECT_TABLES, DBA_USTATS
*/
SELECT * FROM DBA_PROFILES;
SELECT * FROM DBA_ROLES;
SELECT * FROM DBA_USERS;
SELECT * FROM DBA_ROLE_PRIVS;
SELECT * FROM DBA_TAB_PRIVS;
SELECT * FROM DBA_SYS_PRIVS;
SELECT * FROM DBA_OBJECTS;
SELECT * FROM DBA_POLICIES;
SELECT * FROM DBA_OBJECT_TABLES;
SELECT * FROM DBA_USTATS;


/*
7.
Conectarse como usuario SYSTEM a la base de datos y crear un usuario llamado
“SU_NOMBRE_APELLIDO” autentificado por la base de datos. Indicar como "tablespace"
por defecto USERS y como "tablespace" temporal TEMP; asignar una cuota de
500K en el "tablespace" USERS.
*/
-- a. Nos conectamos con el usuario SYSTEM y su debido password

-- b. Realizamos alteración para generar nuevos usuarios:
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;

-- c. Creamos el usuario solicitado:
CREATE USER wilson_tumina IDENTIFIED BY "12345";

-- d. specificamos Tablespaces:
ALTER USER wilson_tumina DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;

-- e. Asignamos cuota en el Tablespace USERS:
ALTER USER wilson_tumina QUOTA 500K ON USERS;

-- Por ultimo realizamos la consulta de los usuarios creados
SELECT * FROM DBA_USERS;


/*
8.
Identificar qué privilegios de sistema, roles y privilegios sobre objetos tiene
concedidos el usuario creado en el punto anterior.
*/
-- Privilegios de sistema
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'wilson_tumina';

-- Roles
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'wilson_tumina';

-- Privilegios sobre objetos
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'wilson_tumina';


/*
10.
En la conexión con SYSTEM, otorgar el privilegio “CREATE SESSION” al usuario
creado por cada estudiante e intentar de nuevo la conexión con este.
*/
-- Damos privilegios de iniciar sesión en la base de datos:
GRANT CREATE SESSION TO wilson_tumina;


/*
11.
Cree un rol llamado MI_PROPIO_ROL y asígnele permisos de alterar, crear y
modificar tablas.
*/
-- a. Realizamos alteración para generar nuevos roles:
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;

-- b. Crear el rol
CREATE ROLE MI_PROPIO_ROL;

-- c. Asignar permisos al rol
GRANT CREATE ANY TABLE, ALTER ANY TABLE, DROP ANY TABLE TO MI_PROPIO_ROL;


/*
12.
Crear el siguiente usuario factura1394 y asignarle lo roles y privilegios o
permisos necesarios para operar objetos y asígnele el tablespace VENTAS
*/
-- a. Realizamos alteración para generar nuevos usuarios:
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;

-- b. Creamos el usuario solicitado:
CREATE USER factura1394 IDENTIFIED BY "12345";

-- c. Damos privilegios de iniciar sesión en la base de datos:
GRANT CREATE SESSION TO factura1394;

-- d. Damos privilegios de crear y manipular objetos de base de datos, como
--    tablas, vistas, secuencias, etc.
GRANT RESOURCE TO factura1394;

-- e. Establecer como rol predeterminado. Tendrá automáticamente todos los
--    privilegios asignados al rol RESOURCE.
ALTER USER factura1394 DEFAULT ROLE RESOURCE;

-- f. Asignamos el Tablespace VENTAS:
ALTER USER factura1394 DEFAULT TABLESPACE ventas;

-- g. Consultamos la correcta asignación del Tablaspace VENTAS:
SELECT username, default_tablespace FROM DBA_USERS WHERE USERNAME = 'FACTURA1394';


/*
13.
Mover las tablas creadas en la fase 2 al tablespace VENTAS
*/
-- a. Mover la tabla CLIENTES
ALTER TABLE clientes MOVE TABLESPACE ventas;

-- b. Mover la tabla FACTURAS
ALTER TABLE facturas MOVE TABLESPACE ventas;

-- c. Mover la tabla ORDENES
ALTER TABLE ordenes MOVE TABLESPACE ventas;

-- d. Mover la tabla PRODUCTO_ORDEN
ALTER TABLE producto_orden MOVE TABLESPACE ventas;

-- e. Mover la tabla PRODUCTOS
ALTER TABLE productos MOVE TABLESPACE ventas;

-- f. Mover la tabla VENDEDORES
ALTER TABLE vendedores MOVE TABLESPACE ventas;

-- Por ultimo realizamos la consulta de las tablas movidas al Tablespace VENTAS
SELECT * FROM DBA_TABLES WHERE TABLESPACE_NAME = 'VENTAS';


/*
14.
Se tiene la necesidad de optimizar las consultas a la base de datos, debido
que las consultas a la tabla de clientes están muy lentas así que se debe
crear un índice sobre esta tabla.
*/
-- a. Creamos el índice
CREATE INDEX idx_clientes ON clientes (identificacion);

-- b. Crear un índice en la columna ciudad_residencia de la tabla clientes
CREATE INDEX idx_clientes_ciudad ON clientes (ciudad_residencia);

-- c. Crear un índice en la columna fecha_nacimiento de la tabla clientes
CREATE INDEX idx_clientes_fecha_nacimiento ON clientes (fecha_nacimiento);

-- d. Consultamos la correcta creación del índice
SELECT * FROM DBA_INDEXES WHERE INDEX_NAME = 'IDX_CLIENTES';
SELECT * FROM DBA_INDEXES WHERE INDEX_NAME = 'idx_clientes_ciudad';
SELECT * FROM DBA_INDEXES WHERE INDEX_NAME = 'idx_clientes_fecha_nacimiento';


/*
15.
Cree un índice para optimizar las consultas de la tabla factura y la tabla
ordenes y Construya un script SQL donde se usen las sentencias COMMIT y
ROLLBACK
*/
-- Crear un índice en la columna id_cliente de la tabla facturas
CREATE INDEX idx_facturas_cliente ON facturas (id_cliente);

-- Crear un índice en la columna id_orden de la tabla ordenes
CREATE INDEX idx_ordenes_orden ON ordenes (id);

-- Iniciar una transacción
SAVEPOINT inicio_transaccion;

-- Suponiendo que tenemos una operación de inserción o actualización
INSERT INTO facturas (id, id_vendedor, id_cliente, id_orden, estado, fecha, valor) 
VALUES (405, 1006, 1011, 205, 'PENDIENTE', SYSDATE, 100.00);

-- Si la operación fue exitosa, confirmar la transacción
COMMIT;

-- Suponiendo que tenemos otra operación de inserción o actualización
UPDATE ordenes SET estado = 'COMPLETADO' WHERE id = 205;

-- Si hay un problema, revertir a inicio_transaccion
ROLLBACK TO inicio_transaccion;
