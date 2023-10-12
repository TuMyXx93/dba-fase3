# Oracle Database 21c Express Edition

<br></br>

## **PRIMERA FORMA**
## *Abrimos: SQL plus*
### Ingresamos con el usuario sysdba: ```/as sysdba```
**Realizamos alteración para generar nuevos usuarios:**
```SQL
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
```
__Creamos el nuevo usuario:__
```SQL
CREATE USER mi_usuario IDENTIFIED BY mi_password;
```
**Especificamos Tablespaces:**
```SQL
ALTER USER mi_usuario DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
```
**Asignamos cuota en el Tablespace USERS:**
```SQL
ALTER USER mi_usuario QUOTA 500K ON USERS;
```
**Dar privilegios de iniciar sesión en la base de datos:**
```SQL
GRANT CREATE SESSION TO mi_usuario;
```

<br></br>

# **SEGUNDA FORMA**
## *Abrimos: SQL Plus*
### Ingresamos con el usuario system: ```system```
### Password: ```mi_password```
**Realizamos alteración para generar nuevos usuarios:**
```SQL
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE;
```
**Creamos el nuevo usuario, especificamos Tablespaces y asignamos cuota en el Tablespace USERS:**
```SQL
CREATE USER mi_usuario IDENTIFIED BY mi_password
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;
```
**Dar privilegios de iniciar sesión en la base de datos:**
```SQL
GRANT CREATE SESSION TO mi_usuario;
```
**Dar privilegios de crear y manipular objetos de base de datos, como tablas, vistas, secuencias, etc.:**
```SQL
GRANT RESOURCE TO mi_usuario;
```
**Establecer el rol RESOURCE como rol predeterminado para el usuario. El usuario tendrá automáticamente todos los privilegios asignados al rol RESOURCE:**
```SQL
ALTER USER mi_usuario DEFAULT ROLE RESOURCE;
```

<br></br>

**Todos los pasos anteriormente mencionados solo aplican para el entorno de Windows así como también los programas a utilizar.**

1. **Enlace para descargar** [Oracle Database 21c Express Edition](https://www.oracle.com/database/technologies/xe-downloads.html)
2. **Enlace para descargar** [SQL Developer](https://www.oracle.com/tools/downloads/sqldev-downloads.html)


<br></br>

