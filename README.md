# 👨‍💻 Sistema de Base de Datos para un Colegio

Este proyecto tiene como objetivo diseñar y gestionar las bases de datos para un sistema de información de un colegio. Se utilizan diferentes motores de bases de datos para comparar su implementación y demostrar el uso de **Docker** para la orquestación de servicios.

## 🚀 Tecnologías Utilizadas

* **Docker & Docker Compose:** Para la gestión de contenedores.
* **MySQL:** Motor de base de datos relacional.
* **PostgreSQL:** Motor de base de datos relacional.
* **OracleDB:** Motor de base de datos relacional.
* **Git & GitHub:** Para el control de versiones.


# 👨‍💻 Sistema de Base de Datos para un Colegio

Este proyecto tiene como objetivo diseñar y gestionar las bases de datos para un sistema de información de un colegio. Se utilizan diferentes motores de bases de datos para comparar su implementación y demostrar el uso de **Docker** para la orquestación de servicios.

## 🚀 Tecnologías Utilizadas

* **Docker & Docker Compose:** Para la gestión de contenedores.
* **MySQL:** Motor de base de datos relacional.
* **PostgreSQL:** Motor de base de datos relacional.
* **OracleDB:** Motor de base de datos relacional.
* **Git & GitHub:** Para el control de versiones.

# 🧠 Diseño de la Base de Datos

El diseño de la base de datos se basa en el modelo de entidad-relación (ERD) que se muestra a continuación.

### Diagrama de Entidad-Relación (ERD):

![diagrama](/assets/diagrama.png)

Descripción de las Entidades
* **Estudiantes:** Contiene información personal de los estudiantes.

* **Profesores:** Contiene información de los profesores.

* **Cursos:** Representa las materias que se imparten (e.g., Matemáticas, Historia).

* **Clases:** Representa una instancia específica de un curso, asignada a un profesor.

* **Inscripciones:** Conecta a los estudiantes con las clases en las que están inscritos.

* **Notas:** Guarda las calificaciones de los estudiantes para cada clase.



## 📁 Estructura del Proyecto

La estructura del proyecto está organizada para mantener separados los scripts de cada base de datos y la configuración de Docker.

```
├── db/
│   ├── mysql/
│   │   ├── schema.sql
│   │   └── data.sql
│   ├── postgres/
│   │   ├── schema.sql
│   │   └── data.sql
│   └── oracle/
│       ├── schema.sql
│       └── data.sql
├── .env.mysql
├── .env.postgres
├── .env.oracle
├── .gitignore
├── docker-compose.yml
└── README.md
```

## 🛠️ Cómo Iniciar el Proyecto

Como levantar las bases de datos en tu máquina local.

**1. Requisitos:**

Tener instalado [Docker](https://www.docker.com/) y anexo la Documentacion de [Docker Compose](https://docs.docker.com/compose/).

**2. Configuración del Entorno:**

Copia los archivos de variables de entorno de ejemplo para configurar las credenciales de cada base de datos. Estos archivos no deben ser subidos a Git.

```bash
cp .env.mysql.example .env.mysql
cp .env.postgres.example .env.postgres
cp .env.oracle.example .env.oracle
```

### Levantar los Contenedores
**Comando Bash**

``` docker-compose up -d ```

### Detener los Contenedores
**Comando Bash**

``` docker-compose down ```


# 🧪 Documentación de Pruebas de la Base de Datos


## 🎯 Objetivo de la Prueba

El objetivo principal es asegurar que los scripts de esquema (`schema.sql`) y de datos (`data.sql`) se ejecuten sin errores en cada motor de base de datos (MySQL, PostgreSQL, OracleDB), creando la estructura de tablas con datos de prueba realistas de forma automática.

## 📋 Entorno de Prueba

* **Sistema Operativo:** macOS, Windows, Linux
* **Docker Desktop:** Versión 4.x.x
* **Motores de Base de Datos:**
    * MySQL 8.0
    * PostgreSQL 15
    * Oracle-Free 23.4
* **Herramienta de Conexión:** DBeaver, MySQL Workbench, pgAdmin, SQL Developer.

## ✅ Casos de Prueba

Los siguientes casos de prueba verifican que la base de datos se inicialice correctamente y que los datos se inserten según lo esperado.

---

### **Caso de Prueba 1: Inicialización de la Estructura de la Base de Datos**

* **Descripción:** Verificar que las tablas `estudiantes`, `profesores`, `cursos`, `clases`, `inscripciones` y `notas` se creen sin errores para cada motor de base de datos.
* **Pasos de Prueba:**
    1.  Ejecutar `docker-compose up -d`.
    2.  Esperar a que todos los servicios estén en estado `healthy`.
    3.  Conectarse a cada base de datos con un cliente.
    4.  Ejecutar la consulta `SHOW TABLES;` (para MySQL), `\dt` (para PostgreSQL) o `SELECT table_name FROM user_tables;` (para Oracle).
* **Resultado Esperado:** Todas las tablas de la base de datos del colegio deben listarse sin errores de sintaxis.

---

### **Caso de Prueba 2: Inserción de Datos Semilla**

* **Descripción:** Verificar que los scripts de datos (`data.sql`) inserten el número esperado de registros aleatorios en cada tabla.
* **Pasos de Prueba:**
    1.  Asegurarse de que los contenedores estén levantados y los scripts de datos hayan sido ejecutados (`./init.sh`).
    2.  Conectarse a cada base de datos.
    3.  Ejecutar las siguientes consultas para verificar el conteo de registros:
        * `SELECT COUNT(*) FROM estudiantes;`
        * `SELECT COUNT(*) FROM profesores;`
        * `SELECT COUNT(*) FROM cursos;`
        * `SELECT COUNT(*) FROM clases;`
        * `SELECT COUNT(*) FROM inscripciones;`
        * `SELECT COUNT(*) FROM notas;`
* **Resultados Esperados:**
    * **estudiantes:** 20 registros
    * **profesores:** 5 registros
    * **cursos:** 5 registros
    * **clases:** 10 registros
    * **inscripciones:** 40 registros
    * **notas:** 40 registros

---

### **Caso de Prueba 3: Verificación de Integridad de Datos**

* **Descripción:** Validar que las claves foráneas y la lógica de generación de datos funcionen correctamente, asegurando que los datos sean coherentes entre las tablas.
* **Pasos de Prueba:**
    1.  Conectarse a cada base de datos.
    2.  Ejecutar consultas `JOIN` para verificar la relación entre las tablas.
* **Consultas de Ejemplo:**
    * **MySQL & PostgreSQL:**
        ```sql
        -- Obtener el nombre de los estudiantes y el curso en el que están inscritos
        SELECT 
            e.nombre,
            e.apellido,
            c.nombre AS curso
        FROM 
            estudiantes e
        JOIN 
            inscripciones i ON e.estudiante_id = i.estudiante_id
        JOIN 
            clases cl ON i.clase_id = cl.clase_id
        JOIN
            cursos c ON cl.curso_id = c.curso_id;
        ```
    * **Oracle:**
        ```sql
        -- Obtener el nombre de los estudiantes y el curso en el que están inscritos
        SELECT 
            e.nombre,
            e.apellido,
            c.nombre AS curso
        FROM 
            estudiantes e
        JOIN 
            inscripciones i ON e.estudiante_id = i.estudiante_id
        JOIN 
            clases cl ON i.clase_id = cl.clase_id
        JOIN
            cursos c ON cl.curso_id = c.curso_id;
        ```
* **Resultado Esperado:** La consulta debe devolver una lista de estudiantes con los cursos a los que están inscritos, confirmando que las relaciones entre las tablas funcionan.
* **Estado:** **PASA**

## 📝 Conclusiones de la Prueba

Todas las pruebas se completaron con éxito.
